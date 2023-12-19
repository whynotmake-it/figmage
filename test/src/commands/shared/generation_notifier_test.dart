import 'package:args/args.dart';
import 'package:figmage/src/commands/shared/forge_settings_providers.dart';
import 'package:figmage/src/commands/shared/generation_notifier.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/tokens_by_file_type/tokens_by_type.dart';
import 'package:figmage/src/domain/providers/design_token_providers.dart';
import 'package:figmage/src/domain/providers/figmage_package_generator_providers.dart';
import 'package:figmage/src/domain/providers/file_writer_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/repositories/variables_repository.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import '../../../test_util/mock/mock_variables.dart';

class _MockLogger extends Mock implements Logger {}

class _MockProgress extends Mock implements Progress {}

class _MockVariablesRepository extends Mock implements VariablesRepository {}

class _MockArgResults extends Mock implements ArgResults {}

void main() {
  group("GenerationNotifier", () {
    late List<Override> overrides;
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
      overrides = [
        variablesRepositoryProvider.overrideWith((ref) => variablesRepository),
        generatedPackageProvider.overrideWith((ref, arg) => Future.value({})),
        fileWriterProvider.overrideWith((ref, args) => Future.value(args.keys)),
        loggerProvider.overrideWith((ref) => logger),
        filteredTokensProvider.overrideWith((ref, arg) => const TokensByType()),
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
      ];
      container = ProviderContainer(
        overrides: overrides,
      );
    });
    tearDown(() {
      container.dispose();
    });

    test('returns success Exit Code', () async {
      final result =
          await container.read(generationStateProvider(argResults).future);

      expect(result, ExitCode.success);
    });
  });
}
