import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('Full integration test', () {
    setUp(() {});

    test('prints help to console', () async {
      final process = await Process.start(
        'dart',
        ['run', 'bin/figmage.dart', 'forge', '--help'],
      );
      final exitCode = await process.exitCode;
      expect(exitCode, 0);

      const helpText = '''
This command forges a new package from your figma file.

                    Usage: figmage forge [arguments]
                    -h, --help                 Print this usage information.
                        --path                 The ouptut path for the generated package, if not provided, the current directory will be used.
                                               (defaults to ".")
                    -t, --token (mandatory)    Your figma API token
                    -f, --fileId               Your figma file ID, needs to be either given here, or in the figmage.yaml
                    
                    Run "figmage help" to see global options.
        ''';

      await expectLater(
        process.stdout.transform(const Utf8Decoder()),
        emits(equalsIgnoringWhitespace(helpText)),
      );
    });

    test('generates default package from command', () async {
      final dir = Directory('./full_test_package')..createSync();
      addTearDown(() => dir.deleteSync(recursive: true));
      final process = await Process.start(
        'dart',
        [
          'run',
          '../bin/figmage.dart',
          'forge',
          '-f',
          'HHUVTJ7lsjhG24SQB5h0zX',
          '-t',
          Platform.environment['FIGMA_FREE_TOKEN']!,
        ],
        workingDirectory: dir.path,
      );
      final exitCode = await process.exitCode;
      expect(exitCode, 0);

      final pubspec = File("${dir.path}/pubspec.yaml");
      final pubspecContent = pubspec.readAsStringSync();
      expect(
        pubspecContent,
        contains("name: full_test_package"),
        reason: 'Package name was not generated from directory',
      );

      final files = [
        File("${dir.path}/lib/src/colors.dart"),
        File("${dir.path}/lib/src/typography.dart"),
      ];
      expect(
        files.every((f) => f.existsSync()),
        true,
        reason: 'Token files were not generated',
      );

      final analyzeProcess = await Process.start(
        'dart',
        ['analyze', '--fatal-infos', '--fatal-warnings'],
        workingDirectory: dir.path,
      );
      final analyzeExitCode = await analyzeProcess.exitCode;
      expect(
        analyzeExitCode,
        0,
        reason: 'Generated package has analysis issues',
      );
    });
  });
}
