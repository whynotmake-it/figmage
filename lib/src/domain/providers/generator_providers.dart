import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/color_theme_extension_generator.dart';
import 'package:figmage/src/data/generators/number_theme_extension_generator.dart';
import 'package:figmage/src/data/generators/padding_generator.dart';
import 'package:figmage/src/data/generators/spacer_generator.dart';
import 'package:figmage/src/data/generators/text_style_theme_extension_generator.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage/src/domain/util/token_filter_x.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:riverpod/riverpod.dart';

/// The arguments for the [generatorProvider]
typedef GeneratorProviderArgs = ({
  TokenFileType type,
  List<DesignToken<dynamic>> tokens,
  GenerationSettings settings,
});

/// Provides a [ThemeClassGenerator] based on the file type, variables and
/// settings, if there is a supported generator.
final generatorProvider =
    Provider.family<ThemeClassGenerator?, GeneratorProviderArgs>(
  (ref, args) {
    if (args.settings.generate == false) return null;

    final filteredTokens = args.tokens.filterByFrom(args.settings);

    if (filteredTokens.isEmpty) return null;

    final generator = switch (args.type) {
      TokenFileType.color => ColorThemeExtensionGenerator(
          className: "ThemeColors",
          valuesByNameByMode:
              filteredTokens.whereType<DesignToken<int>>().valuesByNameByMode,
        ),
      TokenFileType.numbers => NumberThemeExtensionGenerator(
          className: "ThemeNumbers",
          valuesByNameByMode: filteredTokens
              .whereType<DesignToken<double>>()
              .valuesByNameByMode,
        ),
      TokenFileType.spacers => SpacerGenerator(
          className: "ThemeSpacers",
          valueNames:
              filteredTokens.whereType<FloatVariable>().map((e) => e.name),
          numberReference: const Reference("ThemeNumbers", "numbers.dart"),
        ),
      TokenFileType.paddings => PaddingGenerator(
          className: "ThemePaddings",
          valueNames: filteredTokens.map((e) => e.name).toList(),
          numberReference: const Reference("ThemeNumbers", "numbers.dart"),
        ),
      TokenFileType.typography => TextStyleThemeExtensionGenerator(
          className: "ThemeTypography",
          valuesByNameByMode:
              filteredTokens.whereType<TextStyle>().valuesByNameByMode.cast(),
        ),
      TokenFileType.radii => null,
      TokenFileType.strings => null,
      TokenFileType.bools => null,
    };
    return generator;
  },
);
