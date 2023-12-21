import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/color_theme_extension_generator.dart';
import 'package:figmage/src/data/generators/number_theme_extension_generator.dart';
import 'package:figmage/src/data/generators/padding_generator.dart';
import 'package:figmage/src/data/generators/spacer_generator.dart';
import 'package:figmage/src/data/generators/text_style_theme_extension_generator.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/models/figmage_settings.dart';
import 'package:figmage/src/domain/models/tokens_by_file_type/tokens_by_type.dart';
import 'package:figmage/src/domain/providers/design_token_providers.dart';
import 'package:figmage/src/domain/providers/figmage_package_generator_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/util/token_filter_x.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';

/// Provides a [ThemeClassGenerator] based on the file type, variables and
/// settings, if there is a supported generator.
final generatorsProvider =
    FutureProvider.family<Map<File, ThemeClassGenerator>, FigmageSettings>(
  (ref, settings) async {
    final logger = ref.watch(loggerProvider);
    final tokensByType =
        await ref.watch(filteredTokensProvider(settings).future);
    final files = await ref.watch(generatedPackageProvider(settings).future);

    final typesByFile = <File, TokenFileType>{
      for (final file in files)
        if (file.tokenFileType case final type?) file: type,
    };

    final progress = logger.progress(
      "Generating theme classes for ${typesByFile.length} files...",
    );

    final generatorsByFile = <File, ThemeClassGenerator?>{
      for (final MapEntry(key: file, value: type) in typesByFile.entries)
        file: switch ((type, tokensByType)) {
          (
            TokenFileType.color,
            TokensByType(colorTokens: Iterable(isEmpty: false)),
          ) =>
            ColorThemeExtensionGenerator(
              className: type.className,
              valuesByNameByMode: tokensByType.colorTokens.valuesByNameByMode,
            ),
          (
            TokenFileType.typography,
            TokensByType(typographyTokens: Iterable(isEmpty: false)),
          ) =>
            TextStyleThemeExtensionGenerator(
              className: type.className,
              valuesByNameByMode:
                  tokensByType.typographyTokens.valuesByNameByMode,
              useGoogleFonts: settings.config.typography.useGoogleFonts,
            ),
          (
            TokenFileType.numbers,
            TokensByType(numberTokens: Iterable(isEmpty: false)),
          ) =>
            NumberThemeExtensionGenerator(
              className: type.className,
              valuesByNameByMode: tokensByType.numberTokens.valuesByNameByMode,
            ),
          (
            TokenFileType.spacers,
            TokensByType(numberTokens: Iterable(isEmpty: false)),
          ) =>
            SpacerGenerator(
              className: type.className,
              numberReference: refer(
                TokenFileType.numbers.className,
                TokenFileType.numbers.filename,
              ),
              valueNames: tokensByType.numberTokens.map((t) => t.name),
            ),
          (
            TokenFileType.paddings,
            TokensByType(numberTokens: Iterable(isEmpty: false)),
          ) =>
            PaddingGenerator(
              className: type.className,
              numberReference: refer(
                TokenFileType.numbers.className,
                TokenFileType.numbers.filename,
              ),
              valueNames: tokensByType.numberTokens.map((t) => t.name),
            ),
          (TokenFileType.radii, _) => null,
          (TokenFileType.strings, _) => null,
          (TokenFileType.bools, _) => null,
          _ => null
        },
    };

    final validGenerators = {
      for (final MapEntry(key: file, value: generator)
          in generatorsByFile.entries)
        if (generator != null) file: generator,
    };
    progress.complete(
      "Generated ${validGenerators.length} theme classes from tokens.",
    );
    return validGenerators;
  },
);

extension on File {
  TokenFileType? get tokenFileType => TokenFileType.tryFromFilename(
        basename(path),
      );
}
