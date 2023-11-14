import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/generators/theme_extension_generator.dart';

/// {@template number_theme_extension_generator}
/// A [ThemeExtensionGenerator] for numbers from doubles.
/// {@endtemplate}
class NumberThemeExtensionGenerator extends ThemeExtensionGenerator<double> {
  /// {@macro number_theme_extension_generator}
  NumberThemeExtensionGenerator({
    required super.className,
    required super.valuesByNameByMode,
    super.buildContextExtensionNullable = false,
  }) : super(
          extensionSymbol: 'double',
          lerpReference: const Reference(
            'lerpDouble',
            'dart:ui',
          ),
        );
}
