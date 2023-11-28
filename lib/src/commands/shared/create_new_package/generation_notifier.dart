import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:figmage/src/commands/shared/forge_settings_providers.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage/src/domain/providers/figmage_package_generator_providers.dart';
import 'package:figmage/src/domain/providers/generator_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/repositories/file_writer_repository.dart';
import 'package:figmage/src/domain/repositories/variables_repository.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart';
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
    final logger = ref.read(loggerProvider);

    final FigmageSettings settings;

    try {
      settings = await ref.watch(settingsProvider((argResults: arg)).future);
    } catch (e) {
      logger.err("Not all settings are present: $e");
      return ExitCode.usage;
    }

    final variablesAsync = await AsyncValue.guard(() => getVariables(settings));
    if (variablesAsync is AsyncError) return ExitCode.usage;

    final generatedFilesAsync = await AsyncValue.guard(
      () => _generatePackage(settings, variablesAsync.value!),
    );
    if (generatedFilesAsync is AsyncError) return ExitCode.usage;

    final codeByFiles = await AsyncValue.guard(
      () => _generateCodeForFiles(
        generatedFiles: generatedFilesAsync.value!,
        variables: variablesAsync.value!,
        config: settings.config,
      ),
    );
    if (generatedFilesAsync is AsyncError) return ExitCode.usage;

    final writeResult = await AsyncValue.guard(
      () async => _writeToFiles(codeByFiles.value!),
    );
    if (writeResult is AsyncError) return ExitCode.usage;

    return ExitCode.success;
  }

  /// Gets variables from the figma file, or throws an error if none are found.

  Future<List<Variable>> getVariables(
    FigmageSettings settings,
  ) async {
    final logger = ref.read(loggerProvider);
    final varProgress = logger.progress("Fetching all variables...");
    try {
      final variables = await ref
          .read(
            variablesRepositoryProvider,
          )
          .getVariables(
            fileId: settings.fileId,
            token: settings.token,
          );
      switch (variables) {
        case []:
          varProgress.fail("No variables found");
          throw ArgumentError.value(
            variables,
            "variables",
            "No variables found in file ${settings.fileId}",
          );
        case [...]:
          varProgress.complete("Found ${variables.length} variables");
          return variables;
      }
    } catch (e) {
      varProgress.fail("Failed to fetch variables: $e");
      rethrow;
    }
  }

  /// Gets variables from the figma file, or throws an error if none are found.
  Future<Iterable<File>> _generatePackage(
    FigmageSettings settings,
    List<Variable> variables,
  ) async {
    final logger = ref.read(loggerProvider);
    final packageProgress = logger.progress("Generating package...");
    try {
      final files = await ref
          .read(
            figmagePackageGeneratorProvider,
          )
          .generate(
            projectName: settings.config.packageName,
            dir: Directory(settings.path),
            description: settings.config.packageDescription,
            generateColors: settings.config.colors.generate,
            generateNumbers: settings.config.numbers.generate,
            // TODO(tim): support better
            generatePaddings: settings.config.numbers.generate,
            generateSpacers: settings.config.numbers.generate,
            // TODO(tim): support at all
            generateTypography: false,
            generateStrings: false,
            generateBools: false,
            generateRadii: false,
          );
      packageProgress.complete("Generated package at ${settings.path}");
      return files;
    } catch (e) {
      packageProgress.fail("Failed to generate package: $e");
      rethrow;
    }
  }

  /// Generates codes for all relevant files from [generatedFiles]
  Future<Map<File, String>> _generateCodeForFiles({
    required Iterable<File> generatedFiles,
    required List<Variable> variables,
    required Config config,
  }) async {
    final logger = ref.read(loggerProvider);
    final codeProgress = logger.progress("Generating code...");
    try {
      final allFiles = await Future.wait(
        [
          for (final file in generatedFiles)
            if (_getSettingsForFile(file, config) case final settings?)
              _generateForFile(
                generatedFile: file,
                variables: variables,
                settings: settings,
              ),
        ],
      );
      final result = {
        for (final file in allFiles)
          if (file != null) file.$1: file.$2,
      };
      codeProgress.complete("Generated code for ${result.length} files");
      return result;
    } catch (_) {
      codeProgress.fail("Failed to generate code");
      rethrow;
    }
  }

  /// Generates code for a single file
  Future<(File, String)?> _generateForFile({
    required File generatedFile,
    required List<Variable> variables,
    required GenerationSettings settings,
  }) async {
    final generator = ref.read(
      generatorProvider(
        (
          filename: basename(generatedFile.path),
          settings: settings,
          variables: variables,
        ),
      ),
    );
    if (generator == null) return null;
    return (generatedFile, generator.generate());
  }

  /// Writes the generated code to the files
  Iterable<File> _writeToFiles(Map<File, String> codeByFiles) {
    final logger = ref.read(loggerProvider);
    final writeProgress = logger.progress("Writing files...");
    final repo = ref.read(fileWriterRepositoryProvider);
    try {
      final files = repo.writeFiles(codeByFiles: codeByFiles);
      writeProgress.complete("Wrote ${files.length} files");
      return files;
    } catch (_) {
      writeProgress.fail("Failed to write files");
      rethrow;
    }
  }

  GenerationSettings? _getSettingsForFile(File file, Config config) {
    final type = TokenFileType.tryFromFilename(basename(file.path));
    return config.getForTokenType(type);
  }
}
