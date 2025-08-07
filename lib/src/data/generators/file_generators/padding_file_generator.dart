import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/file_generators/base_file_generator.dart';
import 'package:figmage/src/data/generators/reference_generators/padding_generator.dart';
import 'package:figmage/src/domain/generators/file_generator.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/util/token_filter_x.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';

/// {@template padding_file_generator}
/// A [FileGenerator] that generates a file based on a given list of
/// [DesignToken]s that contain [double] values using
/// [PaddingGenerator]s.
/// {@endtemplate}
class PaddingFileGenerator extends BaseFileGenerator<double> {
  /// {@macro padding_file_generator}
  PaddingFileGenerator({
    required super.tokens,
    required super.inheritanceSettings,
  }) : super(type: TokenFileType.paddings);

  @override
  ThemeClassGenerator buildGeneratorForCollection({
    required String collectionName,
    required Iterable<DesignToken<double>> collectionTokens,
    required Iterable<InterfaceSettings> interfaces,
  }) {
    return PaddingGenerator(
      className: getClassNameForCollection(collectionName),
      fromClass: refer(
        getClassNameForCollectionAndType(
          collectionName,
          TokenFileType.numbers,
        ),
        TokenFileType.numbers.filename,
      ),
      valueNames: collectionTokens.valueNames,
    );
  }
}
