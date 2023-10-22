import 'package:build_test/build_test.dart';
import 'package:figma/figma.dart';
import 'package:figmage/src/generators/builder/color_from_int_builder.dart';
import 'package:figmage/src/generators/builder/text_style_from_figma_type_style_builder.dart';
import 'package:figmage/src/generators/theme_extension_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

import 'util/printer_asset_writer.dart';

void main() {
  tearDown(() {
    // Increment this after each test so the next test has it's own package
    _pkgCacheCount++;
  });

  test('Generates a ThemeExtension<MyColorTheme> output file', () async {
    final generator = ThemeExtensionGenerator<int>(
      className: 'MyColorTheme',
      valueMaps: {
        'mode1': {'color1': 0xFF000000, 'color2': 0xFFFFFFFF},
        'mode2': {'color1': 0xFF111111, 'color2': 0xFF222222},
      },
      extensionSymbol: 'Color',
      extensionSymbolUrl: 'package:flutter/material.dart',
      valueToConstructorArguments: colorFromIntBuilder,
    );

    final builder = LibraryBuilder(generator);

    final srcs = _createPackageStub();

    final writer = PrintAssetWriter();

    await testBuilder(
      builder,
      srcs,
      writer: writer,
      generateFor: {'$_pkgName|lib/test_lib.dart'},
      outputs: {
        '$_pkgName|lib/test_lib.g.dart': _expectedColorThemeExtensionString,
      },
    );
  });

  test('Generates a ThemeExtension<MyTextStyles> output file', () async {
    final generator = ThemeExtensionGenerator<TypeStyle>(
      className: 'MyTextStyles',
      valueMaps: {
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
      extensionSymbol: 'TextStyle',
      extensionSymbolUrl: 'dart:ui',
      valueToConstructorArguments: (TypeStyle value) {
        return textStyleFromFigmaTypeStyle(value);
      },
    );

    final builder = LibraryBuilder(generator);

    final srcs = _createPackageStub();

    final writer = PrintAssetWriter();

    await testBuilder(
      builder,
      srcs,
      writer: writer,
      generateFor: {'$_pkgName|lib/test_lib.dart'},
      outputs: {
        '$_pkgName|lib/test_lib.g.dart': _expectedTextStyleThemeExtensionString,
      },
    );
  });
}

Map<String, String> _createPackageStub({
  String? testLibContent,
}) =>
    {
      '$_pkgName|lib/test_lib.dart': testLibContent ?? _testLibContent,
    };

// **************************************************************************
// TEST RESOURCES
// **************************************************************************

// Ensure every test gets its own unique package name
String get _pkgName => 'pkg$_pkgCacheCount';
int _pkgCacheCount = 1;

const _testLibContent = r'''
library test_lib;
''';

const _expectedColorThemeExtensionString =
    r'''// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: ThemeExtensionGenerator<int>
// **************************************************************************

@immutable
class MyColorTheme extends ThemeExtension<MyColorTheme> {
  const MyColorTheme({
    required this.color1,
    required this.color2,
  });

  final Color? color1;

  final Color? color2;

  @override
  MyColorTheme copyWith([
    Color? color1,
    Color? color2,
  ]) =>
      MyColorTheme(
        color1: color1 ?? this.color1,
        color2: color2 ?? this.color2,
      );

  @override
  MyColorTheme lerp(
    MyColorTheme? other,
    double t,
  ) {
    if (other is! MyColorTheme) return this;
    return MyColorTheme(
      color1: Color.lerp(
        color1,
        other.color1,
        t,
      ),
      color2: Color.lerp(
        color2,
        other.color2,
        t,
      ),
    );
  }
}

const MyColorTheme mode1MyColorTheme = MyColorTheme(
  color1: Color(0xff000000),
  color2: Color(0xffffffff),
);

const MyColorTheme mode2MyColorTheme = MyColorTheme(
  color1: Color(0xff111111),
  color2: Color(0xff222222),
);
''';

const _expectedTextStyleThemeExtensionString =
    r'''// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: ThemeExtensionGenerator<TypeStyle>
// **************************************************************************

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
