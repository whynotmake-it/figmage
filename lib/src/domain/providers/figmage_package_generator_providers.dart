import 'dart:io';

import 'package:figmage/src/domain/models/figmage_settings.dart';
import 'package:figmage/src/domain/providers/design_token_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/shared/dart_symbol_conversion.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';

/// Provides the name of the generated package
final generatedPackageNameProvider = Provider.family<String, FigmageSettings>(
  (ref, settings) {
    final directoryName = basename(Directory(settings.path).absolute.path);
    return settings.config.packageName ??
        toDartPackageName(directoryName, defaultName: 'figmage_package');
  },
);

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

  final assets = await ref.watch(assetsProvider(settings).future);
  final logger = ref.watch(loggerProvider);

  final packageGenerator = ref.watch(figmagePackageGeneratorProvider);

  final generateColors = settings.config.colors.generate &&
      tokensByFileType.colorTokens.isNotEmpty;
  final generateTypography = settings.config.typography.generate &&
      tokensByFileType.typographyTokens.isNotEmpty;
  final generateNumbers = settings.config.numbers.generate &&
      tokensByFileType.numberTokens.isNotEmpty;
  final generateAssets = settings.config.assets.generate && assets.isNotEmpty;

  final dir = Directory(settings.path);
  final directoryName = basename(Directory(settings.path).absolute.path);
  final packageName = ref.watch(generatedPackageNameProvider(settings));

  if (packageName != directoryName) {
    logger.warn("The package name $packageName does not match the "
        "directory name $directoryName.");
  }
  final packageProgress =
      logger.progress("Generating package in ${settings.path}...");

  try {
    final files = await packageGenerator.generate(
      projectName: packageName,
      dir: dir,
      description: settings.config.packageDescription,
      useGoogleFonts: settings.config.typography.useGoogleFonts,
      generateColors: generateColors,
      generateTypography: generateTypography,
      generateAssets: generateAssets,
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
