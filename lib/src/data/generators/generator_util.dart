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

  List<String> get asCamelCasePath {
    final pathSegments =
        split("/").map((s) => s.removeInvalidCharacters()).toList();
    if (pathSegments.every((s) => s.isEmpty) || pathSegments.isEmpty) {
      throw ArgumentError.value(
        this,
        'name path',
        'The name path does not contain any valid characters.',
      );
    }
    return switch (pathSegments) {
      [final first, ...final rest] => [
          first.toCamelCase().trim(),
          ...rest.map((e) => e.toTitleCase().trim()),
        ],
      // coverage:ignore-start
      // This is never going to happen, because pathSegments is never empty.
      _ => throw StateError('Invalid path segments: $pathSegments'),
      // coverage:ignore-end
    };
  }
}
