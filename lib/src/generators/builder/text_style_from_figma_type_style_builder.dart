import 'package:code_builder/code_builder.dart';
import 'package:figma/figma.dart';
import 'package:figmage/src/generators/theme_extension_generator.dart';

ValueArguments textStyleFromFigmaTypeStyle(TypeStyle typeStyle) {
  final textStyleExpressions = _getTextStyleExpressions(typeStyle: typeStyle);
  return (
    positionalArguments: [],
    namedArguments: textStyleExpressions,
    typeArguments: const []
  );
}

Map<String, Expression> _getTextStyleExpressions({
  required TypeStyle typeStyle,
}) {
  return <String, Expression>{
    //'inherit':
    //'color': Maybe from fills? API is weird
    //'backgroundColor':
    'fontSize': literal(typeStyle.fontSize),
    'fontWeight':
        refer('FontWeight').property('w${typeStyle.fontWeight?.toInt()}'),
    'fontStyle': refer('FontStyle')
        .property(typeStyle.italic == true ? 'italic' : 'normal'),
    'letterSpacing': literal(typeStyle.letterSpacing),
    //'wordSpacing':
    //'textBaseline':
    //'height':
    //'leadingDistribution':
    //'locale':
    //'foreground':
    //'background':
    //'shadows':
    //'fontFeatures':
    //'fontVariations':
    'decoration': _getTextDecoration(typeStyle.textDecoration),
    //'decorationColor':
    //'decorationStyle':
    //'decorationThickness':
    //'debugLabel':
    'fontFamily': literal(typeStyle.fontFamily),
    //'fontFamilyFallback':
    //'package':
    //'overflow':
  };
}

Expression _getTextDecoration(TextDecoration? decoration) {
  return switch (decoration) {
    TextDecoration.strikeThrough =>
      refer('TextDecoration', 'dart:ui').property('lineThrough'),
    TextDecoration.underline =>
      refer('TextDecoration', 'dart:ui').property('underline'),
    null => refer('TextDecoration').property('none'),
  };
}
