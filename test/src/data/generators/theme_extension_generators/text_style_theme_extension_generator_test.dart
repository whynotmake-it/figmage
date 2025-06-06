import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/theme_extension_generators/text_style_theme_extension_generator.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
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
    'mode1': {
      'textStyle1': Typography(
        fontSize: 16,
        fontFamily: 'Roboto',
        fontFamilyPostScriptName: 'Roboto',
        decoration: TextDecoration.underline,
      ),
      'textStyle2': Typography(
        fontSize: 24,
        fontFamily: 'Roboto',
        fontFamilyPostScriptName: 'Roboto',
        decoration: TextDecoration.lineThrough,
      ),
    },
    'mode2': {
      'textStyle1': Typography(
        fontSize: 16,
        fontFamily: 'Roboto',
        fontFamilyPostScriptName: 'Roboto',
        fontWeight: 700,
        decoration: TextDecoration.underline,
      ),
      'textStyle2': null,
    },
  };
  test(
      'Should create a TextStyleThemeExtension class and BuildContextExtension',
      () async {
    final generator = TextStyleThemeExtensionGenerator(
      className: 'MyTextStyles',
      valuesByNameByMode: valuesByNameByMode,
      useGoogleFonts: false,
      interfaces: [],
    );
    expect(
      generator.generateClass(),
      equalsDart(
        _expectedTextStyleThemeExtensionString,
        emitter,
      ),
    );
    expect(
      generator.generateExtension(),
      equalsDart(
        _expectedTextStyleThemeExtensionBuildContextExtensionString,
        emitter,
      ),
    );
  });
  test('Should create a class and nullable BuildContextExtension', () async {
    final generator = TextStyleThemeExtensionGenerator(
      className: 'MyTextStyles',
      valuesByNameByMode: valuesByNameByMode,
      buildContextExtensionNullable: true,
      useGoogleFonts: false,
      interfaces: [],
    );

    expect(
      generator.generateClass(),
      equalsDart(
        _expectedTextStyleThemeExtensionString,
        emitter,
      ),
    );
    expect(
      generator.generateExtension(),
      equalsDart(
        _expectedNullableTextStyleThemeExtensionBuildContextExtensionString,
        emitter,
      ),
    );
  });
  test('works for google fonts', () async {
    final generator = TextStyleThemeExtensionGenerator(
      className: 'MyTextStyles',
      valuesByNameByMode: valuesByNameByMode,
      useGoogleFonts: true,
      interfaces: [],
    );
    expect(
      generator.generateClass(),
      equalsDart(
        _expectedTextStyleThemeExtensionStringWithGoogleFonts,
        emitter,
      ),
    );
    expect(
      generator.generateExtension(),
      equalsDart(
        _expectedThemeExtensionBuildContextExtensionStringWithGoogleFonts,
        emitter,
      ),
    );
  });
}

// **************************************************************************
// TEST RESOURCES
// **************************************************************************
const _expectedTextStyleThemeExtensionString = '''
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
        textStyle2 = null;

  final TextStyle textStyle1;

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
      )!,
      textStyle2: TextStyle.lerp(
        textStyle2,
        other.textStyle2,
        t,
      ),
    );
  }
}
''';
const _expectedTextStyleThemeExtensionBuildContextExtensionString = '''
extension MyTextStylesBuildContextX on BuildContext {
  MyTextStyles get myTextStyles => Theme.of(this).extension<MyTextStyles>()!;
}
''';

const _expectedNullableTextStyleThemeExtensionBuildContextExtensionString = '''
extension MyTextStylesBuildContextX on BuildContext {
  MyTextStyles? get myTextStyles => Theme.of(this).extension<MyTextStyles>();
}
''';

const _expectedTextStyleThemeExtensionStringWithGoogleFonts = '''
@immutable
class MyTextStyles extends ThemeExtension<MyTextStyles> {
  const MyTextStyles({
    required this.textStyle1,
    required this.textStyle2,
  });

  MyTextStyles.mode1()
      : textStyle1 = GoogleFonts.getFont(
          'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.0,
          height: 1.0,
          decoration: TextDecoration.underline,
        ),
        textStyle2 = GoogleFonts.getFont(
          'Roboto',
          fontSize: 24.0,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.0,
          height: 1.0,
          decoration: TextDecoration.lineThrough,
        );

  MyTextStyles.mode2()
      : textStyle1 = GoogleFonts.getFont(
          'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.0,
          height: 1.0,
          decoration: TextDecoration.underline,
        ),
        textStyle2 = null;

  final TextStyle textStyle1;

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
      )!,
      textStyle2: TextStyle.lerp(
        textStyle2,
        other.textStyle2,
        t,
      ),
    );
  }
}
''';
const _expectedThemeExtensionBuildContextExtensionStringWithGoogleFonts = '''
extension MyTextStylesBuildContextX on BuildContext {
  MyTextStyles get myTextStyles => Theme.of(this).extension<MyTextStyles>()!;
}
''';
