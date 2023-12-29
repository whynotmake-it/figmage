import 'package:figma/figma.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
import 'package:meta/meta.dart';

/// An extension providing the method to for converting a [TypeStyle] to a
/// [Typography].
extension TypeStyleConversionX on TypeStyle {
  /// Converts a [TypeStyle] to a [Typography].
  Typography toDomain() => Typography(
        fontFamily: fontFamily!,
        fontFamilyPostScriptName: fontPostScriptName,
        fontSize: fontSize!.toDouble(),
        fontWeight: convertFontWeight(fontWeight ?? 400),
        fontStyle: italic ?? false ? FontStyle.italic : FontStyle.normal,
        letterSpacing: letterSpacing?.toDouble() ?? 0,
        height: convertLineHeight(lineHeightPx, fontSize),
      );

  /// Makes sure that the font weight is between 100 and 900 in increments of
  /// 100.
  @visibleForTesting
  int convertFontWeight(num weight) {
    final incremented = (weight / 100).round() * 100;
    return switch (incremented) {
      > 900 => 900,
      < 100 => 100,
      _ => incremented,
    };
  }

  /// Converts the line height to the way Flutter expects it, relative to the
  /// font size.
  @visibleForTesting
  double convertLineHeight(num? lineHeight, num? fontSize) {
    if (lineHeight == null || fontSize == null) {
      return 1;
    }
    return lineHeight / fontSize;
  }
}
