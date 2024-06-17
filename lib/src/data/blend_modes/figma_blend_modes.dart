import 'dart:math';

import 'package:figmage/src/domain/color/int_color.dart';

/// The `BlendModes` class provides a collection of static methods to perform
/// various color blending operations between two colors.
/// The caluclations are based on: https://www.w3.org/TR/compositing-1/#blending.
/// Each method represents a different blend mode, which defines how the colors
/// should be combined.
///
/// In the context of these blend modes:
/// - `cb` stands for "color below" or "background color",
/// - `cs` stands for "color source" or "foreground color".
class FigmaBlendModes {
  /// The `normal` blend mode returns the source color (`cs`) unchanged,
  /// effectively overlaying it on top of the background color (`cb`).
  static IntColor normal(IntColor cb, IntColor cs) {
    return cs;
  }

  /// The `multiply` blend mode multiplies the background color (`cb`) with
  /// the source color (`cs`), resulting in a darker color.
  static IntColor multiply(IntColor cb, IntColor cs) {
    return IntColor.fromRGBA(
      (cb.red * cs.red) ~/ 255,
      (cb.green * cs.green) ~/ 255,
      (cb.blue * cs.blue) ~/ 255,
      1,
    );
  }

  /// The `screen` blend mode inverts, multiplies, and then inverts the colors
  /// again. This results in a brighter color, opposite of the multiply
  /// blend mode.
  static IntColor screen(IntColor cb, IntColor cs) {
    return IntColor.fromRGBA(
      255 - (((255 - cb.red) * (255 - cs.red)) ~/ 255),
      255 - (((255 - cb.green) * (255 - cs.green)) ~/ 255),
      255 - (((255 - cb.blue) * (255 - cs.blue)) ~/ 255),
      1,
    );
  }

  /// The `overlay` blend mode combines the multiply and screen blend modes.
  /// It uses the screen blend mode on lighter colors, and the multiply blend
  /// mode on darker colors.
  static IntColor overlay(IntColor cb, IntColor cs) {
    return hardLight(cs, cb);
  }

  /// The `darken` blend mode selects the darker of the background color (`cb`)
  /// and the source color (`cs`) for each component (red, green, blue).
  static IntColor darken(IntColor cb, IntColor cs) {
    return IntColor.fromRGBA(
      min(cb.red, cs.red),
      min(cb.green, cs.green),
      min(cb.blue, cs.blue),
      1,
    );
  }

  /// The `lighten` blend mode selects the lighter of the background
  /// color (`cb`) and the source color (`cs`) for each component
  /// (red, green, blue).
  static IntColor lighten(IntColor cb, IntColor cs) {
    return IntColor.fromRGBA(
      max(cb.red, cs.red),
      max(cb.green, cs.green),
      max(cb.blue, cs.blue),
      1,
    );
  }

  /// The `colorDodge` blend mode brightens the background color (`cb`) to
  /// reflect the source color (`cs`).
  /// IntColors opposite to the source color are unchanged.
  static IntColor colorDodge(IntColor cb, IntColor cs) {
    return IntColor.fromRGBA(
      cs.red == 255 ? 255 : min(255, (cb.red * 255) ~/ (255 - cs.red)),
      cs.green == 255 ? 255 : min(255, (cb.green * 255) ~/ (255 - cs.green)),
      cs.blue == 255 ? 255 : min(255, (cb.blue * 255) ~/ (255 - cs.blue)),
      1,
    );
  }

  /// The `colorBurn` blend mode darkens the background color (`cb`)
  /// to reflect the source color (`cs`).
  /// IntColors opposite to the source color are unchanged.
  static IntColor colorBurn(IntColor cb, IntColor cs) {
    return IntColor.fromRGBA(
      cs.red == 0 ? 0 : max(0, 255 - (((255 - cb.red) * 255) ~/ cs.red)),
      cs.green == 0 ? 0 : max(0, 255 - (((255 - cb.green) * 255) ~/ cs.green)),
      cs.blue == 0 ? 0 : max(0, 255 - (((255 - cb.blue) * 255) ~/ cs.blue)),
      1,
    );
  }

  /// The `hardLight` blend mode combines the multiply and screen blend modes.
  /// It uses the multiply blend mode on darker colors, and the screen blend
  /// mode on lighter colors.
  static IntColor hardLight(IntColor cb, IntColor cs) {
    return IntColor.fromRGBA(
      cs.red <= 127
          ? (cb.red * cs.red * 2) ~/ 255
          : 255 - 2 * ((255 - cb.red) * (255 - cs.red) ~/ 255),
      cs.green <= 127
          ? (cb.green * cs.green * 2) ~/ 255
          : 255 - 2 * ((255 - cb.green) * (255 - cs.green) ~/ 255),
      cs.blue <= 127
          ? (cb.blue * cs.blue * 2) ~/ 255
          : 255 - 2 * ((255 - cb.blue) * (255 - cs.blue) ~/ 255),
      1,
    );
  }

  // Soft Light Blend Mode
  /// Applies a soft light effect by either darkening or lightening colors,
  /// depending on the source color. This mode is useful for adding
  /// subtle lighting effects to images, simulating the effect of shining a soft
  ///  light on the colors.
  static IntColor softLight(IntColor cb, IntColor cs) {
    double d(int c) {
      final nc = c / 255.0;
      return nc <= 0.25 ? ((16 * nc - 12) * nc + 4) * nc : sqrt(nc);
    }

    return IntColor.fromRGBA(
      (cs.red <= 127)
          ? (cb.red - (1 - 2 * (cs.red / 255)) * cb.red * (1 - cb.red / 255))
              .toInt()
          : (cb.red + (2 * (cs.red / 255) - 1) * (d(cb.red) - cb.red / 255))
              .toInt(),
      (cs.green <= 127)
          ? (cb.green -
                  (1 - 2 * (cs.green / 255)) * cb.green * (1 - cb.green / 255))
              .toInt()
          : (cb.green +
                  (2 * (cs.green / 255) - 1) * (d(cb.green) - cb.green / 255))
              .toInt(),
      (cs.blue <= 127)
          ? (cb.blue -
                  (1 - 2 * (cs.blue / 255)) * cb.blue * (1 - cb.blue / 255))
              .toInt()
          : (cb.blue + (2 * (cs.blue / 255) - 1) * (d(cb.blue) - cb.blue / 255))
              .toInt(),
      255,
    );
  }

  // Difference Blend Mode
  /// Calculates the absolute difference between the background and source
  /// colors. This mode is often used for creating special effects or for
  /// spotting differences between two images, as it highlights the differences
  /// between the colors.
  static IntColor difference(IntColor cb, IntColor cs) {
    return IntColor.fromRGBA(
      (cb.red - cs.red).abs(),
      (cb.green - cs.green).abs(),
      (cb.blue - cs.blue).abs(),
      255,
    );
  }

  // Exclusion Blend Mode
  /// Produces an effect similar to `difference`, but with lower contrast.
  /// Exclusion blend mode is useful for adding texture and depth to images,
  /// as it tends to retain more of the background color than the
  /// difference mode.
  static IntColor exclusion(IntColor cb, IntColor cs) {
    return IntColor.fromRGBA(
      cb.red + cs.red - 2 * cb.red * cs.red ~/ 255,
      cb.green + cs.green - 2 * cb.green * cs.green ~/ 255,
      cb.blue + cs.blue - 2 * cb.blue * cs.blue ~/ 255,
      255,
    );
  }

  // Hue Blend Mode
  /// Creates a color with the hue of the source color and the saturation and
  /// luminosity of the backdrop color.
  static IntColor hue(IntColor cb, IntColor cs) {
    return cs.setSaturation(cb.saturation).setLuminosity(cb.luminosity);
  }

  // Saturation Blend Mode
  /// Creates a color with the saturation of the source color and the hue and
  /// luminosity of the backdrop color.
  static IntColor saturation(IntColor cb, IntColor cs) {
    return cb.setSaturation(cs.saturation).setLuminosity(cb.luminosity);
  }

  // Color Blend Mode
  /// Creates a color with the hue and saturation of the source color and the
  /// luminosity of the backdrop color.
  static IntColor color(IntColor cb, IntColor cs) {
    return cs.setLuminosity(cb.luminosity);
  }

  // Luminosity Blend Mode
  /// Creates a color with the luminosity of the source color and the hue and
  /// saturation of the backdrop color.
  static IntColor luminosity(IntColor cb, IntColor cs) {
    return cb.setLuminosity(cs.luminosity);
  }
}
