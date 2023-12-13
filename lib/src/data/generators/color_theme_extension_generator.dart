import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/values_by_mode_theme_extension_generator.dart';

const _colorReference = Reference(
  'Color',
  'package:flutter/material.dart',
);

Expression _colorFromIntBuilder(int value) {
  return _colorReference.newInstance([refer('0x${value.toRadixString(16)}')]);
}

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
          valueToConstructorExpression: _colorFromIntBuilder,
          extensionSymbolReference: _colorReference,
        );
}
