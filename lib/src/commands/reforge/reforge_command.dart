import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

/// {@template reforge_command}
/// A [Command] that updates an existing package.
/// {@endtemplate}
class ReforgeCommand extends Command<int> {
  /// {@macro reforge_command}
  ReforgeCommand({
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
      'This command reforges an existing package from your figma file.';

  @override
  String get name => 'reforge';

  final Logger _logger;

  @override
  Future<int> run() async {
    var output = 'Which unicorn has a cold? The Achoo-nicorn!';
    if (argResults?['cyan'] == true) {
      output = lightCyan.wrap(output)!;
    }
    _logger.info(output);
    return ExitCode.success.code;
  }
}
