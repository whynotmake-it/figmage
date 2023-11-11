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

  final camelCasePath = switch (variableName.split("/").toList()) {
    [final first, ...final rest] => [
        first.toCamelCase().trim(),
        ...rest.map((e) => e.toTitleCase().trim()),
      ],
    [] => <String>[],
  };

  // Remove any non-alphanumeric characters except underscore
  final camelCaseName = camelCasePath.join().replaceAll(RegExp(r'\W+'), '');

  // Make sure the variable name starts with a letter or underscore
  if (!RegExp('^[a-zA-Z_]').hasMatch(camelCaseName)) {
    return '\$$camelCaseName';
  }
  return camelCaseName;
}

/// Converts a given class name to a valid dart class name.
String convertToValidClassName(String className) {
  final name = className
      // Remove leading and trailing whitespace
      .trim()
      // Remove any non-alphanumeric characters
      // TODO(tim): unit test this
      .replaceAll(RegExp(r'\W+'), '');

  // Make sure the class name starts with an uppercase letter
  if (!RegExp('^[A-Z]').hasMatch(className)) {
    // Capitalize the first character if it is not valid
    return name[0].toUpperCase() + name.substring(1);
  }

  return name;
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
}
