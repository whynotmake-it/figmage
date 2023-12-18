/// An extension on [String] that provides methods for converting a string to
/// valid dart code.
extension StringDartConversionX on String {
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

  /// Converts a string that is a path into a camelCase path containing it's
  /// segments.
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
