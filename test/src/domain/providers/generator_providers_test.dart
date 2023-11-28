import 'package:figmage/src/data/generators/color_theme_extension_generator.dart';
import 'package:figmage/src/data/generators/number_theme_extension_generator.dart';
import 'package:figmage/src/data/generators/padding_generator.dart';
import 'package:figmage/src/data/generators/spacer_generator.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage/src/domain/providers/generator_providers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

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

    test("should return null for unsupported types", () {
      final generator = container.read(
        generatorProvider(
          (
            filename: "unsupported",
            tokens: mockVariables,
            settings: const GenerationSettings()
          ),
        ),
      );
      expect(generator, isNull);
    });

    test("should return null if generation is disabled", () {
      final generator = container.read(
        generatorProvider(
          (
            filename: "colors.dart",
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
            filename: "colors.dart",
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
            filename: "colors.dart",
            tokens: mockVariables.whereType<StringVariable>().toList(),
            settings: const GenerationSettings()
          ),
        ),
      );
      expect(generator, isNull);
    });

    test("should return a ColorThemeExtensionGenerator for colors", () {
      final generator = container.read(
        generatorProvider(
          (
            filename: "colors.dart",
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

    test("should return a NumberThemeExtensionGenerator for numbers", () {
      final generator = container.read(
        generatorProvider(
          (
            filename: "numbers.dart",
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

    test("should return a SpacerGenerator for spacers", () {
      final generator = container.read(
        generatorProvider(
          (
            filename: "spacers.dart",
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
    test("should return a PaddingsGenerator for paddings", () {
      final generator = container.read(
        generatorProvider(
          (
            filename: "paddings.dart",
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
      for (final filename in [
        "radii.dart",
        "strings.dart",
        "bools.dart",
        "typography.dart",
      ]) {
        final generator = container.read(
          generatorProvider(
            (
              filename: filename,
              tokens: mockVariables.cast(),
              settings: const GenerationSettings()
            ),
          ),
        );
        expect(generator, isNull);
      }
    });
  });
}
