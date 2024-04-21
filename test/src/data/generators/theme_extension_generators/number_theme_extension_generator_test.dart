import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/theme_extension_generators/number_theme_extension_generator.dart';
import 'package:test/test.dart';

import '../common.dart';

void main() {
  useDartfmt();
  final emitter = DartEmitter(
    allocator: Allocator(),
    useNullSafetySyntax: true,
    orderDirectives: true,
  );

  const valuesByNameByMode = {
    'small': {'s': 1.0, 'm': 2.0},
    'large': {'s': 2.0, 'm': null},
  };

  test('Should create a numbers class and BuildContextExtension', () async {
    final generator = NumberThemeExtensionGenerator(
      className: 'MyNumbersTheme',
      valuesByNameByMode: valuesByNameByMode,
    );
    expect(
      generator.generateClass(),
      equalsDart(
        _expectedNumberExtensionClassString,
        emitter,
      ),
    );
    expect(
      generator.generateExtension(),
      equalsDart(
        _expectedNumberExtensionBuildContextExtensionString,
        emitter,
      ),
    );
  });
  test('Should create a numbers class and nullable BuildContextExtension',
      () async {
    final generator = NumberThemeExtensionGenerator(
      className: 'MyNumbersTheme',
      valuesByNameByMode: valuesByNameByMode,
      buildContextExtensionNullable: true,
    );
    expect(
      generator.generateClass(),
      equalsDart(
        _expectedNullableNumberExtensionClassString,
        emitter,
      ),
    );
    expect(
      generator.generateExtension(),
      equalsDart(
        _expectedNullableNumberExtensionBuildContextExtensionString,
        emitter,
      ),
    );
  });
}
// **************************************************************************
// TEST RESOURCES
// **************************************************************************

const _expectedNumberExtensionClassString = '''
@immutable
class MyNumbersTheme extends ThemeExtension<MyNumbersTheme> {
  const MyNumbersTheme({
    required this.s,
    required this.m,
  });

  const MyNumbersTheme.small()
      : s = 1.0,
        m = 2.0;

  const MyNumbersTheme.large()
      : s = 2.0,
        m = null;

  final double s;

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
''';
const _expectedNumberExtensionBuildContextExtensionString = '''
extension MyNumbersThemeBuildContextX on BuildContext {
  MyNumbersTheme get myNumbersTheme =>
      Theme.of(this).extension<MyNumbersTheme>()!;
}
''';

const _expectedNullableNumberExtensionClassString = '''
@immutable
class MyNumbersTheme extends ThemeExtension<MyNumbersTheme> {
  const MyNumbersTheme({
    required this.s,
    required this.m,
  });

  const MyNumbersTheme.small()
      : s = 1.0,
        m = 2.0;

  const MyNumbersTheme.large()
      : s = 2.0,
        m = null;

  final double s;

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
''';

const _expectedNullableNumberExtensionBuildContextExtensionString = '''
extension MyNumbersThemeBuildContextX on BuildContext {
  MyNumbersTheme? get myNumbersTheme =>
      Theme.of(this).extension<MyNumbersTheme>();
}
''';
