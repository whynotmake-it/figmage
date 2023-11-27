import 'package:figmage/src/domain/models/config/config.dart';
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
            variables: mockVariables,
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
            variables: [],
            settings: const GenerationSettings(generate: false)
          ),
        ),
      );
      expect(generator, isNull);
    });
  });
}
