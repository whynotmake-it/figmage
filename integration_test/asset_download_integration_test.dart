import 'dart:io';

import 'package:figmage/src/command_runner.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'util/util.dart';

void main() {
  group('Asset download integration test', () {
    final (:token, :skipMessage) = getTokenOrSkip();

    test(
      'downloads and generates assets from figma with config',
      skip: skipMessage,
      () async {
        final dir = createFigmageTestDirectory();

        // Create figmage.yaml with asset configuration
        File('${dir.path}/figmage.yaml').writeAsStringSync('''
fileId: AxYhq1VnMWeq09C4otvoQx
assets:
  generate: true
  nodes:
    "1:5":
      name: icon_one
      scales: [0.5, 1, 2]
    "1:48":
      name: icon_two
    "2001:89":
      name: icon_three
      scales: [100, 2, 3]
''');

        // Create container and command runner
        final container = ProviderContainer();
        addTearDown(container.dispose);

        // Using the command runner to enable break points
        final commandRunner = FigmageCommandRunner(container);

        // Run the forge command directly
        final exitCode = await commandRunner.run([
          'forge',
          '-t',
          token!,
          '-p',
          dir.path,
        ]);

        expect(exitCode, 0);

        // Verify assets directory was created
        final assetsDir = Directory('${dir.path}/assets/');
        expect(
          assetsDir.existsSync(),
          true,
          reason: 'Assets directory was not created',
        );

        // Verify assets file was generated
        final assetsFile = File('${dir.path}/lib/src/assets.dart');
        expect(
          assetsFile.existsSync(),
          true,
          reason: 'Assets file was not generated',
        );

        // Verify specific assets were downloaded with correct scales
        final expectedFiles = [
          'icon_one.png',
          'icon_one@0.5x.png',
          'icon_one@2.0x.png',
          'icon_two.png',
        ];

        final assetFiles =
            assetsDir.listSync().map((f) => f.path.split('/').last);
        for (final expectedFile in expectedFiles) {
          expect(
            assetFiles.contains(expectedFile),
            true,
            reason: 'Expected asset $expectedFile was not downloaded',
          );
        }

        // Verify the generated assets.dart file has correct content
        final assetsContent = assetsFile.readAsStringSync();
        expect(
          assetsContent,
          contains('static const String iconOne05xPng = '),
          reason: 'Assets class missing iconOne constant',
        );
        expect(
          assetsContent,
          contains('static const String iconTwoPng = '),
          reason: 'Assets class missing iconTwo constant',
        );
      },
      timeout: const Timeout(Duration(minutes: 1)),
    );
  });
}
