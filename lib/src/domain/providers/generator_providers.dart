import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:figmage/src/data/generators/color_theme_extension_generator.dart';
import 'package:figmage/src/data/generators/generator_util.dart';
import 'package:figmage/src/data/generators/number_theme_extension_generator.dart';
import 'package:figmage/src/data/generators/padding_generator.dart';
import 'package:figmage/src/data/generators/spacer_generator.dart';
import 'package:figmage/src/data/generators/text_style_theme_extension_generator.dart';
import 'package:figmage/src/data/util/converters/string_dart_conversion_x.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/models/design_token.dart';
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
final generatorsProvider = FutureProvider.family<
    Map<File, Iterable<ThemeClassGenerator>>, FigmageSettings>(
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

    final generatorsByFile = <File, Iterable<ThemeClassGenerator>>{
      for (final MapEntry(key: file, value: type) in typesByFile.entries)
        file: _createGeneratorsByFile(
          type: type,
          tokens: tokensByType,
          settings: settings,
        ),
    };

    progress.complete(
    );
    return generatorsByFile;
  },
);

Iterable<ThemeClassGenerator> _createGeneratorsByFile({
  required TokenFileType type,
  required TokensByType tokens,
  required FigmageSettings settings,
}) {
  final generators = <ThemeClassGenerator>[];
  if (type == TokenFileType.color && tokens.colorTokens.isNotEmpty) {
    final groupedTokens =
        groupBy(tokens.colorTokens, (DesignToken dt) => dt.collectionName);
    generators.addAll(
      groupedTokens.entries.map(
        (tokensEntry) => ColorThemeExtensionGenerator(
          className: convertToValidClassName(
            "${type.className}${tokensEntry.key.toTitleCase}",
          ),
          valuesByNameByMode: tokensEntry.value.valuesByNameByMode,
        ),
      ),
    );
  } else if (type == TokenFileType.typography &&
      tokens.typographyTokens.isNotEmpty) {
    final groupedTokens = groupBy(
      tokens.typographyTokens,
      (DesignToken dt) => dt.collectionName,
    );
    generators.addAll(
      groupedTokens.entries.map(
        (tokensEntry) => TextStyleThemeExtensionGenerator(
          className: convertToValidClassName(
            "${type.className}${tokensEntry.key.toTitleCase}",
          ),
          valuesByNameByMode: tokensEntry.value.valuesByNameByMode,
          useGoogleFonts: settings.config.typography.useGoogleFonts,
        ),
      ),
    );
  } else if (type == TokenFileType.numbers && tokens.numberTokens.isNotEmpty) {
    final groupedTokens =
        groupBy(tokens.numberTokens, (DesignToken dt) => dt.collectionName);

    generators.addAll(
      groupedTokens.entries.map(
        (tokensEntry) => NumberThemeExtensionGenerator(
          className: convertToValidClassName(
            "${type.className}${tokensEntry.key.toTitleCase}",
          ),
          valuesByNameByMode: tokensEntry.value.valuesByNameByMode,
        ),
      ),
    );
  } else if (type == TokenFileType.spacers && tokens.numberTokens.isNotEmpty) {
    final groupedTokens =
        groupBy(tokens.numberTokens, (DesignToken dt) => dt.collectionName);
    generators.addAll(
      groupedTokens.entries.map(
        (tokensEntry) => SpacerGenerator(
          className: convertToValidClassName(
            "${type.className}${tokensEntry.key.toTitleCase}",
          ),
          numberReference: refer(
            convertToValidClassName(
              "${type.className}${tokensEntry.key.toTitleCase}",
            ),
          ),
          valueNames: tokensEntry.value.map((t) => t.name),
        ),
      ),
    );
  } else if (type == TokenFileType.paddings && tokens.numberTokens.isNotEmpty) {
    final groupedTokens =
        groupBy(tokens.numberTokens, (DesignToken dt) => dt.collectionName);
    generators.addAll(
      groupedTokens.entries.map(
        (tokensEntry) => PaddingGenerator(
          className: convertToValidClassName(
            "${type.className}${tokensEntry.key.toTitleCase}",
          ),
          numberReference: refer(
            convertToValidClassName(
              "${type.className}${tokensEntry.key.toTitleCase}",
            ),
          ),
          valueNames: tokensEntry.value.map((t) => t.name),
        ),
      ),
    );
  } else if (type == TokenFileType.radii) {
    // TODO(JsprBllnbm): implement
  } else if (type == TokenFileType.strings) {
    // TODO(JsprBllnbm): implement
  } else if (type == TokenFileType.bools) {
    // TODO(JsprBllnbm): implement
  }

  return generators;
}

extension on File {
  TokenFileType? get tokenFileType => TokenFileType.tryFromFilename(
        basename(path),
      );
}
