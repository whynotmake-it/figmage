import 'dart:io';

import 'package:figmage/src/domain/models/figmage_settings.dart';
import 'package:figmage/src/domain/providers/design_token_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:riverpod/riverpod.dart';

/// Provides the [FigmagePackageGenerator] instance.
final figmagePackageGeneratorProvider =
    Provider((ref) => const FigmagePackageGenerator());

/// Generates a package with the [FigmagePackageGenerator] and returns
/// the generated files.
final generatedPackageProvider =
    FutureProvider.family<Iterable<File>, FigmageSettings>(
        (ref, settings) async {
  final tokensByFileType =
      await ref.watch(filteredTokensProvider(settings).future);
  final logger = ref.watch(loggerProvider);

  final packageGenerator = ref.watch(figmagePackageGeneratorProvider);

  final generateColors = settings.config.colors.generate &&
      tokensByFileType.colorTokens.isNotEmpty;
  final generateTypography = settings.config.typography.generate &&
      tokensByFileType.typographyTokens.isNotEmpty;
  final generateNumbers = settings.config.numbers.generate &&
      tokensByFileType.numberTokens.isNotEmpty;
  final packageProgress = logger.progress("Generating package...");

  try {
    final files = await packageGenerator.generate(
      projectName: settings.config.packageName,
      dir: Directory(settings.path),
      description: settings.config.packageDescription,
      generateColors: generateColors,
      generateTypography: generateTypography,
      generateNumbers: generateNumbers,
      // TODO(tim): support better
      generatePaddings: generateNumbers,
      generateSpacers: generateNumbers,
      // TODO(tim): support at all
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
});
