import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_style.freezed.dart';

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
/// Represents a Flutter `TextStyle`.
/// {@endtemplate}
@freezed
sealed class TextStyle with _$TextStyle {
  /// {@macro text_style}
  const factory TextStyle({
    required String fontFamily,
    required String fontFamilyPostScriptName,
    required double fontSize,
    @Default(400) int fontWeight,
    @Default(TextDecoration.none) TextDecoration decoration,
    @Default(FontStyle.normal) FontStyle fontStyle,
    @Default(1.0) double letterSpacing,
    @Default(1.0) double wordSpacing,
    @Default(1.0) double height,
  }) = _TextStyle;

  const TextStyle._();
}
