// ignore_for_file: inference_failure_on_collection_literal

import 'package:figmage/src/domain/models/config/config.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

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
        "asPackage": true,
        "tokenPath": "src",
        "dropUnresolved": false,
        "includeDeletedButReferenced": false,
        "stylesFromLibrary": false,
        "colors": {
          "generate": true,
          "from": ["path1", "path2"],
          "inheritance": [],
        },
        "typography": {
          "generate": true,
          "from": ["path1", "path2"],
          "inheritance": [],
          "useGoogleFonts": false,
        },
        "strings": {
          "generate": true,
          "from": ["path1", "path2"],
          "inheritance": [],
        },
        "bools": {
          "generate": true,
          "from": ["path1", "path2"],
          "inheritance": [],
        },
        "numbers": {
          "generate": true,
          "from": ["path1", "path2"],
          "inheritance": [],
        },
        "spacers": {
          "generate": true,
          "from": ["path1", "path2"],
          "inheritance": [],
        },
        "paddings": {
          "generate": true,
          "from": ["path1", "path2"],
          "inheritance": [],
        },
        "radii": {
          "generate": true,
          "from": ["path1", "path2"],
          "inheritance": [],
        },
        "assets": {
          "generate": true,
          "nodes": {
            "1:5": {
              "name": "logo",
              "scales": [0.5, 1, 2],
            },
          },
        },
      };

      fullExample = Config(
        fileId: "fileId",
        packageName: "packageName",
        packageDescription: "packageDescription",
        colors: const GenerationSettings(
          from: ["path1", "path2"],
        ),
        typography: const TypographyGenerationSettings(
          from: ["path1", "path2"],
          useGoogleFonts: false,
        ),
        strings: const GenerationSettings(
          from: ["path1", "path2"],
        ),
        bools: const GenerationSettings(
          from: ["path1", "path2"],
        ),
        numbers: const GenerationSettings(
          from: ["path1", "path2"],
        ),
        spacers: const GenerationSettings(
          from: ["path1", "path2"],
        ),
        paddings: const GenerationSettings(
          from: ["path1", "path2"],
        ),
        radii: const GenerationSettings(
          from: ["path1", "path2"],
        ),
        assets: AssetGenerationSettings(
          generate: true,
          nodes: {
            "1:5": AssetNodeSettings(
              name: "logo",
              scales: {
                0.5,
                1,
                2,
              },
            ),
          },
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
          const Config(
            fileId: "fileId",
            packageName: "packageName",
          ),
        );
      });

      test('supports generation from full map', () async {
        final result = Config.fromMap(full);
        expect(result, fullExample);
        expect(result.typography.useGoogleFonts, isFalse);
      });

      test('supports includeDeletedButReferenced configuration', () async {
        final configMap = {
          ...minimal,
          "includeDeletedButReferenced": true,
        };

        final result = Config.fromMap(configMap);

        expect(result.includeDeletedButReferenced, isTrue);
        expect(result.toJson()["includeDeletedButReferenced"], isTrue);
      });

      test('supports asset configuration', () async {
        final map = {
          ...minimal,
          "assets": {
            "generate": true,
            "nodes": {
              "1:5": {
                "scales": [1, 2],
                "name": "check",
              },
              "23:1": {
                "name": "example_name",
              },
            },
          },
        };
        final result = Config.fromMap(map);
        expect(result.assets.generate, isTrue);
        expect(
          result.assets.nodes["1:5"]?.name,
          equals("check"),
        );
        expect(
          result.assets.nodes["1:5"]?.scales,
          equals([1, 2]),
        );
        expect(
          result.assets.nodes["23:1"]?.name,
          equals("example_name"),
        );
        expect(
          result.assets.nodes["23:1"]?.scales,
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

    group('when deserializing docs examples', () {
      test('works', () async {
        final yamlMap = loadYaml(docsYaml) as YamlMap;
        final config = Config.fromMap(yamlMap);

        expect(config, isA<Config>());
      });

      test('implements settings are correct', () async {
        final yamlMap = loadYaml(docsYaml) as YamlMap;
        final config = Config.fromMap(yamlMap);

        expect(config.colors.inheritance, hasLength(1));
        expect(
          config.colors.inheritance.first.collections,
          equals(["semantic"]),
        );
        expect(
          config.colors.inheritance.first.interfaces,
          hasLength(1),
        );
        expect(
          config.colors.inheritance.first.interfaces.first.name,
          equals("MyColors"),
        );
        expect(
          config.colors.inheritance.first.interfaces.first.import,
          equals("package:my_package/my_colors.dart"),
        );
      });

      test('rfc example works', () async {
        final yamlMap = loadYaml(rfcYaml) as YamlMap;
        final config = Config.fromMap(yamlMap);

        expect(config, isA<Config>());
        expect(config.colors.inheritance, hasLength(1));
        expect(
          config.colors.inheritance.first.collections,
          equals(["semantic"]),
        );
        expect(
          config.colors.inheritance.first.interfaces,
          hasLength(1),
        );
        expect(
          config.colors.inheritance.first.interfaces.first.name,
          equals("MyColors"),
        );
        expect(
          config.colors.inheritance.first.interfaces.first.import,
          equals("package:my_app/core/my_colors.dart"),
        );
      });
    });
  });
}

const docsYaml = '''

fileId: "YOUR_FIGMA_FILE_ID"
packageName: "design_tokens"
packageDescription: "A generated package that contains all of our design tokens"
asPackage: true
tokenPath: "src"
dropUnresolved: true
stylesFromLibrary: false
colors:
  generate: true # default
  from:
    - "semantic/colors"
  inheritance:
    - collections: ["semantic"]
      interfaces:
      - name: "MyColors"
        import: "package:my_package/my_colors.dart"
typography:
  generate: true # default
  from:
    - "semantic/typography"
  useGoogleFonts: true
numbers:
  generate: true # false by default
  # omitting `from` will generate all number tokens
spacers:
  generate: false # false by default
paddings:
  generate: false # false by default
assets:
  generate: true # false by default
  "1:5":  # Figma node ID
    name: "check" # name of the asset
    scales: [1, 2] # different scales 
  "23:1":
    name: "example_name"
''';

const rfcYaml = '''
fileId: "YOUR_FIGMA_FILE_ID"
packageName: "design_tokens"
asPackage: false
colors:
  from:
    - "semantic/colors"
  inheritance:
    - collections: ["semantic"] # empty list would mean the following interface settings apply to all collections
      interfaces:
        - name: "MyColors"
          import: "package:my_app/core/my_colors.dart"
''';
