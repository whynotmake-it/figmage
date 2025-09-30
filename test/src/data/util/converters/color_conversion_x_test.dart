import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:figmage/src/data/util/converters/color_conversion_x.dart';
import 'package:test/test.dart';

void main() {
  group('ColorConversionX', () {
    group('toValue', () {
      test('works for 50% grey', () {
        const color = Color(r: 0.5, g: 0.5, b: 0.5, a: 0.5);
        final result = color.toValue();
        expect(result, 0x80808080);
      });

      test('works for white', () async {
        const color = Color(r: 1, g: 1, b: 1, a: 1);
        final result = color.toValue();
        expect(result, 0xFFFFFFFF);
      });

      test('works for black', () async {
        const color = Color(r: 0, g: 0, b: 0, a: 1);
        final result = color.toValue();
        expect(result, 0xFF000000);
      });

      test('works for rgb', () async {
        const color = Color(r: 0.5, g: 0.25, b: 0.75, a: 1);
        final result = color.toValue();
        expect(result, 0xFF8040BF);
      });

      test('should throw an exception if the color is not valid', () {
        const color = Color(r: 0.5, g: 0.5, b: 0.5);
        int result() => color.toValue();
        expect(result, throwsException);
      });
    });
  });
}
