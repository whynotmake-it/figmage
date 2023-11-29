// coverage:ignore-file
// TODO(Jesper): when implemented add test
import 'package:args/command_runner.dart';
import 'package:figmage/src/commands/shared/create_new_package/generation_notifier.dart';
import 'package:riverpod/riverpod.dart';

/// {@template forge_command}
///
/// `figmage forge <path> --token <token> --fileId <fileId>`
/// A [Command] to exemplify a sub command
/// {@endtemplate}
class ForgeCommand extends Command<int> {
  /// {@macro forge_command}
  ForgeCommand(this._container) {
    argParser
      ..addOption(
        "path",
        defaultsTo: ".",
        help: '''
          The ouptut path for the generated package. Defaults to the current directory.
        ''',
      )
      ..addOption(
        "token",
        abbr: "t",
        help: "Your figma API token",
        mandatory: true,
      )
      ..addOption(
        "fileId",
        abbr: "f",
        help: "Your figma file ID",
      );
  }

  final ProviderContainer _container;

  @override
  String get name => 'forge';

  @override
  String get description =>
      'This command forges a new package from your figma file.';

  @override
  Future<int> run() async {
    final exitCode =
        await _container.read(generationStateProvider(argResults!).future);
    return exitCode.code;
  }
}
