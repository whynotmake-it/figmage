import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/theme_extension_generators/values_by_mode_theme_extension_generator.dart';

const _colorReference = Reference(
  'Color',
  'package:flutter/material.dart',
);

/// {@template color_theme_extension_generator}
/// A [ValuesByModeThemeExtensionGenerator] for color themes from integers.
/// {@endtemplate}
class ColorThemeExtensionGenerator
    extends ValuesByModeThemeExtensionGenerator<int> {
  /// {@macro color_theme_extension_generator}
  ColorThemeExtensionGenerator({
    required super.className,
    required super.valuesByNameByMode,
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
