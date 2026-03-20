import 'package:figma/figma.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
import 'package:meta/meta.dart';

/// An extension providing the method to for converting a [TypeStyle] to a
/// [Typography].
extension TypeStyleConversionX on TypeStyle {
  static const int _minFontWeight = 1;
  static const int _maxFontWeight = 1000;

  /// Converts a [TypeStyle] to a [Typography].
  Typography toDomain({
    void Function(String message)? onDiagnostic,
    String? diagnosticContext,
  }) => Typography(
    fontFamily: fontFamily!,
    fontFamilyPostScriptName: fontPostScriptName,
    fontSize: fontSize!.toDouble(),
    fontWeight: convertFontWeight(
      fontWeight ?? 400,
      onDiagnostic: onDiagnostic,
      diagnosticContext: diagnosticContext,
    ),
    fontStyle: italic ? FontStyle.italic : FontStyle.normal,
    letterSpacing: letterSpacing?.toDouble() ?? 0,
    height: convertLineHeight(lineHeightPx, fontSize),
  );

  /// Makes sure that the font weight is between 1 and 1000.
  static int convertFontWeight(
    num weight, {
    void Function(String message)? onDiagnostic,
    String? diagnosticContext,
  }) {
    final rounded = weight.round();
    final clamped = rounded.clamp(_minFontWeight, _maxFontWeight);
    if (clamped != rounded) {
      final msg = 'Clamped fontWeight from $weight to $clamped. '
          'Valid range is $_minFontWeight..$_maxFontWeight';
      onDiagnostic?.call(
        diagnosticContext != null ? '$msg at $diagnosticContext.' : '$msg.',
      );
    }
    return clamped;
  }

  /// Converts the line height to the way Flutter expects it, relative to the
  /// font size.
  @visibleForTesting
  static double convertLineHeight(num? lineHeight, num? fontSize) {
    if (lineHeight == null || fontSize == null) {
      return 1;
    }
    return lineHeight / fontSize;
  }
}
