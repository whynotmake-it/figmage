/// Extension methods for converting hex color strings to integer values.
extension HexColorConversionX on String {
  /// Converts a hex color string to a 32-bit ARGB integer.
  int toHexColorValue() {
    var hex = trim();
    if (hex.startsWith('#')) {
      hex = hex.substring(1);
    } else if (hex.startsWith('0x') || hex.startsWith('0X')) {
      hex = hex.substring(2);
    }

    if (hex.length == 3 || hex.length == 4) {
      hex = hex.split('').map((c) => '$c$c').join();
    }

    if (hex.length == 6) {
      hex = 'ff$hex';
    } else if (hex.length == 8) {
      hex = '${hex.substring(6, 8)}${hex.substring(0, 6)}';
    } else {
      throw const FormatException('Invalid hex color length.');
    }

    return int.parse(hex, radix: 16);
  }
}
