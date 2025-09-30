import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:figmage/src/data/util/converters/type_style_conversion_x.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {});

  group('TypeStyleConversionX', () {
    group('toDomain', () {
      test('should convert a type style to a typography', () {
        const typeStyle = TypeStyle(
          fontFamily: 'Roboto',
          fontPostScriptName: 'Roboto-Regular',
          fontSize: 16,
          fontWeight: 400,
          italic: false,
          letterSpacing: 0,
          lineHeightPx: 20,
        );

        final result = typeStyle.toDomain();

        expect(result.fontFamily, 'Roboto');
        expect(result.fontFamilyPostScriptName, 'Roboto-Regular');
        expect(result.fontSize, 16);
        expect(result.fontWeight, 400);
        expect(result.fontStyle, FontStyle.normal);
        expect(result.letterSpacing, 0);
        expect(result.height, 1.25);
      });

      test('should convert a type style to a typography with italic', () {
        const typeStyle = TypeStyle(
          fontFamily: 'Roboto',
          fontPostScriptName: 'Roboto-Regular',
          fontSize: 16,
          fontWeight: 400,
          italic: true,
          letterSpacing: 0,
          lineHeightPx: 20,
        );

        final result = typeStyle.toDomain();

        expect(result.fontFamily, 'Roboto');
        expect(result.fontFamilyPostScriptName, 'Roboto-Regular');
        expect(result.fontSize, 16);
        expect(result.fontWeight, 400);
        expect(result.fontStyle, FontStyle.italic);
        expect(result.letterSpacing, 0);
        expect(result.height, 1.25);
      });

      test('should convert a type style to a typography with no line height',
          () {
        const typeStyle = TypeStyle(
          fontFamily: 'Roboto',
          fontPostScriptName: 'Roboto-Regular',
          fontSize: 16,
          fontWeight: 400,
          italic: false,
          letterSpacing: 0,
        );

        final result = typeStyle.toDomain();

        expect(result.fontFamily, 'Roboto');
        expect(result.fontFamilyPostScriptName, 'Roboto-Regular');
        expect(result.fontSize, 16);
        expect(result.fontWeight, 400);
        expect(result.fontStyle, FontStyle.normal);
        expect(result.letterSpacing, 0);
        expect(result.height, 1);
      });

      test('should convert a type style to a typography with no font weight',
          () {
        const typeStyle = TypeStyle(
          fontFamily: 'Roboto',
          fontPostScriptName: 'Roboto-Regular',
          fontSize: 16,
          italic: false,
          letterSpacing: 0,
          lineHeightPx: 20,
        );

        final result = typeStyle.toDomain();

        expect(result.fontFamily, 'Roboto');
        expect(result.fontFamilyPostScriptName, 'Roboto-Regular');
        expect(result.fontSize, 16);
        expect(result.fontWeight, 400);
        expect(result.fontStyle, FontStyle.normal);
        expect(result.letterSpacing, 0);
        expect(result.height, 1.25);
      });
    });

    group('convertFontWeight', () {
      test('should return 100 for 0', () {
        expect(TypeStyleConversionX.convertFontWeight(0), 100);
      });

      test('should return 100 for 100', () {
        expect(TypeStyleConversionX.convertFontWeight(100), 100);
      });

      test('should return 200 for 200', () {
        expect(TypeStyleConversionX.convertFontWeight(200), 200);
      });

      test('should return 300 for 300', () {
        expect(TypeStyleConversionX.convertFontWeight(300), 300);
      });

      test('should return 400 for 400', () {
        expect(TypeStyleConversionX.convertFontWeight(400), 400);
      });

      test('should return 500 for 500', () {
        expect(TypeStyleConversionX.convertFontWeight(500), 500);
      });

      test('should return 600 for 600', () {
        expect(TypeStyleConversionX.convertFontWeight(600), 600);
      });

      test('should return 700 for 700', () {
        expect(TypeStyleConversionX.convertFontWeight(700), 700);
      });

      test('should return 800 for 800', () {
        expect(TypeStyleConversionX.convertFontWeight(800), 800);
      });

      test('should return 900 for 900', () {
        expect(TypeStyleConversionX.convertFontWeight(900), 900);
      });

      test('should return 900 for 1000', () {
        expect(TypeStyleConversionX.convertFontWeight(1000), 900);
      });

      test('should round', () {
        expect(TypeStyleConversionX.convertFontWeight(520), 500);
        expect(TypeStyleConversionX.convertFontWeight(549), 500);
        expect(TypeStyleConversionX.convertFontWeight(550), 600);
      });
    });

    group('convertLineHeight', () {
      test('returns 1 if either are null', () async {
        expect(TypeStyleConversionX.convertLineHeight(null, 10), 1);
        expect(TypeStyleConversionX.convertLineHeight(10, null), 1);
        expect(TypeStyleConversionX.convertLineHeight(null, null), 1);
      });

      test('returns relative height to font size', () async {
        expect(TypeStyleConversionX.convertLineHeight(10, 10), 1);
        expect(TypeStyleConversionX.convertLineHeight(20, 10), 2);
        expect(TypeStyleConversionX.convertLineHeight(5, 10), 0.5);
      });
    });
  });
}
