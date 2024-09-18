import 'dart:io';

import 'package:figmage/src/command_runner.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/providers/config_providers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import '../test/test_util/create_container.dart';

/// A file that contains only local styles, no library styles.
const localStylesFileId = "HHUVTJ7lsjhG24SQB5h0zX";

void main() {
  group("GenerationNotifier", () {
    late ProviderContainer container;
    late String? token;
    late String? fileId;

    late Directory testDirectory;

    late Config config;

    setUp(() {
      config = const Config();
      testDirectory = Directory("${Directory.current.path}/figmage_package");
      container = createContainer(
        overrides: [
          configProvider.overrideWith((ref, arg) => config),
        ],
      );
      token = Platform.environment['FIGMA_FREE_TOKEN'];
    });

    tearDown(() {
      try {
        testDirectory.deleteSync(recursive: true);
      } catch (_) {}
    });

    Future<void> run() async {
      final runner = FigmageCommandRunner(container);
      await runner.run([
        'forge',
        '--token',
        token!,
        '--fileId',
        fileId!,
        '--path',
        testDirectory.path,
      ]);
    }

    group('can generate from local styles file', () {
      setUp(() {
        fileId = localStylesFileId;
      });

      test(
        'should generate unpublished styles by default',
        timeout: const Timeout(Duration(minutes: 1)),
        () async {
          await run();
          final files = [
            File("${testDirectory.path}/lib/src/colors.dart"),
            File(
              "${testDirectory.path}/lib/src/typography.dart",
            ),
          ];
          expect(files.every((f) => f.existsSync()), true);
        },
      );
    });

    test(
      'generates no styles if stylesFromLibrary is true',
      timeout: const Timeout(Duration(minutes: 1)),
      () async {
        config = const Config(stylesFromLibrary: true);
        await expectLater(run, throwsArgumentError);
      },
    );
  });
}
