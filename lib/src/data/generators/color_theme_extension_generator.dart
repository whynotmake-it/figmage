import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/values_by_mode_theme_extension_generator.dart';

ConstructorArguments _colorFromIntBuilder(int value) {
  return (
    positionalArguments: [refer('0x${value.toRadixString(16)}')],
    namedArguments: const {},
    typeArguments: const []
  );
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
    super.extensionSymbolUrl = 'package:flutter/material.dart',
    super.buildContextExtensionNullable = false,
  }) : super(
          extensionSymbol: 'Color',
          valueToConstructorArguments: _colorFromIntBuilder,
        );
}
