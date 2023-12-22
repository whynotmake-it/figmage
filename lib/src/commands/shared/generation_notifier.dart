import 'dart:async';

import 'package:args/args.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:figmage/src/commands/shared/forge_settings_providers.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
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
      logger.err("Not all settings are present ($e)");
      rethrow;
    }

    try {
      await ref.watch(
        filteredTokensProvider(settings).future,
      );
    } catch (e) {
      logger
        ..err("Neither styles nor variables could be obtained from file "
            "${settings.fileId}")
        ..info("Make sure the file's library is published.");
      rethrow;
    }

    final generatedFiles = await ref.watch(
      generatedPackageProvider(settings).future,
    );

    final generatorsByFiles =
        await ref.watch(generatorsProvider(settings).future);
    final resultsByFile = {
      for (final MapEntry(key: file, value: generators)
          in generatorsByFiles.entries)
        file: [
          for (final generator in generators) generator.generate(),
        ],
    };

    final libraryByFile = resultsByFile.map((file, results) {
      final libraryBuilder = LibraryBuilder();
      for (final result in results) {
        libraryBuilder.body.add(result.$class);
        libraryBuilder.body.add(result.$extension);
      }
      return MapEntry(file, libraryBuilder.build());
    });

    final dartfmt = DartFormatter();
    final emitter = DartEmitter(
      allocator: Allocator(),
      useNullSafetySyntax: true,
      orderDirectives: true,
    );

    final codeByFile = libraryByFile.map((file, library) {
      final codeString = '''
      ${ThemeClassGenerator.generatedFilePrefix}


      ${library.accept(emitter)}
    ''';
      return MapEntry(file, dartfmt.format(codeString));
    });

    // write the files
    await ref.watch(
      fileWriterProvider(codeByFile).future,
    );

    try {
      await ref.watch(postGenerationTasksProvider(generatedFiles).future);
    } catch (e) {
      logger.warn("Failed to run post generation tasks: $e");
    }

    return ExitCode.success;
  }
}
