import 'dart:async';

import 'package:args/args.dart';
import 'package:figmage/src/commands/shared/forge_settings_providers.dart';
import 'package:figmage/src/domain/models/figmage_settings.dart';
import 'package:figmage/src/domain/providers/design_token_providers.dart';
import 'package:figmage/src/domain/providers/figmage_package_generator_providers.dart';
import 'package:figmage/src/domain/providers/file_writer_providers.dart';
import 'package:figmage/src/domain/providers/generator_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/providers/post_generation_providers.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:riverpod/riverpod.dart';

/// Provides the [GenerationNotifier] state
final generationStateProvider = AsyncNotifierProvider.autoDispose
    .family<GenerationNotifier, ExitCode, ArgResults>(
  GenerationNotifier.new,
);

/// The notifier for the forge command
class GenerationNotifier
    extends AutoDisposeFamilyAsyncNotifier<ExitCode, ArgResults> {
  @override
  Future<ExitCode> build(ArgResults arg) async {
    final logger = ref.watch(loggerProvider);

    final FigmageSettings settings;

    try {
      settings = await ref.watch(settingsProvider((argResults: arg)).future);
    } catch (e) {
      logger.err("Not all settings are present: $e");
      rethrow;
    }

    await ref.watch(
      filteredTokensProvider(settings).future,
    );
    final generatedFiles = await ref.watch(
      generatedPackageProvider(settings).future,
    );

    final generators = await ref.watch(generatorsProvider(settings).future);

    // write the files
    await ref.watch(
      fileWriterProvider({
        for (final (file, generator) in generators) file: generator.generate(),
      }).future,
    );

    try {
      await ref.watch(postGenerationTasksProvider(generatedFiles).future);
    } catch (e) {
      logger.warn("Failed to run post generation tasks: $e");
    }

    return ExitCode.success;
  }
}
