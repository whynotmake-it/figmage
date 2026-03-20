import 'dart:io';

import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/providers/figmage_package_generator_providers.dart';
import 'package:figmage/src/domain/providers/generator_providers.dart';
import 'package:figmage/src/domain/providers/library_provider.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

void main() {
  group('json resolver integration', () {
    test(
      'generates file-scoped classes and keeps resolver aliases resolved',
      () async {
        final fakeGeneratedFiles = <File>[
          File('${Directory.systemTemp.path}/colors.dart'),
          File('${Directory.systemTemp.path}/typography.dart'),
        ];

        final container = ProviderContainer(
          overrides: [
            generatedPackageProvider.overrideWith((ref, settings) async {
              return fakeGeneratedFiles;
            }),
          ],
        );
        addTearDown(container.dispose);

        final settings = (
          fileId: null,
          token: null,
          path: Directory.current.path,
          config: const Config(
            dropUnresolved: true,
            colors: GenerationSettings(from: ['Color Aliases']),
            json: JsonTokenSourceConfig(
              paths: [r'test/fixtures/json/sample_system/$resolver.json'],
            ),
          ),
        );

        final generators = await container.read(
          generatorsProvider(settings).future,
        );
        final codeByFile = container.read(librariesProvider(generators));

        final colorsCode = codeByFile.entries
            .singleWhere((entry) => p.basename(entry.key.path) == 'colors.dart')
            .value;
        final typographyCode = codeByFile.entries
            .singleWhere(
              (entry) => p.basename(entry.key.path) == 'typography.dart',
            )
            .value;

        expect(colorsCode, contains('class ColorAliases'));
        expect(colorsCode, contains('final Color paletteCorePrimary;'));
        expect(colorsCode, contains('final Color paletteCoreSystemLink;'));
        expect(
          colorsCode,
          contains('paletteCorePrimary = const Color(0xfff14f28),'),
        );
        expect(
          colorsCode,
          contains('paletteCoreSystemLink = const Color(0xff2f9bff),'),
        );
        expect(colorsCode, contains('final Color paletteCoreOverlay5;'));
        expect(
          colorsCode,
          contains('paletteCoreOverlay5 = const Color(0x0d5d8fa9),'),
        );

        expect(typographyCode, contains('class Display'));
        expect(typographyCode, contains('class Headline'));
        expect(typographyCode, contains('class Body'));
        expect(typographyCode, contains('class Label'));
        expect(typographyCode, contains('final TextStyle display1;'));
        expect(typographyCode, contains('final TextStyle body1;'));
        expect(
          typographyCode,
          contains('fontWeight: const FontWeight(463),'),
        );
      },
    );

    test(
      'does not collapse branches with different schemas '
      'into one nullable class',
      () async {
        final tempDir = await Directory.systemTemp.createTemp(
          'figmage_json_branching_',
        );
        addTearDown(() async {
          if (tempDir.existsSync()) {
            await tempDir.delete(recursive: true);
          }
        });

        final resolver = File('${tempDir.path}/\$resolver.json');
        final theme = File('${tempDir.path}/theme.json');

        await theme.writeAsString(
          '''
{
  "colors": {
    "light": {
      "surface": {"\$type": "color", "\$value": "#ffffff"},
      "text": {"\$type": "color", "\$value": "#111111"}
    },
    "dark": {
      "surface": {"\$type": "color", "\$value": "#000000"},
      "text": {"\$type": "color", "\$value": "#f0f0f0"}
    },
    "compact": {
      "badge": {"\$type": "color", "\$value": "#ff0000"}
    }
  }
}
''',
        );

        await resolver.writeAsString(
          '''
{
  "version": "2025.10",
  "sets": {
    "theme": {"\$ref": "./theme.json"}
  },
  "resolutionOrder": ["theme"]
}
''',
        );

        final fakeGeneratedFiles = <File>[
          File('${Directory.systemTemp.path}/colors.dart'),
        ];

        final container = ProviderContainer(
          overrides: [
            generatedPackageProvider.overrideWith((ref, settings) async {
              return fakeGeneratedFiles;
            }),
          ],
        );
        addTearDown(container.dispose);

        final settings = (
          fileId: null,
          token: null,
          path: tempDir.path,
          config: Config(
            dropUnresolved: true,
            colors: const GenerationSettings(from: ['theme']),
            json: const JsonTokenSourceConfig(paths: [r'$resolver.json']),
          ),
        );

        final generators = await container.read(
          generatorsProvider(settings).future,
        );
        final codeByFile = container.read(librariesProvider(generators));
        final colorsCode = codeByFile.entries
            .singleWhere((entry) => p.basename(entry.key.path) == 'colors.dart')
            .value;

        final classCount = RegExp(
          r'class\s+\w+\s+extends\s+ThemeExtension<',
        ).allMatches(colorsCode).length;

        // Mixed schemas are emitted as one class with branch-prefixed fields.
        expect(classCount, 1);
        expect(colorsCode, isNot(contains('final Color?')));
        expect(colorsCode, contains('final Color lightSurface;'));
        expect(colorsCode, contains('final Color darkSurface;'));
        expect(colorsCode, contains('final Color compactBadge;'));
        expect(colorsCode, isNot(contains('.light(')));
        expect(colorsCode, isNot(contains('.dark(')));
      },
    );
  });
}
