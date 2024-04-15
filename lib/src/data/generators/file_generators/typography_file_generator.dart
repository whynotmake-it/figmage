import 'package:figmage/src/data/generators/file_generators/base_file_generator.dart';
import 'package:figmage/src/data/generators/theme_extension_generators/text_style_theme_extension_generator.dart';
import 'package:figmage/src/domain/generators/file_generator.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
import 'package:figmage/src/domain/util/token_filter_x.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';

/// {@template typography_file_generator}
/// A [FileGenerator] that generates a file based on a given list of
/// [DesignToken]s that contain [Typography] values using
/// [TextStyleThemeExtensionGenerator]s.
/// {@endtemplate}
class TypographyFileGenerator extends BaseFileGenerator<Typography> {
  /// {@macro typography_file_generator}
  TypographyFileGenerator({
    required super.tokens,
    required this.useGoogleFonts,
  }) : super(type: TokenFileType.typography);

  /// Whether to use Google Fonts in the generated theme extensions.
  final bool useGoogleFonts;

  @override
  ThemeClassGenerator buildGeneratorForCollection({
    required String collectionName,
    required Iterable<DesignToken<Typography>> collectionTokens,
  }) {
    return TextStyleThemeExtensionGenerator(
      className: getClassNameForCollection(collectionName),
      valuesByNameByMode: collectionTokens.valuesByNameByMode,
      useGoogleFonts: useGoogleFonts,
    );
  }
}
