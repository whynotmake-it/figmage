import 'package:figma/figma.dart';

/// Extension methods for converting [Color]s.
extension ColorConversionX on Color {
  /// Converts a figma [Color] to a 32 bit integer.
  int toValue() {
    if ((r, g, b, a) case (final r?, final g?, final b?, final a?)) {
      final red = (r * 255).round();
      final green = (g * 255).round();
      final blue = (b * 255).round();
      final alpha = (a * 255).round();
      return (alpha << 24) | (red << 16) | (green << 8) | blue;
    }
    throw Exception('Color is not valid');
  }
}
