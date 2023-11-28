import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:figmage/src/commands/shared/forge_settings_providers.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage/src/domain/providers/figmage_package_generator_providers.dart';
import 'package:figmage/src/domain/providers/generator_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/repositories/file_writer_repository.dart';
import 'package:figmage/src/domain/repositories/styles_repository.dart';
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

    final stylesAsync = await AsyncValue.guard(() => _getStyles(settings));
    if (stylesAsync is AsyncError) return ExitCode.usage;

    final allTokens = <DesignToken<dynamic>>[
      ...?variablesAsync.valueOrNull,
      ...?stylesAsync.valueOrNull,
    ];

    final generatedFilesAsync = await AsyncValue.guard(
      () => _generatePackage(settings, allTokens),
    );
    if (generatedFilesAsync is AsyncError) return ExitCode.usage;

    final codeByFiles = await AsyncValue.guard(
      () => _generateCodeForFiles(
        generatedFiles: generatedFilesAsync.value!,
        variables: allTokens,
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

  Future<List<Variable<dynamic>>> getVariables(
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

  Future<List<DesignStyle<dynamic>>> _getStyles(
    FigmageSettings settings,
  ) async {
    final logger = ref.read(loggerProvider);
    final stylesProgress = logger.progress("Fetching all styles...");
    try {
      final styles = await ref
          .read(
            stylesRepositoryProvider,
          )
          .getStyles(
            fileId: settings.fileId,
            token: settings.token,
          );
      switch (styles) {
        case []:
          stylesProgress.fail("No styles found");
          throw ArgumentError.value(
            styles,
            "styles",
            "No styles found in file ${settings.fileId}",
          );
        case [...]:
          stylesProgress.complete("Found ${styles.length} variables");
          return styles;
      }
    } catch (e) {
      stylesProgress.fail("Failed to fetch variables: $e");
      rethrow;
    }
  }

  /// Gets variables from the figma file, or throws an error if none are found.
  Future<Iterable<File>> _generatePackage(
    FigmageSettings settings,
    List<DesignToken<dynamic>> variables,
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
      packageProgress.complete("Generated package at ${settings.path} with "
          "${files.length} files");
      return files;
    } catch (e) {
      packageProgress.fail("Failed to generate package: $e");
      rethrow;
    }
  }

  /// Generates codes for all relevant files from [generatedFiles]
  Future<Map<File, String>> _generateCodeForFiles({
    required Iterable<File> generatedFiles,
    required List<DesignToken<dynamic>> variables,
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
    required List<DesignToken<dynamic>> variables,
    required GenerationSettings settings,
  }) async {
    final generator = ref.read(
      generatorProvider(
        (
          filename: basename(generatedFile.path),
          settings: settings,
          tokens: variables,
        ),
      ),
    );
    print(generator);
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
