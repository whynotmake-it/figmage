import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/models/config/config.dart';

/// {@template asset_class_generator}
/// Generates a class for accessing Figma assets.
/// {@endtemplate}
class AssetClassGenerator implements ThemeClassGenerator {
  /// {@macro asset_class_generator}
  const AssetClassGenerator({
    required this.className,
    required this.assets,
  });

  @override
  final String className;

  /// The assets to generate code for.
  final Map<String, AssetNodeSettings> assets;

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
                ..assignment = Code("'assets/images/'"),
            ),
          )
          ..fields.addAll(
            assets.entries.map((entry) {
              final assetName = entry.value.name;
              return Field(
                (b) => b
                  ..name = assetName
                  ..static = true
                  ..modifier = FieldModifier.constant
                  ..type = refer('String')
                  ..assignment = Code("'\${_basePath}$assetName.png'"),
              );
            }),
          )
          ..methods.addAll(
            assets.entries.map((entry) {
              final assetName = entry.value.name;
              return Method(
                (b) => b
                  ..name = '${assetName}Image'
                  ..type = MethodType.getter
                  ..returns = refer('AssetImage')
                  ..lambda = true
                  ..body = Code('AssetImage($assetName)'),
              );
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
