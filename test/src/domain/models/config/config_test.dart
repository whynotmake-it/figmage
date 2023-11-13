import 'package:figmage/src/domain/models/config/config.dart';
import 'package:test/test.dart';

void main() {
  group('Config', () {
    group('defaults', () {
      test('are correct', () {
        const sut = Config(fileId: "fileId", packageName: "packageName");
        expect(sut.colors.generate, isTrue);
        expect(sut.colors.from, isEmpty);
        expect(sut.typography.generate, isTrue);
        expect(sut.typography.from, isEmpty);
        expect(sut.strings.generate, isTrue);
        expect(sut.strings.from, isEmpty);
        expect(sut.bools.generate, isTrue);
        expect(sut.bools.from, isEmpty);
        expect(sut.spacers.generate, isFalse);
        expect(sut.spacers.from, isEmpty);
        expect(sut.paddings.generate, isFalse);
        expect(sut.paddings.from, isEmpty);
      });
    });

    group('fromMap', () {
      late Map<dynamic, dynamic> minimal;
      late Map<dynamic, dynamic> full;

      setUp(() {
        minimal = {
          "fileId": "fileId",
          "packageName": "packageName",
        };

        full = {
          ...minimal,
          "packageDescription": "packageDescription",
          "colors": {
            "generate": true,
            "from": ["path1", "path2"],
          },
          "typography": {
            "generate": true,
            "from": ["path1", "path2"],
          },
          "strings": {
            "generate": true,
            "from": ["path1", "path2"],
          },
          "bools": {
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
      });

      test('supports generation from minimal map', () async {
        final result = Config.fromMap(minimal);
        expect(
          result,
          const Config(fileId: "fileId", packageName: "packageName"),
        );
      });

      test('supports generation from full map', () async {
        final result = Config.fromMap(full);
        expect(
          result,
          const Config(
            fileId: "fileId",
            packageName: "packageName",
            packageDescription: "packageDescription",
            colors: GenerationSettings(
              from: ["path1", "path2"],
            ),
            typography: GenerationSettings(
              from: ["path1", "path2"],
            ),
            strings: GenerationSettings(
              from: ["path1", "path2"],
            ),
            bools: GenerationSettings(
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
          ),
        );
      });
    });
  });
}
