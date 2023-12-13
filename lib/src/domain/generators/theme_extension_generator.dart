import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';

/// A [ThemeClassGenerator] for `ThemeExtension` from
/// `package:flutter/material.dart`.
///
/// Generates the ThemeExtension class, constants for all values, as well as
/// a `BuildContext` extension.
abstract interface class ThemeExtensionGenerator<T>
    implements ThemeClassGenerator {
  /// The name of the generated `ThemeExtension` class.
  @override
  String get className;

  /// A [Reference] to the symbol (e.g., Color, TextStyle) used in the theme
  /// extension.
  Reference get extensionSymbolReference;

  /// Generates the `ThemeExtension` class and the constants for all values,
  /// as well as a `BuildContext` extension and returns the resulting
  /// code as a string.
  @override
  String generate();
}
