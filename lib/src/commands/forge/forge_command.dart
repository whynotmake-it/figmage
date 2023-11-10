import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
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
    const generator = FigmagePackageGenerator();
    final targetDir = Directory.current;
    final process = _logger.progress("Generating package");
    await generator.generate(
      projectName: "figmage_example",
      dir: targetDir,
      description: "A test ",
    );
    process.complete("Successfully generated package!");
    return ExitCode.success.code;
  }
}
