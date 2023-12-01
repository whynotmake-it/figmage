import 'package:figmage/src/data/util/converters/string_dart_conversion_x.dart';

/// Makes sure that all maps in the list have the same keys.
bool ensureSameKeys(List<Map<String, dynamic>> maps) {
  if (maps.isEmpty) return true;
  final firstKeys = maps[0].keys.toSet();
  for (final map in maps) {
    final keys = map.keys.toSet();
    if (!keys.containsAll(firstKeys) || !firstKeys.containsAll(keys)) {
      return false;
    }
  }
  return true;
}

/// Converts a variable name from figma into a camelCase variable name.
///
/// For example, `Number/NumberWith2Aliases` becomes `numberWith2Aliases`.
String convertToValidVariableName(String variableName) {
  // Remove leading and trailing whitespace
  return variableName.asCamelCasePath.join().removeLeadingNumbers();
}

/// Converts a given [variableName] to a dart top-level constant name.
String convertToValidConstantName(String variableName) {
  return "k${variableName.asCamelCasePath.join().toTitleCase()}";
}

/// Converts a given class name to a valid dart class name.
String convertToValidClassName(String className) {
  return className.asCamelCasePath.join().toTitleCase().removeLeadingNumbers();
}
