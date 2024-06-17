import 'package:figmage/src/domain/color/int_color.dart';
import 'package:test/test.dart';

void main() {
  group('IntColor Tests', () {
    test('Constructor from RGBA components', () {
      final color =
          IntColor.fromRGBA(255, 165, 0, 255); // Orange with full opacity
      expect(color.value, equals(0xFFFFA500));
    });

    test('Alpha component getter', () {
      final color = IntColor.fromRGBA(0, 0, 0, 128); // Semi-transparent black
      expect(color.alpha, equals(128));
    });

    test('Red component getter', () {
      final color = IntColor.fromRGBA(255, 0, 0, 255); // Full red
      expect(color.red, equals(255));
    });

    test('Green component getter', () {
      final color = IntColor.fromRGBA(0, 255, 0, 255); // Full green
      expect(color.green, equals(255));
    });

    test('Blue component getter', () {
      final color = IntColor.fromRGBA(0, 0, 255, 255); // Full blue
      expect(color.blue, equals(255));
    });

    test('Luminosity Calculation', () {
      final color = IntColor.fromRGBA(100, 100, 100, 255);
      expect(color.luminosity, closeTo(100, 0.1));
    });

    test('Clip Color with negative values', () {
      final color = IntColor.fromRGBA(-10, 100, 100, 255);
      final clipped = color.clipColor();
      // Verify that clipping adjusts the color correctly
      expect(clipped.red, isNonNegative);
      expect(clipped.green, equals(100));
      expect(clipped.blue, equals(100));
    });

    test('Clip Color with values exceeding 255', () {
      final color = IntColor.fromRGBA(300, 100, 100, 255);
      final clipped = color.clipColor();
      // Verify that clipping adjusts the color correctly
      expect(clipped.red, lessThanOrEqualTo(255));
      expect(clipped.green, equals(100));
      expect(clipped.blue, equals(100));
    });

    test('Set Luminosity', () {
      final color = IntColor.fromRGBA(50, 50, 50, 255);
      final modified = color.setLuminosity(200);
      // Verify luminosity is set and color is clipped if necessary
      expect(modified.luminosity, closeTo(200, 0.1));
    });

    test('Saturation Calculation', () {
      final color = IntColor.fromRGBA(255, 0, 0, 255);
      expect(color.saturation, equals(255));
    });

    test('Set Saturation', () {
      final color = IntColor.fromRGBA(100, 50, 50, 255);
      final modified = color.setSaturation(100);
      // Verify saturation is set correctly
      expect(modified.saturation, equals(100));
    });
  });
}
