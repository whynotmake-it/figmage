import 'package:figmage/src/data/generators/number_theme_extension_generator.dart';
import 'package:test/test.dart';

void main() {
  test('Generates a ThemeExtension<MyColorTheme> output file', () async {
    final generator = NumberThemeExtensionGenerator(
      className: 'MyNumbersTheme',
      valuesByNameByMode: {
        'small': {'s': 1.0, 'm': 2.0},
        'large': {'s': 2.0, 'm': 4.0},
      },
    );
    expect(generator.generate(), equals(_expectedNumberExtensionString));
  });
  test('Generates output file with nullable BuildContext extension', () async {
    final generator = NumberThemeExtensionGenerator(
      className: 'MyNumbersTheme',
      valuesByNameByMode: {
        'small': {'s': 1.0, 'm': 2.0},
        'large': {'s': 2.0, 'm': 4.0},
      },
      buildContextExtensionNullable: true,
    );
    expect(
      generator.generate(),
      equals(_expectedNullableNumberExtensionString),
    );
  });
}
// **************************************************************************
// TEST RESOURCES
// **************************************************************************

const _expectedNumberExtensionString = '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
class MyNumbersTheme extends ThemeExtension<MyNumbersTheme> {
  const MyNumbersTheme({
    required this.s,
    required this.m,
  });

  final double? s;

  final double? m;

  @override
  MyNumbersTheme copyWith([
    double? s,
    double? m,
  ]) =>
      MyNumbersTheme(
        s: s ?? this.s,
        m: m ?? this.m,
      );

  @override
  MyNumbersTheme lerp(
    MyNumbersTheme? other,
    double t,
  ) {
    if (other is! MyNumbersTheme) return this;
    return MyNumbersTheme(
      s: lerpDouble(
        s,
        other.s,
        t,
      ),
      m: lerpDouble(
        m,
        other.m,
        t,
      ),
    );
  }
}

extension MyNumbersThemeBuildContextX on BuildContext {
  MyNumbersTheme get myNumbersTheme =>
      Theme.of(this).extension<MyNumbersTheme>()!;
}

const MyNumbersTheme smallMyNumbersTheme = MyNumbersTheme(
  s: 1.0,
  m: 2.0,
);
const MyNumbersTheme largeMyNumbersTheme = MyNumbersTheme(
  s: 2.0,
  m: 4.0,
);
''';
const _expectedNullableNumberExtensionString = '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
class MyNumbersTheme extends ThemeExtension<MyNumbersTheme> {
  const MyNumbersTheme({
    required this.s,
    required this.m,
  });

  final double? s;

  final double? m;

  @override
  MyNumbersTheme copyWith([
    double? s,
    double? m,
  ]) =>
      MyNumbersTheme(
        s: s ?? this.s,
        m: m ?? this.m,
      );

  @override
  MyNumbersTheme lerp(
    MyNumbersTheme? other,
    double t,
  ) {
    if (other is! MyNumbersTheme) return this;
    return MyNumbersTheme(
      s: lerpDouble(
        s,
        other.s,
        t,
      ),
      m: lerpDouble(
        m,
        other.m,
        t,
      ),
    );
  }
}

extension MyNumbersThemeBuildContextX on BuildContext {
  MyNumbersTheme? get myNumbersTheme =>
      Theme.of(this).extension<MyNumbersTheme>();
}

const MyNumbersTheme smallMyNumbersTheme = MyNumbersTheme(
  s: 1.0,
  m: 2.0,
);
const MyNumbersTheme largeMyNumbersTheme = MyNumbersTheme(
  s: 2.0,
  m: 4.0,
);
''';
