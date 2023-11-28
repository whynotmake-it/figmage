import 'package:figmage/src/data/generators/color_theme_extension_generator.dart';
import 'package:figmage/src/data/generators/number_theme_extension_generator.dart';
import 'package:figmage/src/data/generators/padding_generator.dart';
import 'package:figmage/src/data/generators/spacer_generator.dart';
import 'package:figmage/src/data/generators/text_style_theme_extension_generator.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage/src/domain/providers/generator_providers.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import '../../../test_util/mock/mock_styles.dart';
import '../../../test_util/mock/mock_variables.dart';

void main() {
  group("generatorProvider", () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });
    tearDown(() {
      container.dispose();
    });

    test("should return null if generation is disabled", () {
      final generator = container.read(
        generatorProvider(
          (
            type: TokenFileType.color,
            tokens: mockVariables,
            settings: const GenerationSettings(generate: false)
          ),
        ),
      );
      expect(generator, isNull);
    });
    test('should return null if empty variable list', () async {
      final generator = container.read(
        generatorProvider(
          (
            type: TokenFileType.color,
            tokens: [],
            settings: const GenerationSettings()
          ),
        ),
      );
      expect(generator, isNull);
    });
    test('should return null if no correct variable type in list', () async {
      final generator = container.read(
        generatorProvider(
          (
            type: TokenFileType.color,
            tokens: mockVariables.whereType<StringVariable>().toList(),
            settings: const GenerationSettings()
          ),
        ),
      );
      expect(generator, isNull);
    });

    test("should return a ColorThemeExtensionGenerator for color variables",
        () {
      final generator = container.read(
        generatorProvider(
          (
            type: TokenFileType.color,
            tokens: mockVariables,
            settings: const GenerationSettings()
          ),
        ),
      );
      expect(
        generator,
        isA<ColorThemeExtensionGenerator>().having(
          (p0) => p0.valuesByNameByMode,
          "valuesByNameByMode",
          allOf(contains("light"), contains("dark")),
        ),
      );
    });

    test("should return a ColorThemeExtensionGenerator for color styles", () {
      final generator = container.read(
        generatorProvider(
          (
            type: TokenFileType.color,
            tokens: mockStyles,
            settings: const GenerationSettings()
          ),
        ),
      );
      expect(
        generator,
        isA<ColorThemeExtensionGenerator>().having(
          (p0) => p0.valuesByNameByMode,
          "valuesByNameByMode",
          hasLength(1),
        ),
      );
    });

    test("should return a TextStyleThemeExtensionGenerator for text styles",
        () {
      final generator = container.read(
        generatorProvider(
          (
            type: TokenFileType.typography,
            tokens: mockStyles,
            settings: const GenerationSettings()
          ),
        ),
      );
      expect(
        generator,
        isA<TextStyleThemeExtensionGenerator>().having(
          (p0) => p0.valuesByNameByMode,
          "valuesByNameByMode",
          hasLength(1),
        ),
      );
    });

    test("should return a NumberThemeExtensionGenerator for number variables",
        () {
      final generator = container.read(
        generatorProvider(
          (
            type: TokenFileType.numbers,
            tokens: mockVariables,
            settings: const GenerationSettings()
          ),
        ),
      );
      expect(
        generator,
        isA<NumberThemeExtensionGenerator>().having(
          (p0) => p0.valuesByNameByMode,
          "valuesByNameByMode",
          allOf(contains("light"), contains("dark")),
        ),
      );
    });

    test("should return a SpacerGenerator for spacers with variables", () {
      final generator = container.read(
        generatorProvider(
          (
            type: TokenFileType.spacers,
            tokens: mockVariables,
            settings: const GenerationSettings()
          ),
        ),
      );
      expect(
        generator,
        isA<SpacerGenerator>().having(
          (p0) => p0.valueNames,
          "valueNames",
          contains("floatName"),
        ),
      );
    });
    test("should return a PaddingsGenerator for paddings with variables", () {
      final generator = container.read(
        generatorProvider(
          (
            type: TokenFileType.paddings,
            tokens: mockVariables,
            settings: const GenerationSettings()
          ),
        ),
      );
      expect(
        generator,
        isA<PaddingGenerator>().having(
          (p0) => p0.valueNames,
          "valueNames",
          contains("floatName"),
        ),
      );
    });

    // TODO(tim): support these too:
    test("should return null for unsupported types", () {
      for (final type in [
        TokenFileType.radii,
        TokenFileType.bools,
        TokenFileType.strings,
      ]) {
        final generator = container.read(
          generatorProvider(
            (
              type: type,
              tokens: [...mockStyles, ...mockVariables],
              settings: const GenerationSettings()
            ),
          ),
        );
        expect(generator, isNull);
      }
    });
  });
}
