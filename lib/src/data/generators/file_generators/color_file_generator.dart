import 'package:figmage/src/data/generators/file_generators/base_file_generator.dart';
import 'package:figmage/src/data/generators/theme_extension_generators/color_theme_extension_generator.dart';
import 'package:figmage/src/domain/generators/file_generator.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/util/token_filter_x.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';

/// {@template color_file_generator}
/// A [FileGenerator] that generates a file based on a given list of
/// [DesignToken]s that contain [int] values using
/// [ColorThemeExtensionGenerator]s.
/// {@endtemplate}
class ColorFileGenerator extends BaseFileGenerator<int> {
  /// {@macro color_file_generator}
  ColorFileGenerator({
    required super.tokens,
    required super.implementsSettings,
  }) : super(type: TokenFileType.color);

  @override
  ThemeClassGenerator buildGeneratorForCollection({
    required String collectionName,
    required Iterable<DesignToken<int>> collectionTokens,
    required Iterable<InterfaceSettings> interfaces,
  }) {
    return ColorThemeExtensionGenerator(
      className: getClassNameForCollection(collectionName),
      valuesByNameByMode: collectionTokens.valuesByNameByMode,
      interfaces: interfaces,
    );
  }
}
