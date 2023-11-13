import 'dart:io';

import 'package:figmage/src/data/repositories/yaml_config_repository.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockFile extends Mock implements File {}

void main() {
  group('YamlConfigRepository', () {
    group('readConfigFromFile', () {
      late YamlConfigRepository sut;
      late MockFile file;
      setUp(() {
        sut = YamlConfigRepository();
        file = MockFile();

        when(
          () => file.path,
        ).thenReturn('./figmage.yaml');
        when(() => file.existsSync()).thenReturn(true);
        when(() => file.readAsString()).thenAnswer(
          (_) => Future.value(_yamlString),
        );
      });

      test('checks if file exists', () async {
        when(() => file.existsSync()).thenReturn(false);
        expect(
          () async => await sut.readConfigFromFile(file: file),
          throwsA(isA<FileSystemException>()),
        );
        verify(() => file.existsSync()).called(1);
      });

      test('reads the file', () async {
        await sut.readConfigFromFile(file: file);
        verify(() => file.readAsString()).called(1);
      });

      test('parses example yaml', () async {
        final config = await sut.readConfigFromFile(file: file);
        expect(config, isNotNull);
        expect(config.fileId, 'fileId');
        expect(config.packageName, 'Design Token Package');
        expect(
          config.packageDescription,
          'Design Tokens generated from our Figma',
        );
        expect(config.packageDir, './path');

        expect(config.colors.generate, true);
        expect(config.colors.from, ['color', 'color2']);

        expect(config.typography.generate, true);
        expect(config.typography.from, ['typography', 'typography2']);

        expect(config.strings.generate, false);
        expect(config.strings.from, ['strings', 'strings2']);

        expect(config.bools.generate, false);
        expect(config.bools.from, ['bools', 'bools2']);

        expect(config.spacers.generate, true);
        expect(config.spacers.from, ['spacers', 'spacers2']);

        expect(config.paddings.generate, true);
        expect(config.paddings.from, ['paddings', 'paddings2']);

        expect(config.radii.generate, true);
        expect(config.radii.from, ['radii', 'radii2']);
      });

      test('reads minimum yaml with defaults from Config class', () async {
        when(() => file.readAsString()).thenAnswer(
          (_) => Future.value(_minimumYamlString),
        );

        final config = await sut.readConfigFromFile(file: file);
        expect(
          config,
          const Config(
            fileId: 'fileId',
            packageName: 'Design Token Package',
          ),
        );
      });

      test('throws FormatException on malformat', () async {
        when(() => file.readAsString()).thenAnswer(
          (_) => Future.value('malformat'),
        );
        expect(
          () => sut.readConfigFromFile(file: file),
          throwsA(isA<FormatException>()),
        );
      });

      test('throws FormatException if values are missing', () async {
        when(() => file.readAsString()).thenAnswer(
          (_) => Future.value('fileId: fileId'),
        );
        expect(
          () => sut.readConfigFromFile(file: file),
          throwsA(isA<FormatException>()),
        );
      });
    });
  });
}

const _minimumYamlString = '''
fileId: 'fileId'
packageName: Design Token Package
''';

const _yamlString = '''
fileId: 'fileId'
packageName: Design Token Package
packageDescription: Design Tokens generated from our Figma
outputPath: ./path
colors:
  generate: true
  from:
    - 'color'
    - 'color2'
typography:
  generate: true
  from:
    - 'typography'
    - 'typography2'
strings:
  generate: false
  from:
    - 'strings'
    - 'strings2'
bools:
  generate: false
  from:
    - 'bools'
    - 'bools2'
spacers:
  generate: true
  from:
    - 'spacers'
    - 'spacers2'
paddings:
  generate: true
  from:
    - 'paddings'
    - 'paddings2'
radii:
  generate: true
  from:
    - 'radii'
    - 'radii2'
''';
