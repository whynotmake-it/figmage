import 'dart:io';
import 'dart:isolate';

import 'package:mason/mason.dart';

/// The name of this package
const packageName = 'figmage_package_generator';

/// {@template figmage_package_generator}
/// A generator for an empty figmage styles dart package
/// {@endtemplate}
class FigmagePackageGenerator {
  /// {@macro figmage_package_generator}
  const FigmagePackageGenerator();

  /// Generates a figmage styles dart package.
  ///
  /// [projectName] is the name of the package
  /// [dir] is the path to the package
  /// [description] is the description of the package
  Future<Iterable<File>> generate({
    required String projectName,
    required String description,
    required Directory dir,
    bool generateSpacers = true,
    bool generatePaddings = true,
    bool generateRadii = true,
    bool generateStrings = true,
    bool generateBools = true,
  }) async {
    final brick = await _getBrick();

    final generator = await MasonGenerator.fromBrick(brick);
    final vars = {
      'project_name': projectName,
      'description': description,
      'generate_spacers': generateSpacers,
      'generate_paddings': generatePaddings,
      'generate_radii': generateRadii,
      'generate_strings': generateStrings,
      'generate_bools': generateBools,
    };
    final target = DirectoryGeneratorTarget(dir);
    await generator.hooks.preGen(vars: vars);
    final files = await generator.generate(
      target,
      vars: vars,
    );
    await generator.hooks.postGen(vars: vars);
    return files.map((e) => File(e.path));
  }

  Future<Brick> _getBrick() async {
    final packageUri = Uri.parse("package:$packageName/src/brick/");
    final fileSystemUri = await Isolate.resolvePackageUri(packageUri);
    if (fileSystemUri == null) {
      throw Exception("Could not resolve package uri for package $packageName");
    }
    return Brick.path(fileSystemUri.toFilePath());
  }
}
