import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:mason/mason.dart';

/// The name of this package
const packageName = 'figmage_package_generator';

/// A resolver for package uris
typedef PackageUriResolver = FutureOr<Uri?> Function(Uri packageUri);

/// A factory for [GeneratorTarget]s
typedef GeneratorTargetFactory = GeneratorTarget Function(Directory dir);

/// {@template figmage_package_generator}
/// A generator for an empty figmage styles dart package
/// {@endtemplate}
class FigmagePackageGenerator {
  /// {@macro figmage_package_generator}
  ///
  /// Allows to override the [packageUriResolver] for testing purposes.
  const FigmagePackageGenerator({
    PackageUriResolver? packageUriResolver,
    GeneratorTargetFactory? generatorTargetFactory,
  })  : _packageUriResolver = packageUriResolver ?? Isolate.resolvePackageUri,
        _generatorTargetFactory =
            generatorTargetFactory ?? DirectoryGeneratorTarget.new;

  final PackageUriResolver _packageUriResolver;

  final GeneratorTargetFactory _generatorTargetFactory;

  /// Generates a figmage styles dart package.
  ///
  /// [projectName] is the name of the package
  /// [dir] is the path to the package
  /// [description] is the description of the package
  Future<Iterable<File>> generate({
    required String projectName,
    required String description,
    required Directory dir,
    bool generateColors = true,
    bool generateTypography = true,
    bool generateNumbers = true,
    bool generateSpacers = true,
    bool generatePaddings = true,
    bool generateRadii = true,
    bool generateStrings = true,
    bool generateBools = true,
    bool useGoogleFonts = true,
  }) async {
    final brick = await _getBrick();

    final generator = await MasonGenerator.fromBrick(brick);
    final vars = {
      'project_name': projectName,
      'description': description,
      'generate_colors': generateColors,
      'generate_typography': generateTypography,
      'generate_numbers': generateNumbers,
      'generate_spacers': generateSpacers,
      'generate_paddings': generatePaddings,
      'generate_radii': generateRadii,
      'generate_strings': generateStrings,
      'use_google_fonts': useGoogleFonts,
    };
    final target = _generatorTargetFactory(dir);
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
    final fileSystemUri = await _packageUriResolver(packageUri);
    if (fileSystemUri == null) {
      throw const PackageUriException(packageName);
    }
    return Brick.path(fileSystemUri.toFilePath());
  }
}

/// {@template package_uri_exception}
/// An exception thrown when the package uri could not be resolved
/// {@endtemplate}
class PackageUriException implements Exception {
  /// {@macro package_uri_exception}
  const PackageUriException(this.packageName);

  /// The name of the package that could not be resolved
  final String packageName;

  @override
  String toString() => "Could not resolve package uri for package $packageName";
}
