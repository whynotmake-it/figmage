import 'dart:io';

import 'package:figmage/src/data/generators/file_generators/asset_file_generator.dart';
import 'package:figmage/src/data/generators/file_generators/color_file_generator.dart';
import 'package:figmage/src/data/generators/file_generators/number_file_generator.dart';
import 'package:figmage/src/data/generators/file_generators/padding_file_generator.dart';
import 'package:figmage/src/data/generators/file_generators/spacer_file_generator.dart';
import 'package:figmage/src/data/generators/file_generators/typography_file_generator.dart';
import 'package:figmage/src/domain/generated_package_name_provider.dart';
import 'package:figmage/src/domain/generators/file_generator.dart';
import 'package:figmage/src/domain/models/figmage_settings.dart';
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

    final files = await ref.watch(generatedPackageProvider(settings).future);

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
            ),
          TokenFileType.typography => TypographyFileGenerator(
              tokens: tokensByType.typographyTokens,
              useGoogleFonts: settings.config.typography.useGoogleFonts,
            ),
          TokenFileType.numbers => NumberFileGenerator(
              tokens: tokensByType.numberTokens,
            ),
          TokenFileType.spacers => SpacerFileGenerator(
              tokens: tokensByType.numberTokens,
            ),
          TokenFileType.paddings => PaddingFileGenerator(
              tokens: tokensByType.numberTokens,
            ),
          TokenFileType.assets =>
            AssetFileGenerator(assets: assets, packageName: packageName),
        },
    };

    progress.complete();
    return generatorsByFile;
  },
);

extension on File {
  TokenFileType? get tokenFileType => TokenFileType.tryFromFilename(
        basename(path),
      );
}
