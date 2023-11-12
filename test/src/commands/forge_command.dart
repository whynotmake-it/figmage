import 'dart:io';
import 'package:figmage/src/command_runner.dart';
import 'package:figmage/src/data/repositories/figma_variables_repository.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockLogger extends Mock implements Logger {}

class _MockProgress extends Mock implements Progress {}

class _MockFigmaVariablesRepository extends Mock
    implements FigmaVariablesRepository {}

class _MockFigmagePackageGenerator extends Mock
    implements FigmagePackageGenerator {}

void main() {
  group('forge', () {
    final variableList = [
      ColorVariable(
        id: 'VariableID:1:2',
        name: 'green',
        remote: false,
        key: '26a211e627a2da8a80c0f06e0b776ba97a8780e3',
        variableCollectionId: 'VariableCollectionId:0:3',
        variableCollectionName: 'collection',
        resolvedType: 'COLOR',
        description: '',
        hiddenFromPublishing: false,
        scopes: ['ALL_SCOPES'],
        codeSyntax: {},
        collectionModeNames: {'0:0': 'dark', '1:0': 'light'},
        valuesByMode: {
          '0:0': const AliasData<int>(data: 4290117398),
          '1:0': const AliasData<int>(data: 4286038042),
        },
      ),
    ];

    final colorValueMap = {
      'collection': {
        'dark': {'green': 4290117398},
        'light': {'green': 4286038042},
      },
    };

    late Logger logger;
    late FigmageCommandRunner commandRunner;
    late FigmaVariablesRepository figmaVariablesRepository;
    late FigmagePackageGenerator figmagePackageGenerator;

    setUpAll(() {
      registerFallbackValue(Directory('/dummy/directory'));
    });
    setUp(() {
      final progress = _MockProgress();
      final progressLogs = <String>[];
      logger = _MockLogger();
      figmaVariablesRepository = _MockFigmaVariablesRepository();
      figmagePackageGenerator = _MockFigmagePackageGenerator();
      commandRunner = FigmageCommandRunner(
        logger: logger,
        figmaVariablesRepository: figmaVariablesRepository,
        figmagePackageGenerator: figmagePackageGenerator,
        appendCodeEntriesToFile: (entries, path) {},
      );

      // Stub the package generator behavior
      // Stub the package generator behavior
      when(
        () => figmagePackageGenerator.generate(
          projectName: any(named: 'projectName'),
          dir: any(named: 'dir'),
          description: any(named: 'description'),
        ),
      ).thenAnswer((_) async {
        // Return the desired value, which is a FutureOr<Iterable<File>>
        return <File>[File('mockedFile.txt')];
      });

      // Stub the variables repository to return dummy variables
      when(
        () => figmaVariablesRepository.getVariables(
          fileId: any(named: 'fileId'),
          token: any(named: 'token'),
        ),
      ).thenAnswer((_) async => variableList);

      when(
        () => figmaVariablesRepository.createValueModeMap<int, ColorVariable>(
          variables: variableList,
        ),
      ).thenAnswer((_) => colorValueMap);

      when(() => progress.complete(any())).thenAnswer((_) {
        final message = _.positionalArguments.elementAt(0) as String?;
        if (message != null) progressLogs.add(message);
      });
      when(() => logger.progress(any())).thenReturn(progress);
    });

    test('successfully generates package and appends color tokens', () async {
      final exitCode = await commandRunner.run(
        ['forge', '--token=token', '--fileId=fileId'],
      );
      verify(() => logger.progress('Generating package')).called(1);
      verify(
        () => figmagePackageGenerator.generate(
          projectName: any(named: 'projectName'),
          dir: any(named: 'dir'),
          description: any(named: 'description'),
        ),
      ).called(1);
      expect(exitCode, equals(ExitCode.success.code));
    });

    test('requires both token and fileId', () async {
      final exitCode = await commandRunner.run(['forge']);
      expect(exitCode, equals(ExitCode.usage.code));
      verify(() => logger.err('Both token and fileId are required.')).called(
        1,
      );
    });

    test('tells user how to use command when wrong arguments provided',
        () async {
      final exitCode = await commandRunner.run(['forge', '-p']);
      verify(
        () => logger.err('Could not find an option or flag "-p".'),
      ).called(1);
      expect(exitCode, equals(ExitCode.usage.code));
    });
  });
}
