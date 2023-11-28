import 'dart:io';

import 'package:test/test.dart';

void main() {
  late String token;
  late String fileId;

  late Directory testDirectory;
  setUp(() {
    token = Platform.environment['FIGMA_TOKEN']!;
    fileId = Platform.environment['FIGMA_FILE_ID']!;

    testDirectory = Directory("${Directory.current.path}/test_generated");
  });

  tearDown(() {
    testDirectory.deleteSync(recursive: true);
  });

  group('can generate variables from test file', () {
    test('should generate variables', () async {
      final result = await Process.run(
        'dart',
        [
          'bin/figmage.dart',
          'forge',
          '--path',
          testDirectory.path,
          '--token',
          token,
          '--fileId',
          fileId,
        ],
      );
      if (result.exitCode != 0) {
        print(result.stdout);
        print(result.stderr);
      }
      expect(result.exitCode, 0);
    });
  });
}
