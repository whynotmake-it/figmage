import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:figmage/src/data/generators/color_theme_extension_generator.dart';
import 'package:test/test.dart';

import 'common.dart';

void main() {
  useDartfmt();

  test('Should create a class and non-nullable BuildContext extension', () {
    final generator = ColorThemeExtensionGenerator(
      className: 'MyColorTheme',
      valuesByNameByMode: {
        'mode 1': {'color1': 0xFF000000, 'color2': 0xFFFFFFFF},
        'mode2': {'color1': 0xFF111111, 'color2': 0xFF222222},
      },
    );
    expect(
      generator.generate().$class,
      equalsDart(
        _expectedColorThemeExtensionClassString,
        DartEmitter(
          allocator: Allocator(),
          useNullSafetySyntax: true,
          orderDirectives: true,
        ),
      ),
    );
    expect(
      generator.generate().$extension,
      equalsDart(_expectedColorThemeExtensionBuildContextExtensionString),
    );
  });
  test('Should create a nullable BuildContext extension', () async {
    final generator = ColorThemeExtensionGenerator(
      className: 'MyColorTheme',
      valuesByNameByMode: {
        'mode 1': {'color1': 0xFF000000, 'color2': 0xFFFFFFFF},
        'mode2': {'color1': 0xFF111111, 'color2': 0xFF222222},
      },
      buildContextExtensionNullable: true,
    );
    expect(
      generator.generate().$class,
      equalsDart(
        _expectedNullableColorThemeExtensionClassString,
        DartEmitter(
          allocator: Allocator(),
          useNullSafetySyntax: true,
          orderDirectives: true,
        ),
      ),
    );
    expect(
      generator.generate().$extension,
      equalsDart(
          _expectedNullableColorThemeExtensionBuildContextExtensionString),
    );
  });

  test('Can deal with only one empty mode', () async {
    final generator = ColorThemeExtensionGenerator(
      className: 'MyColorTheme',
      valuesByNameByMode: {
        '': {'color1': 0xFF000000, 'color2': 0xFFFFFFFF},
      },
      buildContextExtensionNullable: true,
    );
    expect(
      generator.generate().$class,
      equalsDart(
        _expectedSingleModeOutputString,
        DartEmitter(
          allocator: Allocator(),
          useNullSafetySyntax: true,
          orderDirectives: true,
        ),
      ),
    );
  });
}

// **************************************************************************
// TEST RESOURCES
// **************************************************************************

const _expectedColorThemeExtensionClassString = '''
@immutable
class MyColorTheme extends ThemeExtension<MyColorTheme> {
  const MyColorTheme({
    required this.color1,
    required this.color2,
  });

  const MyColorTheme.mode1()
      : color1 = const Color(0xff000000),
        color2 = const Color(0xffffffff);

  const MyColorTheme.mode2()
      : color1 = const Color(0xff111111),
        color2 = const Color(0xff222222);

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
''';

const _expectedColorThemeExtensionBuildContextExtensionString = '''
extension MyColorThemeBuildContextX on BuildContext {
  MyColorTheme get myColorTheme => Theme.of(this).extension<MyColorTheme>()!;
}
''';

const _expectedNullableColorThemeExtensionClassString = '''
@immutable
class MyColorTheme extends ThemeExtension<MyColorTheme> {
  const MyColorTheme({
    required this.color1,
    required this.color2,
  });

  const MyColorTheme.mode1()
      : color1 = const Color(0xff000000),
        color2 = const Color(0xffffffff);

  const MyColorTheme.mode2()
      : color1 = const Color(0xff111111),
        color2 = const Color(0xff222222);

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
''';

const _expectedNullableColorThemeExtensionBuildContextExtensionString = '''
extension MyColorThemeBuildContextX on BuildContext {
  MyColorTheme? get myColorTheme => Theme.of(this).extension<MyColorTheme>();
}
''';

const _expectedSingleModeOutputString = '''
@immutable
class MyColorTheme extends ThemeExtension<MyColorTheme> {
  const MyColorTheme({
    required this.color1,
    required this.color2,
  });

  const MyColorTheme.standard()
      : color1 = const Color(0xff000000),
        color2 = const Color(0xffffffff);

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
''';
