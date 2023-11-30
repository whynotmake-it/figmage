import 'package:figmage/src/domain/generators/theme_class_generator.dart';

/// {@template value_names_theme_class_generator}
/// A generator for a theme class which has a list of values as fields.
/// {@endtemplate}
abstract interface class ValueNamesThemeClassGenerator
    implements ThemeClassGenerator {
  /// The names of the values to generate fields for
  Iterable<String> get valueNames;
}
