import 'dart:io';

import 'package:figmage/src/command_runner.dart';
import 'package:figmage/src/commands/shared/forge_settings_providers.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/providers/config_providers.dart';
import 'package:figmage/src/domain/providers/design_token_providers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import '../test/test_util/create_container.dart';

/// A file that contains only local styles, no library styles.
const localStylesFileId = "HHUVTJ7lsjhG24SQB5h0zX";

void main() {
  group("GenerationNotifier", () {
    late ProviderContainer container;
    late String? token;

    late Directory testDirectory;

    late Config config;

    late List<String> args;

    late FigmageCommandRunner runner;

    setUp(() {
      config = const Config();
      testDirectory = Directory("${Directory.current.path}/figmage_package");
      container = createContainer(
        overrides: [
          configProvider.overrideWith((ref, arg) => config),
        ],
      );
      token = Platform.environment['FIGMA_FREE_TOKEN'];
      runner = FigmageCommandRunner(container);
    });

    tearDown(() {
      try {
        testDirectory.deleteSync(recursive: true);
      } catch (_) {}
    });

    group('can generate from local styles file', () {
      setUp(() {
        args = [
          'forge',
          '--token',
          token!,
          '--fileId',
          localStylesFileId,
          '--path',
          testDirectory.path,
        ];
      });

      test(
        'should generate 7 unpublished styles by default',
        timeout: const Timeout(Duration(minutes: 1)),
        () async {
          await runner.run(args);
          final files = [
            File("${testDirectory.path}/lib/src/colors.dart"),
            File(
              "${testDirectory.path}/lib/src/typography.dart",
            ),
          ];
          final argResults = runner.parse(args).command!;
          final settings =
              await container.read(settingsProvider(argResults).future);
          final styles = await container.read(stylesProvider(settings).future);

          expect(styles, hasLength(7));
          expect(files.every((f) => f.existsSync()), true);
        },
      );
    });

    test(
      'generates no styles if stylesFromLibrary is true',
      timeout: const Timeout(Duration(minutes: 1)),
      () async {
        config = const Config(stylesFromLibrary: true);
        await expectLater(runner.run(args), throwsArgumentError);
      },
    );
  });
}
