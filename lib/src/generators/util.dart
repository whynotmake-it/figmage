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

String convertToValidVariableName(String variableName) {
  // Remove leading and trailing whitespace
  variableName = variableName.trim();
  // Remove any non-alphanumeric characters except underscore
  variableName = variableName.replaceAll(RegExp(r'\W+'), '');
  // Make sure the variable name starts with a letter or underscore
  if (!RegExp(r'^[a-zA-Z_]').hasMatch(variableName)) {
    // Prepend an underscore if the first character is not valid
    variableName = '_$variableName';
  }
  return variableName;
}

String convertToValidClassName(String className) {
  // Remove leading and trailing whitespace
  className = className.trim();
  // Remove any non-alphanumeric characters except underscore
  className = className.replaceAll(RegExp(r'\W+'), '');
  // Make sure the class name starts with an uppercase letter
  if (!RegExp(r'^[A-Z]').hasMatch(className)) {
    // Capitalize the first character if it is not valid
    className = className[0].toUpperCase() + className.substring(1);
  }
  return className;
}
