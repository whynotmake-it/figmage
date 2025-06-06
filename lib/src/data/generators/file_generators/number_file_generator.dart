import 'package:figmage/src/data/generators/file_generators/base_file_generator.dart';
import 'package:figmage/src/data/generators/theme_extension_generators/number_theme_extension_generator.dart';
import 'package:figmage/src/domain/generators/file_generator.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/util/token_filter_x.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';

/// {@template number_file_generator}
/// A [FileGenerator] that generates a file based on a given list of
/// [DesignToken]s that contain [double] values using
/// [NumberThemeExtensionGenerator]s.
/// {@endtemplate}
class NumberFileGenerator extends BaseFileGenerator<double> {
  /// {@macro number_file_generator}
  NumberFileGenerator({
    required super.tokens,
    required super.implementsSettings,
  }) : super(type: TokenFileType.numbers);

  @override
  ThemeClassGenerator buildGeneratorForCollection({
    required String collectionName,
    required Iterable<DesignToken<double>> collectionTokens,
  }) {
    return NumberThemeExtensionGenerator(
      className: getClassNameForCollection(collectionName),
      valuesByNameByMode: collectionTokens.valuesByNameByMode,
    );
  }
}
