import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/generator_util.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';

/// {@template asset_class_generator}
/// Generates a class for accessing Figma assets.
/// Creates constants for asset paths and convenience getters for AssetImage
/// instances. Supports assets with different scale factors through filename
/// suffixes.
/// {@endtemplate}
class AssetClassGenerator implements ThemeClassGenerator {
  /// {@macro asset_class_generator}
  const AssetClassGenerator({
    required this.className,
    required this.assets,
    required this.packageName,
  });

  @override
  final String className;

  /// The successfully downloaded assets to generate code for.
  /// where each entry: key: id, value: assetNames
  final Map<String, List<String>> assets;

  /// The name of the package these assets belong to.
  final String packageName;

  @override
  bool get buildContextExtensionNullable => false;

  @override
  Class generateClass() {
    return Class(
      (b) {
        b
          ..name = className
          ..constructors.add(
            Constructor(
              (b) => b..constant = true,
            ),
          )
          ..annotations.add(
            refer('immutable', 'package:meta/meta.dart'),
          )
          ..modifier = ClassModifier.final$
          ..fields.add(
            Field(
              (b) => b
                ..name = '_basePath'
                ..static = true
                ..modifier = FieldModifier.constant
                ..type = refer('String')
                ..assignment = const Code("'assets/'"),
            ),
          )
          ..fields.addAll([
            for (final MapEntry(key: id, value: assetNames) in assets.entries)
              ...assetNames.map((asset) {
                final assetName = convertToValidVariableName(asset);
                return Field(
                  (b) => b
                    ..name = assetName
                    ..static = true
                    ..modifier = FieldModifier.constant
                    ..type = refer('String')
                    ..assignment = Code("'\${_basePath}$asset'")
                    ..docs.add('/// Rendered from frame $id'),
                );
              }),
          ])
          ..methods.addAll(
            assets.values.expand((values) {
              return values.map((asset) {
                final assetName = convertToValidVariableName(asset);

                return Method(
                  (b) => b
                    ..name = '${assetName}Image'
                    ..static = true
                    ..type = MethodType.getter
                    ..returns = refer('AssetImage')
                    ..lambda = true
                    ..body =
                        Code("AssetImage($assetName, package: '$packageName')"),
                );
              });
            }),
          );
      },
    );
  }

  @override
  Extension generateExtension() {
    return Extension(
      (b) => b
        ..name = '${className}BuildContextX'
        ..on = refer('BuildContext', 'package:flutter/widgets.dart')
        ..methods.add(
          Method(
            (b) => b
              ..name = className.toLowerCase()
              ..type = MethodType.getter
              ..returns = refer(className)
              ..lambda = true
              ..body = Code('$className()'),
          ),
        ),
    );
  }
}
