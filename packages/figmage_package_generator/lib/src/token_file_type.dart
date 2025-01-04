/// The types of generated token files.
enum TokenFileType {
  /// Color tokens
  color("colors.dart"),

  /// Typography (text style) tokens
  typography("typography.dart"),

  /// Spacers (SizedBox) tokens
  numbers("numbers.dart"),

  /// Spacers (SizedBox) tokens
  spacers("spacers.dart"),

  /// Paddings (EdgeInsets) tokens
  paddings("paddings.dart"),

  /** TODO(tim): add back once supported
  /// Radii (BorderRadius) tokens
  radii("radii.dart"),

  /// Strings tokens
  strings("strings.dart"),

  /// Bools tokens
  bools("bools.dart"),
  */

  /// Asset tokens
  assets("assets.dart");

  const TokenFileType(this.filename);

  /// Gets the token file type from the filename.
  ///
  /// Throws if the filename is invalid.
  static TokenFileType fromFilename(String filename) {
    try {
      return TokenFileType.values.firstWhere(
        (element) => element.filename == filename,
      );
    } catch (_) {
      throw ArgumentError.value(
        filename,
        "filename",
        "The filename $filename is not a valid token file name.",
      );
    }
  }

  /// The same as [fromFilename], but returns null if the filename is invalid.
  static TokenFileType? tryFromFilename(String value) {
    try {
      return TokenFileType.fromFilename(value);
    } catch (_) {
      return null;
    }
  }

  /// The name of the generated file for this token.
  final String filename;

  /// Gets the class name for the file type.
  String get className => switch (filename.split(".").first.trim()) {
        final name => name[0].toUpperCase() + name.substring(1),
      };
}
