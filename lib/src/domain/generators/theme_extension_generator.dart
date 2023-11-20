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

  /// The symbol (e.g., Color, TextStyle) used in the theme
  /// extension.
  String get extensionSymbol;

  /// The URL for the symbol, typically a package URL. If generated for a
  /// literal built-in type this value should be null
  String? get extensionSymbolUrl;

  /// Generates the `ThemeExtension` class and the constants for all values,
  /// as well as a `BuildContext` extension and returns the resulting
  /// code as a string.
  @override
  String generate();
}
