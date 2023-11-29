import 'dart:io';

import 'package:figmage/src/command_runner.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

void main() {
  late ProviderContainer container;
  late String token;
  late String fileId;

  late Directory testDirectory;
  setUp(() {
    container = ProviderContainer();
    token = Platform.environment['FIGMA_TOKEN']!;
    fileId = Platform.environment['FIGMA_FILE_ID']!;

    testDirectory = Directory("${Directory.current.path}/test_generated");
  });

  tearDown(() {
    container.dispose();
    testDirectory.deleteSync(recursive: true);
  });

  group('can generate variables from test file', () {
    test('should generate variables', () async {
      final runner = FigmageCommandRunner(container);
      await runner.run([
        'forge',
        '--token',
        token,
        '--fileId',
        fileId,
        '--path',
        testDirectory.path,
      ]);

      final generatedFile = File(
        "${testDirectory.path}/lib/src/generated/variables.dart",
      );
      expect(generatedFile.existsSync(), true);
    });
  });
}
