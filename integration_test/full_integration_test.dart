import 'dart:convert';
import 'dart:io';

import 'package:figmage/src/command_runner.dart';
import 'package:path/path.dart' as path;
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'util/util.dart';

void main() {
  group('Full integration test', timeout: const Timeout(Duration(minutes: 15)),
      () {
    final (:token, :skipMessage) = getTokenOrSkip();

    test('prints help to console', () async {
      final process = await runFigmage(
        ['forge', '--help'],
      );
      final exitCode = await process.exitCode;
      expect(exitCode, 0);

      await expectLater(
        process.stdout.transform(const Utf8Decoder()),
        emits(equalsIgnoringWhitespace(helpText)),
      );
    });

    test('generates default package from command', skip: skipMessage, () async {
      final testDir = createFigmageTestDirectory();

      logger.info('Running integration test in: ${testDir.path}');

      // Change to test directory and run figmage directly
      final originalDir = Directory.current;
      Directory.current = testDir;
      
      try {
        final container = ProviderContainer();
        final exitCode = await FigmageCommandRunner(container).run([
          'forge',
          '-f',
          'HHUVTJ7lsjhG24SQB5h0zX',
          '-t',
          token!,
        ]);
        expect(exitCode, 0);
      } finally {
        // Restore original directory
        Directory.current = originalDir;
      }

      final pubspec = File(path.join(testDir.path, 'pubspec.yaml'));
      expect(pubspec.existsSync(), true);

      final pubspecContent = pubspec.readAsStringSync();

      expect(pubspecContent, contains('name: test_package'));

      final colorFile =
          File(path.join(testDir.path, 'lib', 'src', 'colors.dart'));
      final typographyFile =
          File(path.join(testDir.path, 'lib', 'src', 'typography.dart'));

      expect(colorFile.existsSync(), true);
      expect(typographyFile.existsSync(), true);

      final analyzeProcess = await Process.start(
        'dart',
        ['analyze', '--fatal-infos', '--fatal-warnings'],
        workingDirectory: testDir.path,
      );

      analyzeProcess.stdout.transform(utf8.decoder).listen(logger.info);
      analyzeProcess.stderr.transform(utf8.decoder).listen(logger.err);

      final analyzeExitCode = await analyzeProcess.exitCode;
      expect(
        analyzeExitCode,
        0,
        reason: 'Generated package has analysis issues',
      );
    });
  });
}

const helpText = '''
This command forges a new package from your figma file.

                    Usage: figmage forge [arguments]
                    -h, --help                 Print this usage information.
                    -t, --token (mandatory)    Your figma API token
                    -p, --path                 The ouptut path for the generated package, if not provided, the current directory will be used.
                    -f, --fileId               Your figma file ID, needs to be either given here, or in the figmage.yaml
                    
                    Run "figmage help" to see global options.
        ''';
