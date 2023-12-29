import 'package:freezed_annotation/freezed_annotation.dart';

part 'typography.freezed.dart';

/// The applied text decoration
enum TextDecoration {
  /// No decoration
  none,

  /// A strike through decoration
  lineThrough,

  /// An underline decoration
  underline,

  /// An overline decoration
  overline
}

/// Whether to slant the glyphs in the font
enum FontStyle {
  /// Use the upright glyphs
  normal,

  /// Use glyphs designed for slanting
  italic,
}

/// {@template text_style}
/// Contains all values that can be applied to a text style.
///
/// Basically represents a Flutter `TextStyle`.
/// {@endtemplate}
@freezed
sealed class Typography with _$Typography {
  /// {@macro text_style}
  const factory Typography({
    required String fontFamily,
    required String? fontFamilyPostScriptName,
    required double fontSize,
    @Default(400) int fontWeight,
    @Default(TextDecoration.none) TextDecoration decoration,
    @Default(FontStyle.normal) FontStyle fontStyle,
    @Default(1.0) double letterSpacing,
    @Default(1.0) double wordSpacing,
    @Default(1.0) double height,
  }) = _Typography;

  const Typography._();
}
