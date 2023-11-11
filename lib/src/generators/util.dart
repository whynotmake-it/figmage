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
  final pathSegments =
      variableName.split("/").map((s) => s.removeInvalidCharacters()).toList();
  final camelCasePath = switch (pathSegments) {
    [final first, ...final rest] => [
        first.toCamelCase().trim(),
        ...rest.map((e) => e.toTitleCase().trim()),
      ],
    [] => <String>[],
  };

  // Remove any non-alphanumeric characters except underscore
  return camelCasePath.join().removeLeadingNumbers();
}

/// Converts a given class name to a valid dart class name.
String convertToValidClassName(String className) {
  return className
      .trim()
      .removeInvalidCharacters()
      .toTitleCase()
      .removeLeadingNumbers();
}

extension on String {
  /// Converts a string to title case.
  String toTitleCase() {
    return this[0].toUpperCase() + substring(1);
  }

  /// Converts a string to camel case.
  String toCamelCase() {
    return this[0].toLowerCase() + substring(1);
  }

  /// Removes all invalid characters from a string, which includes all
  /// non-alphanumeric characters and underscores.
  String removeInvalidCharacters() => replaceAll(RegExp('[^a-zA-Z0-9]'), '');

  /// Removes all leading numbers from a string.
  String removeLeadingNumbers() =>
      RegExp('[0-9]').hasMatch(this[0]) ? '\$$this' : this;
}
