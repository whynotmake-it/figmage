import 'dart:io';

import 'package:figmage/src/data/generators/file_generators/asset_file_generator.dart';
import 'package:figmage/src/data/generators/file_generators/color_file_generator.dart';
import 'package:figmage/src/data/generators/file_generators/number_file_generator.dart';
import 'package:figmage/src/data/generators/file_generators/padding_file_generator.dart';
import 'package:figmage/src/data/generators/file_generators/spacer_file_generator.dart';
import 'package:figmage/src/data/generators/file_generators/typography_file_generator.dart';
import 'package:figmage/src/domain/generated_package_name_provider.dart';
import 'package:figmage/src/domain/generators/file_generator.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/figmage_settings.dart';
import 'package:figmage/src/domain/models/tokens_by_file_type/tokens_by_type.dart';
import 'package:figmage/src/domain/providers/design_token_providers.dart';
import 'package:figmage/src/domain/providers/figmage_package_generator_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';

/// Provides a one [FileGenerator] for each file that needs to be generated.
final generatorsProvider =
    FutureProvider.family<Map<File, FileGenerator>, FigmageSettings>(
      (ref, settings) async {
        final logger = ref.watch(loggerProvider);

        final assets = await ref.watch(assetsProvider(settings).future);

        final tokensByType = await ref.watch(
          filterUnresolvedTokensProvider(settings).future,
        );
        final mixedCollectionIds = _mixedCollectionIds(tokensByType);

        final files = await ref.watch(
          generatedPackageProvider(settings).future,
        );

        final typesByFile = <File, TokenFileType>{
          for (final file in files)
            if (file.tokenFileType case final type?) file: type,
        };

        final progress = logger.progress(
          "Generating theme classes for ${typesByFile.length} files...",
        );

        final packageName = ref.watch(generatedPackageNameProvider(settings));

        final generatorsByFile = {
          for (final MapEntry(key: file, value: type) in typesByFile.entries)
            file: switch (type) {
              TokenFileType.color => ColorFileGenerator(
                tokens: tokensByType.colorTokens,
                inheritanceSettings: settings.config.colors.inheritance,
                isMixedTokenCollection: mixedCollectionIds.contains,
              ),
              TokenFileType.typography => TypographyFileGenerator(
                tokens: tokensByType.typographyTokens,
                useGoogleFonts: settings.config.typography.useGoogleFonts,
                inheritanceSettings: settings.config.typography.inheritance,
                isMixedTokenCollection: mixedCollectionIds.contains,
              ),
              TokenFileType.numbers => NumberFileGenerator(
                tokens: tokensByType.numberTokens,
                inheritanceSettings: settings.config.numbers.inheritance,
                isMixedTokenCollection: mixedCollectionIds.contains,
              ),
              TokenFileType.spacers => SpacerFileGenerator(
                tokens: tokensByType.numberTokens,
                inheritanceSettings: settings.config.spacers.inheritance,
                isMixedTokenCollection: mixedCollectionIds.contains,
              ),
              TokenFileType.paddings => PaddingFileGenerator(
                tokens: tokensByType.numberTokens,
                inheritanceSettings: settings.config.paddings.inheritance,
                isMixedTokenCollection: mixedCollectionIds.contains,
              ),
              TokenFileType.assets => AssetFileGenerator(
                assets: assets,
                packageName: packageName,
              ),
            },
        };

        progress.complete();
        return generatorsByFile;
      },
    );

Set<String> _mixedCollectionIds(TokensByType tokensByType) {
  final tokenKindsByCollectionId = <String, Set<String>>{};

  void collect(
    String kind,
    Iterable<DesignToken<dynamic>> tokens,
  ) {
    for (final token in tokens) {
      tokenKindsByCollectionId
          .putIfAbsent(token.collectionId, () => <String>{})
          .add(kind);
    }
  }

  collect('color', tokensByType.colorTokens);
  collect('typography', tokensByType.typographyTokens);
  collect('number', tokensByType.numberTokens);
  collect('string', tokensByType.stringTokens);
  collect('bool', tokensByType.boolTokens);

  return {
    for (final entry in tokenKindsByCollectionId.entries)
      if (entry.value.length > 1) entry.key,
  };
}

extension on File {
  TokenFileType? get tokenFileType => TokenFileType.tryFromFilename(
    basename(path),
  );
}
