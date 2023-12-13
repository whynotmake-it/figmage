import 'package:figmage/src/data/generators/text_style_theme_extension_generator.dart';
import 'package:figmage/src/domain/models/text_style/text_style.dart';
import 'package:test/test.dart';

void main() {
  group('TextStyleThemeExtensionsGenerator', () {
    const valuesByNameByMode = {
      'mode1': {
        'textStyle1': TextStyle(
          fontSize: 16,
          fontFamily: 'Roboto',
          decoration: TextDecoration.underline,
        ),
        'textStyle2': TextStyle(
          fontSize: 24,
          fontFamily: 'Roboto',
          decoration: TextDecoration.lineThrough,
        ),
      },
      'mode2': {
        'textStyle1': TextStyle(
          fontSize: 16,
          fontFamily: 'Roboto',
          fontWeight: 700,
          decoration: TextDecoration.underline,
        ),
        'textStyle2': TextStyle(
          fontSize: 24,
          fontFamily: 'Roboto',
          fontWeight: 700,
          decoration: TextDecoration.lineThrough,
        ),
      },
    };
    test('generates correct output file without google fonts', () async {
      final generator = TextStyleThemeExtensionGenerator(
        className: 'MyTextStyles',
        valuesByNameByMode: valuesByNameByMode,
        extensionSymbolUrl: 'dart:ui',
        useGoogleFonts: false,
      );
      expect(generator.generate(), _expectedTextStyleThemeExtensionString);
    });
    test('generates correct output file with nullable BuildContext extension',
        () async {
      final generator = TextStyleThemeExtensionGenerator(
        className: 'MyTextStyles',
        valuesByNameByMode: valuesByNameByMode,
        extensionSymbolUrl: 'dart:ui',
        buildContextExtensionNullable: true,
        useGoogleFonts: false,
      );

      expect(
        generator.generate(),
        _expectedNullableTextStyleThemeExtensionString,
      );
    });
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

@immutable
class MyTextStyles extends ThemeExtension<MyTextStyles> {
  const MyTextStyles({
    required this.textStyle1,
    required this.textStyle2,
  });

  const MyTextStyles.mode1()
      : textStyle1 = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.0,
          height: 1.0,
          decoration: TextDecoration.underline,
        ),
        textStyle2 = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24.0,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.0,
          height: 1.0,
          decoration: TextDecoration.lineThrough,
        );

  const MyTextStyles.mode2()
      : textStyle1 = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.0,
          height: 1.0,
          decoration: TextDecoration.underline,
        ),
        textStyle2 = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.0,
          height: 1.0,
          decoration: TextDecoration.lineThrough,
        );

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
''';

const _expectedNullableTextStyleThemeExtensionString = '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MyTextStyles extends ThemeExtension<MyTextStyles> {
  const MyTextStyles({
    required this.textStyle1,
    required this.textStyle2,
  });

  const MyTextStyles.mode1()
      : textStyle1 = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.0,
          height: 1.0,
          decoration: TextDecoration.underline,
        ),
        textStyle2 = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24.0,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.0,
          height: 1.0,
          decoration: TextDecoration.lineThrough,
        );

  const MyTextStyles.mode2()
      : textStyle1 = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.0,
          height: 1.0,
          decoration: TextDecoration.underline,
        ),
        textStyle2 = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.0,
          height: 1.0,
          decoration: TextDecoration.lineThrough,
        );

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
''';
