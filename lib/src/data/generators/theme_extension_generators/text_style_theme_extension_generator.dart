import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/theme_extension_generators/mode_theme_extension_generator.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
import 'package:meta/meta.dart' show visibleForTesting;

const _textStyleReference = Reference(
  'TextStyle',
  'package:flutter/material.dart',
);

const _googleFontsReference = Reference(
  'GoogleFonts',
  'package:google_fonts/google_fonts.dart',
);

/// {@template text_style_theme_extension_generator}
/// A [ModeThemeExtensionGenerator] for text style themes from
/// [Typography] data.
/// {@endtemplate}
class TextStyleThemeExtensionGenerator
    extends ModeThemeExtensionGenerator<Typography> {
  /// {@macro text_style_theme_extension_generator}
  TextStyleThemeExtensionGenerator({
    required super.className,
    required super.valuesByNameByMode,
    required this.useGoogleFonts,
    required super.interfaces,
    super.buildContextExtensionNullable = false,
  }) : super(symbolReference: _textStyleReference);

  /// Whether to use the google_fonts package for initializing TextStyles
  /// instead of the default TextStyle constructor.
  final bool useGoogleFonts;

  @override
  Expression getConstructorExpression(Typography value) {
    if (useGoogleFonts) {
      return _googleFontsReference.newInstanceNamed(
        "getFont",
        [literalString(value.fontFamily)],
        getNamedArguments(value, includeFamily: false),
      );
    } else {
      return _textStyleReference.constInstance(
        [],
        getNamedArguments(value),
      );
    }
  }

  /// Returns the constructor arguments for a Flutter `TextStyle` from an
  /// instance of a [Typography].
  ///
  /// Only visible for testing. If [includeFamily] is false, the `fontFamily`
  /// argument will be omitted (used for Google Fonts call).
  @visibleForTesting
  Map<String, Expression> getNamedArguments(
    Typography typography, {
    bool includeFamily = true,
  }) {
    return <String, Expression>{
      if (includeFamily) 'fontFamily': literalString(typography.fontFamily),
      'fontSize': literal(typography.fontSize),
      'fontWeight': refer('FontWeight').property('w${typography.fontWeight}'),
      'fontStyle': refer('FontStyle').property(
        switch (typography.fontStyle) {
          FontStyle.italic => 'italic',
          FontStyle.normal => 'normal',
        },
      ),
      'letterSpacing': literal(typography.letterSpacing),
      'height': literal(typography.height),
      'decoration': refer('TextDecoration').property(
        switch (typography.decoration) {
          TextDecoration.none => 'none',
          TextDecoration.lineThrough => 'lineThrough',
          TextDecoration.underline => 'underline',
          TextDecoration.overline => 'overline',
        },
      ),
      //'inherit':
      //'color': Maybe from fills? API is weird
      //'backgroundColor':
      //'wordSpacing':
      //'textBaseline':
      //'leadingDistribution':
      //'locale':
      //'foreground':
      //'background':
      //'shadows':
      //'fontFeatures':
      //'fontVariations':
      //'decorationColor':
      //'decorationStyle':
      //'decorationThickness':
      //'debugLabel':
      //'fontFamilyFallback':
      //'package':
      //'overflow':
    };
  }
}
