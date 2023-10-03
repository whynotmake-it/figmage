import 'dart:io';

import 'package:mason/mason.dart';

/// {@template figmage_package_generator}
/// A generator for an empty figmage styles dart package
/// {@endtemplate}
class FigmagePackageGenerator {
  /// {@macro figmage_package_generator}
  const FigmagePackageGenerator();

  /// Generates a figmage styles dart package.
  ///
  /// [projectName] is the name of the package
  /// [path] is the path to the package
  /// [description] is the description of the package
  Future<void> generate({
    required String projectName,
    required String description,
    required Directory path,
  }) async {
    final brick = Brick.path("../../brick/");

    final generator = await MasonGenerator.fromBrick(brick);

    generator.generate(
      DirectoryGeneratorTarget(path),
      vars: {
        'project_name': projectName,
        'description': description,
      },
    );
  }
}
