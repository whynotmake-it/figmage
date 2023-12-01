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
    test(
      'should generate variables',
      timeout: const Timeout(Duration(minutes: 1)),
      () async {
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

        final files = [
          File("${testDirectory.path}/figmage_package/lib/src/colors.dart"),
          File("${testDirectory.path}/figmage_package/lib/src/typography.dart"),
        ];
        expect(files.every((f) => f.existsSync()), true);
      },
    );
  });
}
