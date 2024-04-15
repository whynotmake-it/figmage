import 'package:code_builder/code_builder.dart';

/// {@template generator}
/// The superclass for all generators that can generate
/// a ThemeClassGeneratorResult
///
/// All generators generate a `BuildContext` extension.
/// {@endtemplate}
abstract interface class ThemeClassGenerator {
  /// The name of the generated class.
  String get className;

  /// Whether the return type of the `BuildContext` extension should be
  /// nullable.
  ///
  /// If this is false, the extension will contain a null assertion, which means
  /// your code will throw if you haven't provided the respective
  /// `ThemeExtension` in the widget tree.
  bool get buildContextExtensionNullable;

  /// Generates the class from the provided parameters.
  Class generateClass();

  /// Generates the extension for the `BuildContext` from the provided
  /// parameters.
  Extension generateExtension();
}

/// A [ThemeClassGenerator] for `ThemeExtension` from
/// `package:flutter/material.dart`.
///
/// Generates the ThemeExtension class, constants for all values, as well as
/// a `BuildContext` extension.
abstract interface class ThemeExtensionGenerator
    implements ThemeClassGenerator {
  /// A [Reference] to the symbol (e.g., Color, TextStyle) used in the theme
  /// extension.
  Reference get symbolReference;
}
