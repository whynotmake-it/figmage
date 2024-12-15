import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/assets/asset_class_generator.dart';
import 'package:figmage/src/domain/generators/file_generator.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';

/// {@template asset_file_generator}
/// A [FileGenerator] that generates a file for accessing Figma assets.
/// {@endtemplate}
class AssetFileGenerator implements FileGenerator {
  /// {@macro asset_file_generator}
  AssetFileGenerator({
    required this.assets,
    required this.packageName,
  });

  /// Map of node IDs to their downloaded asset file names.
  final Map<String, List<String>> assets;

  /// The name of the package these assets belong to.
  final String packageName;

  @override
  final TokenFileType type = TokenFileType.assets;

  @override
  late final Iterable<ThemeClassGenerator> generators = [
    AssetClassGenerator(
      className: 'Assets',
      assets: assets,
      packageName: packageName,
    ),
  ];

  @override
  Library generate() {
    final lib = LibraryBuilder();
    lib.comments.addAll(FileGenerator.generatedFilePrefix);
    lib.body.addAll(
      [
        for (final g in generators) ...[
          g.generateClass(),
          g.generateExtension(),
        ],
      ],
    );
    return lib.build();
  }
}
