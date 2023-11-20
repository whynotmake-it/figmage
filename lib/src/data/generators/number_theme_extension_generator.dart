import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/values_by_mode_theme_extension_generator.dart';

/// {@template number_theme_extension_generator}
/// A [ValuesByModeThemeExtensionGenerator] for numbers from doubles.
/// {@endtemplate}
class NumberThemeExtensionGenerator
    extends ValuesByModeThemeExtensionGenerator<double> {
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
