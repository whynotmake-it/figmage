import 'package:figma/figma.dart';
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

      test(
        'should convert a type style to a typography with no line height',
        () {
          const typeStyle = TypeStyle(
            fontFamily: 'Roboto',
            fontPostScriptName: 'Roboto-Regular',
            fontSize: 16,
            fontWeight: 400,
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
        },
      );

      test(
        'should convert a type style to a typography with no font weight',
        () {
          const typeStyle = TypeStyle(
            fontFamily: 'Roboto',
            fontPostScriptName: 'Roboto-Regular',
            fontSize: 16,
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
        },
      );
    });

    group('convertFontWeight', () {
      test('should return 1 for 0', () {
        expect(TypeStyleConversionX.convertFontWeight(0), 1);
      });

      test('should return 1 for 1', () {
        expect(TypeStyleConversionX.convertFontWeight(1), 1);
      });

      test('should return 100 for 99.6', () {
        expect(TypeStyleConversionX.convertFontWeight(99.6), 100);
      });

      test('should preserve in-range arbitrary values', () {
        expect(TypeStyleConversionX.convertFontWeight(463), 463);
      });

      test('should return 900 for 900', () {
        expect(TypeStyleConversionX.convertFontWeight(900), 900);
      });

      test('should return 1000 for 1000', () {
        expect(TypeStyleConversionX.convertFontWeight(1000), 1000);
      });

      test('should return 1000 for 1200', () {
        expect(TypeStyleConversionX.convertFontWeight(1200), 1000);
      });

      test('emits a diagnostic when clamping', () {
        final diagnostics = <String>[];
        final value = TypeStyleConversionX.convertFontWeight(
          1200,
          onDiagnostic: diagnostics.add,
          diagnosticContext: 'my/path',
        );

        expect(value, 1000);
        expect(
          diagnostics.single,
          'Clamped fontWeight from 1200 to 1000. '
          'Valid range is 1..1000 at my/path.',
        );
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
