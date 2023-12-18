import 'dart:io';

import 'package:figmage/src/command_runner.dart';
import 'package:riverpod/riverpod.dart';

Future<void> main(List<String> args) async {
  final container = ProviderContainer();
  await _flushThenExit(await FigmageCommandRunner(container).run(args));
}

/// Flushes the stdout and stderr streams, then exits the program with the given
/// status code.
///
/// This returns a Future that will never complete, since the program will have
/// exited already. This is useful to prevent Future chains from proceeding
/// after you've decided to exit.
Future<void> _flushThenExit(int status) {
  return Future.wait<void>([stdout.close(), stderr.close()])
      .then<void>((_) => exit(status));
}
