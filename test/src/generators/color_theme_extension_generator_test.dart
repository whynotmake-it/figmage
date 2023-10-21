import 'package:build_test/build_test.dart';
import 'package:figmage/src/generators/color_theme_extension_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

void main() {
  tearDown(() {
    // Increment this after each test so the next test has it's own package
    _pkgCacheCount++;
  });

  test('Generates a ThemeExtension<MyColorTheme> output file', () async {
    final generator = ColorThemeExtensionGenerator(
      name: 'MyColorTheme',
      colorMaps: {
        'mode1': {'color1': 0xFF000000, 'color2': 0xFFFFFFFF},
        'mode2': {'color1': 0xFF111111, 'color2': 0xFF222222},
      },
    );

    final builder = LibraryBuilder(generator);

    final srcs = _createPackageStub();

    await testBuilder(
      builder,
      srcs,
      generateFor: {'$_pkgName|lib/test_lib.dart'},
      outputs: {
        '$_pkgName|lib/test_lib.g.dart': _expectedString,
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

const _expectedString = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ColorThemeExtensionGenerator
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
