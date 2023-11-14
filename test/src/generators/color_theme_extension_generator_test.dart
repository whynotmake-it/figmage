import 'package:figmage/src/generators/color_theme_extension_generator.dart';
import 'package:test/test.dart';

void main() {
  test('Output file with a non-nullable BuildContext extension', () async {
    final generator = ColorThemeExtensionGenerator(
      className: 'MyColorTheme',
      valuesByNameByMode: {
        'mode 1': {'color1': 0xFF000000, 'color2': 0xFFFFFFFF},
        'mode2': {'color1': 0xFF111111, 'color2': 0xFF222222},
      },
    );
    expect(generator.generate(), equals(_expectedColorThemeExtensionString));
  });
  test('Output file with a nullable BuildContext extension', () async {
    final generator = ColorThemeExtensionGenerator(
      className: 'MyColorTheme',
      valuesByNameByMode: {
        'mode 1': {'color1': 0xFF000000, 'color2': 0xFFFFFFFF},
        'mode2': {'color1': 0xFF111111, 'color2': 0xFF222222},
      },
      buildContextExtensionNullable: true,
    );
    expect(
      generator.generate(),
      equals(_expectedNullableColorThemeExtensionString),
    );
  });
}

// **************************************************************************
// TEST RESOURCES
// **************************************************************************

const _expectedColorThemeExtensionString = '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

extension MyColorThemeBuildContextX on BuildContext {
  MyColorTheme get myColorTheme => Theme.of(this).extension<MyColorTheme>()!;
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

const _expectedNullableColorThemeExtensionString = '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

extension MyColorThemeBuildContextX on BuildContext {
  MyColorTheme? get myColorTheme => Theme.of(this).extension<MyColorTheme>();
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
