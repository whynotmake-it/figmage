import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

/// Represents a color based on int
extension type IntColor(int value) {
  /// Constructor for creating a ColorX from individual RGBA components
  IntColor.fromRGBA(int red, int green, int blue, int alpha)
      : this((alpha << 24) | (red << 16) | (green << 8) | blue);

  /// Getter for the alpha component
  int get alpha => (value >> 24) & 0xFF;

  /// Getter for the red component
  int get red => (value >> 16) & 0xFF;

  /// Getter for the green component
  int get green => (value >> 8) & 0xFF;

  /// Getter for the blue component
  int get blue => value & 0xFF;

  /// Calculates the luminosity of the color.
  double get luminosity => 0.3 * red + 0.59 * green + 0.11 * blue;

  /// Clips the color components based on luminosity constraints.
  @visibleForTesting
  IntColor clipColor() {
    final l = luminosity;
    final int n = min(red, min(green, blue));
    final int x = max(red, max(green, blue));
    var newRed = red;
    var newGreen = green;
    var newBlue = blue;
    if (n < 0) {
      newRed = ((red - l) * l / (l - n)).round();
      newGreen = ((green - l) * l / (l - n)).round();
      newBlue = ((blue - l) * l / (l - n)).round();
    }
    if (x > 255) {
      newRed = ((red - l) * (255 - l) / (x - l)).round();
      newGreen = ((green - l) * (255 - l) / (x - l)).round();
      newBlue = ((blue - l) * (255 - l) / (x - l)).round();
    }
    return IntColor.fromRGBA(newRed, newGreen, newBlue, alpha);
  }

  /// Sets the luminosity of the color.
  IntColor setLuminosity(double lum) {
    final d = lum - luminosity;
    return IntColor.fromRGBA(
      (red + d).round(),
      (green + d).round(),
      (blue + d).round(),
      alpha,
    ).clipColor();
  }

  /// Calculates the saturation of the color.
  int get saturation => max(red, max(green, blue)) - min(red, min(green, blue));

  /// Sets the saturation of the color.
  IntColor setSaturation(int sat) {
    int minVal = min(red, min(green, blue));
    int maxVal = max(red, max(green, blue));
    int midVal;
    if (maxVal > minVal) {
      final originalMidVal = red != minVal && red != maxVal
          ? red
          : green != minVal && green != maxVal
              ? green
              : blue;
      midVal = (((originalMidVal - minVal) * sat) / (maxVal - minVal)).round();
      maxVal = sat;
    } else {
      midVal = maxVal = 0;
    }
    minVal = 0;
    return IntColor.fromRGBA(maxVal, midVal, minVal, alpha);
  }
}
