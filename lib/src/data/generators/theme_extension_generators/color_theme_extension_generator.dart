import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/theme_extension_generators/mode_theme_extension_generator.dart';

const _colorReference = Reference(
  'Color',
  'package:flutter/material.dart',
);

/// {@template color_theme_extension_generator}
/// A [ModeThemeExtensionGenerator] for color themes from integers.
/// {@endtemplate}
class ColorThemeExtensionGenerator extends ModeThemeExtensionGenerator<int> {
  /// {@macro color_theme_extension_generator}
  ColorThemeExtensionGenerator({
    required super.className,
    required super.valuesByNameByMode,
    required super.interfaces,
    super.buildContextExtensionNullable = false,
  }) : super(
          symbolReference: _colorReference,
        );

  @override
  Expression getConstructorExpression(int value) {
    final valueString = value.toRadixString(16).padLeft(8, '0');
    return _colorReference.constInstance([refer('0x$valueString')]);
  }
}
