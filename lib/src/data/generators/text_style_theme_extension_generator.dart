import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/values_by_mode_theme_extension_generator.dart';
import 'package:figmage/src/domain/models/text_style/text_style.dart';
import 'package:meta/meta.dart' show visibleForTesting;

const _textStyleReference = Reference(
  'TextStyle',
  'package:flutter/material.dart',
);

/// {@template text_style_theme_extension_generator}
/// A [ValuesByModeThemeExtensionGenerator] for text style themes from Figma's
/// TypeStyle.
/// {@endtemplate}
class TextStyleThemeExtensionGenerator
    extends ValuesByModeThemeExtensionGenerator<TextStyle> {
  /// {@macro text_style_theme_extension_generator}
  TextStyleThemeExtensionGenerator({
    required super.className,
    required super.valuesByNameByMode,
    required this.useGoogleFonts,
    super.buildContextExtensionNullable = false,
  }) : super(
          extensionSymbolReference: _textStyleReference,
        );

  /// Whether to use the google_fonts package for initializing TextStyles
  /// instead of the default TextStyle constructor.
  final bool useGoogleFonts;

  @override
  Expression getConstructorExpression(TextStyle value) {
    if (useGoogleFonts) {
      return _googleFontsConstructorExpression();
    } else {
      return _textStyleReference.constInstance(
        [],
        getNamedArguments(value),
      );
    }
  }

  Expression _googleFontsConstructorExpression() {
    // TODO(tim): implement _googleFontsConstructorExpression
    throw UnimplementedError();
  }

  /// Returns the constructor arguments for a [TextStyle] from an instance of
  /// a [TextStyle].
  ///
  /// Only visible for testing.
  @visibleForTesting
  Map<String, Expression> getNamedArguments(TextStyle textStyle) {
    return <String, Expression>{
      'fontFamily': literal(textStyle.fontFamily),
      'fontSize': literal(textStyle.fontSize),
      'fontWeight': refer('FontWeight').property('w${textStyle.fontWeight}'),
      'fontStyle': refer('FontStyle').property(
        switch (textStyle.fontStyle) {
          FontStyle.italic => 'italic',
          FontStyle.normal => 'normal',
        },
      ),
      'letterSpacing': literal(textStyle.letterSpacing),
      'height': literal(textStyle.height),
      'decoration': refer('TextDecoration').property(
        switch (textStyle.decoration) {
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
