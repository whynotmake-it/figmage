import 'package:args/command_runner.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:riverpod/riverpod.dart';

/// {@template reforge_command}
/// A [Command] that updates an existing package.
/// {@endtemplate}
class ReforgeCommand extends Command<int> {
  /// {@macro reforge_command}
  ReforgeCommand(this._container) {
    argParser.addOption(
      "token",
      abbr: "t",
      mandatory: true,
      help: "Your figma API token",
    );
  }

  final ProviderContainer _container;

  @override
  String get description =>
      'This command reforges an existing package from your figma file.';

  @override
  String get name => 'reforge';

  Logger get _logger => _container.read(loggerProvider);

  @override
  Future<int> run() async {
    const output = 'Which unicorn has a cold? The Achoo-nicorn!';

    _logger.info(output);
    return ExitCode.success.code;
  }
}
