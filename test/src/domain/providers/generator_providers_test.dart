import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage/src/domain/providers/generator_providers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

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
            variables: [
              Variable.boolean(
                id: "id",
                name: "name",
                remote: false,
                key: "key",
                variableCollectionId: "variableCollectionId",
                variableCollectionName: "variableCollectionName",
                resolvedType: "BOOLEAN",
                description: "description",
                hiddenFromPublishing: false,
                scopes: [],
                codeSyntax: {},
                collectionModeNames: {},
                valuesByMode: {
                  "light": const AliasOr.data(data: true),
                  "dark": const AliasOr.data(data: false),
                },
              ),
            ],
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
