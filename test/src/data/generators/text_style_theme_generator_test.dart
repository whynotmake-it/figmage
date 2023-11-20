import 'package:figma/figma.dart';
import 'package:figmage/src/data/generators/text_style_theme_extension_generator.dart';
import 'package:test/test.dart';

void main() {
  test('Generates a ThemeExtension<MyTextStyles> output file', () async {
    final generator = TextStyleThemeExtensionGenerator(
      className: 'MyTextStyles',
      valuesByNameByMode: {
        'mode1': {
          'textStyle1': TypeStyle(
            fontSize: 16,
            fontWeight: 500,
            fontFamily: 'Roboto',
            textDecoration: TextDecoration.underline,
            letterSpacing: 1,
          ),
          'textStyle2': TypeStyle(
            fontSize: 32,
            fontWeight: 900,
            fontFamily: 'Roboto',
            textDecoration: TextDecoration.strikeThrough,
            letterSpacing: 1,
          ),
        },
        'mode2': {
          'textStyle1': TypeStyle(
            fontSize: 1,
            fontWeight: 400,
            fontFamily: 'Roboto',
            textDecoration: TextDecoration.underline,
            letterSpacing: 1,
          ),
          'textStyle2': TypeStyle(
            fontSize: 2,
            fontWeight: 400,
            fontFamily: 'Roboto',
            textDecoration: TextDecoration.strikeThrough,
            letterSpacing: 1,
          ),
        },
      },
      extensionSymbolUrl: 'dart:ui',
    );
    expect(generator.generate(), _expectedTextStyleThemeExtensionString);
  });
  test('Output file with nullable BuildContext extension', () async {
    final generator = TextStyleThemeExtensionGenerator(
      className: 'MyTextStyles',
      valuesByNameByMode: {
        'mode1': {
          'textStyle1': TypeStyle(
            fontSize: 16,
            fontWeight: 500,
            fontFamily: 'Roboto',
            textDecoration: TextDecoration.underline,
            letterSpacing: 1,
          ),
          'textStyle2': TypeStyle(
            fontSize: 32,
            fontWeight: 900,
            fontFamily: 'Roboto',
            textDecoration: TextDecoration.strikeThrough,
            letterSpacing: 1,
          ),
        },
        'mode2': {
          'textStyle1': TypeStyle(
            fontSize: 1,
            fontWeight: 400,
            fontFamily: 'Roboto',
            textDecoration: TextDecoration.underline,
            letterSpacing: 1,
          ),
          'textStyle2': TypeStyle(
            fontSize: 2,
            fontWeight: 400,
            fontFamily: 'Roboto',
            textDecoration: TextDecoration.strikeThrough,
            letterSpacing: 1,
          ),
        },
      },
      extensionSymbolUrl: 'dart:ui',
      buildContextExtensionNullable: true,
    );

    expect(
      generator.generate(),
      _expectedNullableTextStyleThemeExtensionString,
    );
  });
}

// **************************************************************************
// TEST RESOURCES
// **************************************************************************
const _expectedTextStyleThemeExtensionString = '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
class MyTextStyles extends ThemeExtension<MyTextStyles> {
  const MyTextStyles({
    required this.textStyle1,
    required this.textStyle2,
  });

  final TextStyle? textStyle1;

  final TextStyle? textStyle2;

  @override
  MyTextStyles copyWith([
    TextStyle? textStyle1,
    TextStyle? textStyle2,
  ]) =>
      MyTextStyles(
        textStyle1: textStyle1 ?? this.textStyle1,
        textStyle2: textStyle2 ?? this.textStyle2,
      );

  @override
  MyTextStyles lerp(
    MyTextStyles? other,
    double t,
  ) {
    if (other is! MyTextStyles) return this;
    return MyTextStyles(
      textStyle1: TextStyle.lerp(
        textStyle1,
        other.textStyle1,
        t,
      ),
      textStyle2: TextStyle.lerp(
        textStyle2,
        other.textStyle2,
        t,
      ),
    );
  }
}

extension MyTextStylesBuildContextX on BuildContext {
  MyTextStyles get myTextStyles => Theme.of(this).extension<MyTextStyles>()!;
}

const MyTextStyles mode1MyTextStyles = MyTextStyles(
  textStyle1: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    letterSpacing: 1,
    decoration: TextDecoration.underline,
    fontFamily: 'Roboto',
  ),
  textStyle2: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.normal,
    letterSpacing: 1,
    decoration: TextDecoration.lineThrough,
    fontFamily: 'Roboto',
  ),
);
const MyTextStyles mode2MyTextStyles = MyTextStyles(
  textStyle1: TextStyle(
    fontSize: 1,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    letterSpacing: 1,
    decoration: TextDecoration.underline,
    fontFamily: 'Roboto',
  ),
  textStyle2: TextStyle(
    fontSize: 2,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    letterSpacing: 1,
    decoration: TextDecoration.lineThrough,
    fontFamily: 'Roboto',
  ),
);
''';
const _expectedNullableTextStyleThemeExtensionString = '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
class MyTextStyles extends ThemeExtension<MyTextStyles> {
  const MyTextStyles({
    required this.textStyle1,
    required this.textStyle2,
  });

  final TextStyle? textStyle1;

  final TextStyle? textStyle2;

  @override
  MyTextStyles copyWith([
    TextStyle? textStyle1,
    TextStyle? textStyle2,
  ]) =>
      MyTextStyles(
        textStyle1: textStyle1 ?? this.textStyle1,
        textStyle2: textStyle2 ?? this.textStyle2,
      );

  @override
  MyTextStyles lerp(
    MyTextStyles? other,
    double t,
  ) {
    if (other is! MyTextStyles) return this;
    return MyTextStyles(
      textStyle1: TextStyle.lerp(
        textStyle1,
        other.textStyle1,
        t,
      ),
      textStyle2: TextStyle.lerp(
        textStyle2,
        other.textStyle2,
        t,
      ),
    );
  }
}

extension MyTextStylesBuildContextX on BuildContext {
  MyTextStyles? get myTextStyles => Theme.of(this).extension<MyTextStyles>();
}

const MyTextStyles mode1MyTextStyles = MyTextStyles(
  textStyle1: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    letterSpacing: 1,
    decoration: TextDecoration.underline,
    fontFamily: 'Roboto',
  ),
  textStyle2: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.normal,
    letterSpacing: 1,
    decoration: TextDecoration.lineThrough,
    fontFamily: 'Roboto',
  ),
);
const MyTextStyles mode2MyTextStyles = MyTextStyles(
  textStyle1: TextStyle(
    fontSize: 1,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    letterSpacing: 1,
    decoration: TextDecoration.underline,
    fontFamily: 'Roboto',
  ),
  textStyle2: TextStyle(
    fontSize: 2,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    letterSpacing: 1,
    decoration: TextDecoration.lineThrough,
    fontFamily: 'Roboto',
  ),
);
''';
