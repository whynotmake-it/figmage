import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

/// {@template forge_command}
///
/// `figmage forge`
/// A [Command] to exemplify a sub command
/// {@endtemplate}
class ForgeCommand extends Command<int> {
  /// {@macro forge_command}
  ForgeCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser.addOption(
      "token",
      abbr: "t",
      mandatory: true,
      help: "Your figma API token",
    );
  }

  @override
  String get description =>
      'This command forges a new package from your figma file.';

  @override
  String get name => 'forge';

  final Logger _logger;

  @override
  Future<int> run() async {
    final output = 'Which unicorn has a cold? The Achoo-nicorn!';
    _logger.info(output);
    return ExitCode.success.code;
  }
}
