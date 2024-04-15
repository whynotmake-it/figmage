import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/theme_extension_generators/mode_theme_extension_generator.dart';

/// {@template number_theme_extension_generator}
/// A [ModeThemeExtensionGenerator] for numbers from doubles.
/// {@endtemplate}
class NumberThemeExtensionGenerator
    extends ModeThemeExtensionGenerator<double> {
  /// {@macro number_theme_extension_generator}
  NumberThemeExtensionGenerator({
    required super.className,
    required super.valuesByNameByMode,
    super.buildContextExtensionNullable = false,
  }) : super(
          symbolReference: const Reference('double'),
          lerpReference: const Reference(
            'lerpDouble',
            'dart:ui',
          ),
        );

  @override
  Expression getConstructorExpression(double value) {
    return literal(value);
  }
}
