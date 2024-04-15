import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/theme_extension_generators/values_by_mode_theme_extension_generator.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
import 'package:meta/meta.dart' show visibleForTesting;

const _textStyleReference = Reference(
  'TextStyle',
  'package:flutter/material.dart',
);

/// {@template text_style_theme_extension_generator}
/// A [ValuesByModeThemeExtensionGenerator] for text style themes from
/// [Typography] data.
/// {@endtemplate}
class TextStyleThemeExtensionGenerator
    extends ValuesByModeThemeExtensionGenerator<Typography> {
  /// {@macro text_style_theme_extension_generator}
  TextStyleThemeExtensionGenerator({
    required super.className,
    required super.valuesByNameByMode,
    required this.useGoogleFonts,
    super.buildContextExtensionNullable = false,
  }) : super(
          symbolReference: _textStyleReference,
        );

  /// Whether to use the google_fonts package for initializing TextStyles
  /// instead of the default TextStyle constructor.
  final bool useGoogleFonts;

  @override
  Expression getConstructorExpression(Typography value) {
    if (useGoogleFonts) {
      return _googleFontsConstructorExpression(value);
    } else {
      return _textStyleReference.constInstance(
        [],
        getNamedArguments(value),
      );
    }
  }

  Expression _googleFontsConstructorExpression(Typography value) {
    // TODO(tim): #29 bring this back once dependcies are resolved
    /** 
    final allFonts = GoogleFonts.asMap();
    final validFontName = switch ((
      allFonts.containsKey(value.fontFamily),
      allFonts.containsKey(value.fontFamilyPostScriptName),
    )) {
      (true, _) => value.fontFamily,
      (_, true) => value.fontFamilyPostScriptName,
      (false, false) => null,
    };
    if (validFontName == null) {
      return _textStyleReference.constInstance([], getNamedArguments(value));
    }
    */
    final googleFontsReference = refer(
      'GoogleFonts',
      'package:google_fonts/google_fonts.dart',
    );

    return googleFontsReference.property("getFont").call(
      [literal(value.fontFamily)],
      getNamedArguments(value, includeFamily: false),
    );
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
      if (includeFamily) 'fontFamily': literal(typography.fontFamily),
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
