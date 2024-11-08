import 'package:figmage/src/domain/models/config/config.dart';
import 'package:test/test.dart';

void main() {
  group('Config', () {
    late Map<dynamic, dynamic> minimal;
    late Map<dynamic, dynamic> full;

    late Config fullExample;

    setUp(() {
      minimal = {
        "fileId": "fileId",
        "packageName": "packageName",
      };

      full = {
        ...minimal,
        "packageDescription": "packageDescription",
        "dropUnresolved": false,
        "stylesFromLibrary": false,
        "colors": {
          "generate": true,
          "from": ["path1", "path2"],
        },
        "typography": {
          "generate": true,
          "from": ["path1", "path2"],
          "useGoogleFonts": false,
        },
        "strings": {
          "generate": true,
          "from": ["path1", "path2"],
        },
        "bools": {
          "generate": true,
          "from": ["path1", "path2"],
        },
        "numbers": {
          "generate": true,
          "from": ["path1", "path2"],
        },
        "spacers": {
          "generate": true,
          "from": ["path1", "path2"],
        },
        "paddings": {
          "generate": true,
          "from": ["path1", "path2"],
        },
        "radii": {
          "generate": true,
          "from": ["path1", "path2"],
        },
      };

      fullExample = const Config(
        fileId: "fileId",
        packageName: "packageName",
        packageDescription: "packageDescription",
        colors: GenerationSettings(
          from: ["path1", "path2"],
        ),
        typography: TypographyGenerationSettings(
          from: ["path1", "path2"],
          useGoogleFonts: false,
        ),
        strings: GenerationSettings(
          from: ["path1", "path2"],
        ),
        bools: GenerationSettings(
          from: ["path1", "path2"],
        ),
        numbers: GenerationSettings(
          from: ["path1", "path2"],
        ),
        spacers: GenerationSettings(
          from: ["path1", "path2"],
        ),
        paddings: GenerationSettings(
          from: ["path1", "path2"],
        ),
        radii: GenerationSettings(
          from: ["path1", "path2"],
        ),
      );
    });
    group('defaults', () {
      test('are correct', () {
        const sut = Config(fileId: "fileId", packageName: "packageName");
        expect(sut.colors.generate, isTrue);
        expect(sut.dropUnresolved, isFalse);
        expect(sut.colors.from, isEmpty);
        expect(sut.typography.generate, isTrue);
        expect(sut.typography.from, isEmpty);
        expect(sut.typography.useGoogleFonts, isTrue);
        expect(sut.strings.generate, isTrue);
        expect(sut.strings.from, isEmpty);
        expect(sut.bools.generate, isTrue);
        expect(sut.bools.from, isEmpty);
        expect(sut.numbers.generate, isTrue);
        expect(sut.numbers.from, isEmpty);
        expect(sut.spacers.generate, isFalse);
        expect(sut.spacers.from, isEmpty);
        expect(sut.paddings.generate, isFalse);
        expect(sut.paddings.from, isEmpty);
      });
    });

    group('fromMap', () {
      test('supports generation from minimal map', () async {
        final result = Config.fromMap(minimal);
        expect(
          result,
          const Config(fileId: "fileId", packageName: "packageName"),
        );
      });

      test('supports generation from full map', () async {
        final result = Config.fromMap(full);
        expect(result, fullExample);
        expect(result.typography.useGoogleFonts, isFalse);
      });

      test('supports asset configuration', () async {
        final map = {
          ...minimal,
          "assets": {
            "generate": true,
            "icons": {
              "1:5": {
                "scales": [1, 2],
                "name": "check",
              },
            },
            "illustrations": {
              "23:1": {
                "name": "example_name",
              },
            },
          },
        };
        final result = Config.fromMap(map);
        expect(result.assets.generate, isTrue);
        expect(
          result.assets.groups["icons"]?.nodes["1:5"]?.name,
          equals("check"),
        );
        expect(
          result.assets.groups["icons"]?.nodes["1:5"]?.scales,
          equals([1, 2]),
        );
        expect(
          result.assets.groups["illustrations"]?.nodes["23:1"]?.name,
          equals("example_name"),
        );
        expect(
          result.assets.groups["illustrations"]?.nodes["23:1"]?.scales,
          equals([1]),
        );
      });
    });

    group('allGenerationSettings', () {
      test('contains all settings', () async {
        expect(
          fullExample.allGenerationSettings,
          containsAll(
            [
              fullExample.colors,
              fullExample.typography,
              fullExample.strings,
              fullExample.bools,
              fullExample.numbers,
              fullExample.spacers,
              fullExample.paddings,
              fullExample.radii,
            ],
          ),
        );
      });
    });

    group('suspiciousFromDefined', () {
      test('is false for default', () async {
        expect(
          const Config(fileId: "", packageName: "").suspiciousFromDefined,
          isFalse,
        );
      });

      test('is true if one config includes from and generate false', () async {
        const sus = Config(
          fileId: "",
          packageName: "",
          paddings: GenerationSettings(
            generate: false,
            from: [
              "oh/oh",
            ],
          ),
        );
        expect(sus.suspiciousFromDefined, isTrue);
      });
    });

    group('toMap', () {
      test('works for example object', () async {
        expect(fullExample.toJson(), full);
      });
    });
  });
}
