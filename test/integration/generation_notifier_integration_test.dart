import 'dart:io';
import 'dart:math';

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

  group('can generate variables from test file', () {
    test('should generate variables', () async {
      final result = await Process.run(
        'dart',
        [
          'bin/figmage.dart',
          'forge',
          testDirectory.path,
          '--token',
          token,
          '--file-id',
          fileId,
        ],
      );
      expect(result.exitCode, 0);
    });
  });
}
