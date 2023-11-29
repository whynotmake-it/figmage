import 'dart:io';

import 'package:figmage/src/data/repositories/yaml_config_repository.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/repositories/config_repository.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

class _MockFile extends Mock implements File {}

class _MockLogger extends Mock implements Logger {}

void main() {
  group('YamlConfigRepository', () {
    group('readConfigFromFile', () {
      late ProviderContainer container;
      late _MockFile file;
      late _MockLogger logger;

      late YamlConfigRepository sut;
      setUp(() {
        logger = _MockLogger();
        container = ProviderContainer(
          overrides: [loggerProvider.overrideWith((ref) => logger)],
        );
        sut = container.read(configRepositoryProvider) as YamlConfigRepository;
        file = _MockFile();
        when(
          () => file.path,
        ).thenReturn('./figmage.yaml');
        when(() => file.existsSync()).thenReturn(true);
        when(() => file.readAsString()).thenAnswer(
          (_) => Future.value(_yamlString),
        );

        when(() => logger.info(any())).thenReturn(null);
        when(() => logger.detail(any())).thenReturn(null);
        when(() => logger.warn(any())).thenReturn(null);
      });

      tearDown(() {
        container.dispose();
      });

      test('defaults to ./figmage.yaml and logs path', () async {
        sut.readConfigFromFile();
        verify(() => logger.info("Reading config from ./figmage.yaml"))
            .called(1);
      });

      test('checks if file exists and returns default config if not', () async {
        when(() => file.existsSync()).thenReturn(false);
        final result = await sut.readConfigFromFile(file: file);
        verify(
          () => logger.info('Config file not found, using default config.'),
        ).called(1);
        expect(result, const Config());
        verify(() => file.existsSync()).called(1);
      });

      test('returns default if file does not exist', () async {
        when(() => file.existsSync()).thenReturn(false);
        await expectLater(
          await sut.readConfigFromFile(file: file),
          const Config(),
        );
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

        expect(config.strings.generate, true);
        expect(config.strings.from, ['strings', 'strings2']);

        expect(config.bools.generate, true);
        expect(config.bools.from, ['bools', 'bools2']);

        expect(config.spacers.generate, true);
        expect(config.spacers.from, ['spacers', 'spacers2']);

        expect(config.paddings.generate, true);
        expect(config.paddings.from, ['paddings', '123/paddings2']);

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
        await expectLater(
          () => sut.readConfigFromFile(file: file),
          throwsA(isA<FormatException>()),
        );
      });

      test('does not warn for good yaml', () async {
        await sut.readConfigFromFile(file: file);
        verifyNever(() => logger.warn(any())).called(0);
      });

      test('warns for suspicious yaml', () async {
        when(() => file.readAsString()).thenAnswer(
          (_) => Future.value(_suspiciousYamlString),
        );
        final result = await sut.readConfigFromFile(file: file);
        expect(result.suspiciousFromDefined, isTrue);
        verify(
          () => logger.warn(
            any(that: contains('Your config includes at least one case')),
          ),
        ).called(1);
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
  generate: true
  from:
    - 'strings'
    - 'strings2'
bools:
  generate: true
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
    - '123/paddings2'
radii:
  generate: true
  from:
    - 'radii'
    - 'radii2'
''';

const _suspiciousYamlString = '''
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
  # this is suspicious
  generate: false
  from:
    - 'strings'
    - 'strings2'
bools:
  # this is suspicious
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
    - '123/paddings2'
radii:
  generate: true
  from:
    - 'radii'
    - 'radii2'
''';
