import 'dart:convert';
import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

final logger = Logger();

/// Tries to get the Figma token from the environment variables.
///
/// If the token is not found, the test is skipped and null is returned,
/// together with a skip message.
({String? token, String? skipMessage}) getTokenOrSkip() {
  final figmaToken = Platform.environment['FIGMA_FREE_TOKEN'] ??
      Platform.environment['FIGMA_TOKEN'];

  if (figmaToken == null) {
    return (
      token: null,
      skipMessage: 'No Figma token found in environment variables. '
          'Set FIGMA_FREE_TOKEN or FIGMA_TOKEN to run this test.',
    );
  }

  return (
    token: figmaToken,
    skipMessage: null,
  );
}

/// Creates a temporary directory for running figmage tests.
///
/// This function creates a temporary directory and adds a tear-down function
/// to delete it when the test is finished.
///
/// Returns the created directory.
Directory createFigmageTestDirectory({String name = 'test_package'}) {
  final tmpDir =
      Directory.systemTemp.createTempSync('figmage_integration_test_');
  final testDir = Directory(path.join(tmpDir.path, name))
    ..createSync(recursive: true);
  addTearDown(() {
    try {
      testDir.deleteSync(recursive: true);
    } catch (e) {
      logger.warn('Warning: Failed to clean up test directory: $e');
    }
  });

  return testDir;
}

/// Runs the figmage executable with the given arguments.
///
/// If [attachLogger] is true, the process's stdout and stderr will be attached
/// to the logger.
///
/// If [workingDirectory] is provided, the process will be run in the given
/// directory.
/// Otherwise, the process will be run in the current directory.
Future<Process> runFigmage(
  List<String> args, {
  Directory? workingDirectory,
  bool attachLogger = false,
}) async {
  // Find the executable path relative to the current file
  final testDir = Directory.current.path;
  var executablePath =
      path.normalize(path.join(testDir, 'bin', 'figmage.dart'));
  if (!File(executablePath).existsSync()) {
    // Try relative path as fallback
    executablePath =
        path.normalize(path.join(testDir, '..', 'bin', 'figmage.dart'));
  }

  final process = await Process.start(
    'dart',
    [
      'run',
      executablePath,
      ...args,
    ],
    workingDirectory: workingDirectory?.path,
  );

  if (attachLogger) {
    process.stdout.transform(utf8.decoder).listen(logger.info);
    process.stderr.transform(utf8.decoder).listen(logger.err);
  }

  return process;
}
