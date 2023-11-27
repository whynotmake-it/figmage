import 'package:args/args.dart';
import 'package:figmage/src/commands/shared/create_new_package/generation_notifier.dart';
import 'package:figmage/src/commands/shared/forge_settings_providers.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/repositories/variables_repository.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import '../../../../test_util/mock/mock_variables.dart';

class _MockLogger extends Mock implements Logger {}

class _MockProgress extends Mock implements Progress {}

class _MockVariablesRepository extends Mock implements VariablesRepository {}

class _MockArgResults extends Mock implements ArgResults {}

class _MockNotifier extends GenerationNotifier {
  @override
  Future<ExitCode> build(ArgResults arg) async {
    return ExitCode.success;
  }
}

void main() {
  group("GenerationNotifier", () {
    late ProviderContainer container;

    late _MockVariablesRepository variablesRepository;
    late _MockLogger logger;
    late _MockArgResults argResults;

    setUp(() {
      variablesRepository = _MockVariablesRepository();
      when(
        () => variablesRepository.getVariables(
          fileId: any(named: "fileId"),
          token: any(named: "token"),
        ),
      ).thenAnswer((_) async => mockVariables);
      logger = _MockLogger();
      when(() => logger.progress(any())).thenReturn(_MockProgress());

      argResults = _MockArgResults();

      container = ProviderContainer(
        overrides: [
          variablesRepositoryProvider
              .overrideWith((ref) => variablesRepository),
          loggerProvider.overrideWith((ref) => logger),
          settingsProvider.overrideWith(
            (ref, arg) => Future.value(
              (
                token: "token",
                fileId: "fileId",
                path: "path",
                config: const Config(
                  fileId: "fileId",
                  packageName: "packageName",
                ),
              ),
            ),
          ),
          generationStateProvider.overrideWith(GenerationNotifier.new),
        ],
      );
    });
    tearDown(() {
      container.dispose();
    });

    test('getVariables', () async {
      container.updateOverrides([
        generationStateProvider.overrideWith(_MockNotifier.new),
      ]);
      final sut = container.read(generationStateProvider(argResults).notifier);
      final settings = await container
          .read(settingsProvider((argResults: argResults)).future);

      // ! This is called in the build method, so we need to reset it
      verify(
        () => variablesRepository.getVariables(
          fileId: any(named: "fileId"),
          token: any(named: "token"),
        ),
      ).called(1);

      final result = await sut.getVariables(settings);

      expect(result, mockVariables);
      verify(
        () => variablesRepository.getVariables(
          fileId: any(named: "fileId", that: equals(settings.fileId)),
          token: any(named: "token", that: equals(settings.token)),
        ),
      ).called(1);
    });
  });
}
