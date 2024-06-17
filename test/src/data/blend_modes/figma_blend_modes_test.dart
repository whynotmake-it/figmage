import 'package:figmage/src/data/blend_modes/figma_blend_modes.dart';
import 'package:figmage/src/domain/color/int_color.dart';
import 'package:test/test.dart';

void main() {
  group('FigmaBlendModes Tests', () {
    final black = IntColor.fromRGBA(0, 0, 0, 255);
    final white = IntColor.fromRGBA(255, 255, 255, 255);
    final grey = IntColor.fromRGBA(100, 100, 100, 255);
    final red50 = IntColor.fromRGBA(255, 0, 0, 255 ~/ 2);
    final blue = IntColor.fromRGBA(0, 0, 255, 255);

    test('Normal Blend Mode', () {
      expect(FigmaBlendModes.normal(black, red50), equals(red50));
    });

    test('Multiply Blend Mode', () {
      expect(
        FigmaBlendModes.multiply(white, red50),
        equals(IntColor.fromRGBA(239, 134, 131, 255)),
      );
    });

    test('Screen Blend Mode', () {
      expect(
        FigmaBlendModes.screen(black, red50),
        equals(IntColor.fromRGBA(117, 20, 12, 255)),
      );
    });

    test('Overlay Blend Mode', () {
      expect(FigmaBlendModes.overlay(white, red50), equals(white));
    });

    test('Darken Blend Mode', () {
      expect(
        FigmaBlendModes.darken(white, red50),
        equals(IntColor.fromRGBA(239, 134, 131, 255)),
      );
    });

    test('Lighten Blend Mode', () {
      expect(
        FigmaBlendModes.lighten(black, red50),
        equals(IntColor.fromRGBA(117, 20, 12, 255)),
      );
    });

    test('Color Dodge Blend Mode', () {
      expect(
        FigmaBlendModes.colorDodge(grey, red50),
        equals(IntColor.fromRGBA(167, 104, 102, 255)),
      );
    });

    test('Color Burn Blend Mode', () {
      expect(
        FigmaBlendModes.colorBurn(grey, red50),
        equals(IntColor.fromRGBA(240, 229, 229, 255)),
      );
    });

    test('Hard Light Blend Mode', () {
      expect(
        FigmaBlendModes.hardLight(grey, red50),
        equals(IntColor.fromRGBA(208, 100, 104, 255)),
      );
    });

    test('Soft Light Blend Mode', () {
      expect(
        FigmaBlendModes.softLight(grey, red50),
        equals(IntColor.fromRGBA(219, 193, 193, 255)),
      );
    });

    test('Difference Blend Mode', () {
      expect(
        FigmaBlendModes.difference(black, red50),
        equals(IntColor.fromRGBA(117, 20, 12, 255)),
      );
    });

    test('Exclusion Blend Mode', () {
      expect(
        FigmaBlendModes.exclusion(white, red50),
        equals(IntColor.fromRGBA(160, 252, 254, 255)),
      );
    });

    test('Hue Blend Mode', () {
      expect(
        FigmaBlendModes.hue(blue, red50),
        equals(IntColor.fromRGBA(51, 4, 122, 255)),
      );
    });

    test('Saturation Blend Mode', () {
      expect(
        FigmaBlendModes.saturation(blue, grey),
        equals(IntColor.fromRGBA(31, 31, 31, 255)),
      );
    });

    test('Color Blend Mode', () {
      expect(
        FigmaBlendModes.color(blue, red50),
        equals(IntColor.fromRGBA(51, 104, 122, 255)),
      );
    });

    test('Luminosity Blend Mode', () {
      expect(
        FigmaBlendModes.luminosity(white, red50),
        equals(IntColor.fromRGBA(165, 165, 165, 255)),
      );
    });
  });
}
