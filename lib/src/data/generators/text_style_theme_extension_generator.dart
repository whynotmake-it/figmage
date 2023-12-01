import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/values_by_mode_theme_extension_generator.dart';
import 'package:figmage/src/domain/models/text_style/text_style.dart';

// TODO(Jesper): fix all this
ConstructorArguments _textStyleConstructorArguments(TextStyle textStyle) {
  return (
    positionalArguments: [],
    namedArguments: <String, Expression>{
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
    },
    typeArguments: const []
  );
}

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
    super.extensionSymbolUrl = 'package:flutter/material.dart',
    super.buildContextExtensionNullable = false,
  }) : super(
          extensionSymbol: 'TextStyle',
          valueToConstructorArguments: _textStyleConstructorArguments,
        );
}
