import 'dart:io';
import 'package:figmage/src/command_runner.dart';
import 'package:figmage/src/data/repositories/figma_variables_repository.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage/src/domain/providers/figmage_package_generator_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/repositories/variables_repository.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

class _MockLogger extends Mock implements Logger {}

class _MockProgress extends Mock implements Progress {}

class _MockFigmaVariablesRepository extends Mock
    implements FigmaVariablesRepository {}

class _MockFigmagePackageGenerator extends Mock
    implements FigmagePackageGenerator {}

final _variableList = [
  const ColorVariable(
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
      '0:0': AliasData<int>(data: 4290117398),
      '1:0': AliasData<int>(data: 4286038042),
    },
  ),
];

final _colorValueMap = {
  'collection': {
    'dark': {'green': 4290117398},
    'light': {'green': 4286038042},
  },
};

void main() {
  group('forge', () {
    late ProviderContainer container;
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

      container = ProviderContainer(
        overrides: [
          loggerProvider.overrideWith((ref) => logger),
          variablesRepositoryProvider
              .overrideWith((ref) => figmaVariablesRepository),
          figmagePackageGeneratorProvider
              .overrideWith((ref) => figmagePackageGenerator),
        ],
      );

      commandRunner = FigmageCommandRunner(container);

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
      ).thenAnswer((_) async => _variableList);

      when(
        () => figmaVariablesRepository.createValueModeMap<int, ColorVariable>(
          variables: _variableList,
        ),
      ).thenAnswer((_) => _colorValueMap);

      when(() => progress.complete(any())).thenAnswer((_) {
        final message = _.positionalArguments.elementAt(0) as String?;
        if (message != null) progressLogs.add(message);
      });
      when(() => logger.progress(any())).thenReturn(progress);
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
