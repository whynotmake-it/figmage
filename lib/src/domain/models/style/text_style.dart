import 'package:figma/figma.dart';
import 'package:figmage/src/domain/models/style/design_style.dart';

/// {@template text_style}
/// A style for typography.
/// {@endtemplate}
class TextStyle extends DesignStyle<TypeStyle> {
  /// {@macro text_style}
  const TextStyle({
    required super.id,
    required super.name,
    required super.value,
  });

  /// Returns the line height the way Flutter expects it.
  double? get flutterLineHeight {
    if (value.lineHeightPx == null || value.fontSize == null) {
      return null;
    }
    final lh = value.lineHeightPx! / value.fontSize!;
    return lh;
  }

  /// Makes sure the font weight is a valid Flutter font weight.
  int? get flutterFontWeight {
    if (value.fontWeight case final weight?) {
      final corrected = (weight ~/ 100) * 100;
      return corrected.clamp(100, 900);
    }
    return null;
  }
}
