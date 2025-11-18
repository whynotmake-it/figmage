import 'package:figma/figma.dart';

/// Extension methods for converting [Rgba]s.
extension ColorConversionX on Rgba {
  /// Converts a figma [Rgba] to a 32 bit integer.
  int toValue({num? opacity}) {
    final red = (r * 255).round();
    final green = (g * 255).round();
    final blue = (b * 255).round();
    final alpha = (a * (opacity ?? 1) * 255).round();
    return (alpha << 24) | (red << 16) | (green << 8) | blue;
  }
}
