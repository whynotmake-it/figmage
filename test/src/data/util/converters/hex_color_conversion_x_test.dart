import 'package:figmage/src/data/util/converters/hex_color_conversion_x.dart';
import 'package:test/test.dart';

void main() {
  group('HexColorConversionX', () {
    test('parses 6 digit hex strings', () {
      expect('#d9d9d9'.toHexColorValue(), equals(0xFFD9D9D9));
    });

    test('parses 8 digit hex strings with alpha last', () {
      expect('#11223344'.toHexColorValue(), equals(0x44112233));
    });

    test('throws on invalid length', () {
      expect(
        () => '#12345'.toHexColorValue(),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
