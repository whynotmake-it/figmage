import 'package:figmage/src/domain/shared/reserved_words.dart';

/// Converts a string to a valid package name.
String toDartPackageName(String input, {String defaultName = 'package'}) {
  final defaultIsValid = switch (defaultName) {
    'package' => true,
    _ => toDartPackageName(defaultName) == defaultName,
  };

  if (defaultIsValid == false) {
    throw ArgumentError.value(
      defaultName,
      'defaultName',
      'is not a valid package name',
    );
  }

  if (input.isEmpty) {
    return defaultName;
  }

  // Convert to lowercase and replace invalid characters with underscores
  var result = input.toLowerCase().replaceAll(RegExp('[^a-z0-9_]'), '_');

  // Remove consecutive underscores
  result = result.replaceAll(RegExp('_+'), '_');

  // Remove leading and trailing underscores
  result = result.trim().replaceAll(RegExp(r'^_+|_+$'), '');

  // If the result starts with a digit, prepend 'pkg_'
  if (RegExp(r'^\d').hasMatch(result)) {
    result = 'pkg_$result';
  }

  // If the result is empty after processing, return 'package'
  if (result.isEmpty) {
    return defaultName;
  }

  if (reservedWords.contains(result)) {
    result = '${result}_pkg';
  }

  return result;
}
