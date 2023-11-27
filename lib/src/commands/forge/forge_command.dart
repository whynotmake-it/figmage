// coverage:ignore-file
// TODO(Jesper): when implemented add test
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:figmage/src/commands/shared/forge_settings_providers.dart';
import 'package:figmage/src/domain/providers/figmage_package_generator_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/repositories/variables_repository.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:mason_logger/mason_logger.dart';
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
      )
      ..addOption(
        "configPath",
        abbr: "c",
        defaultsTo: "./figmage.yaml",
        help: 'Path to your figmage.yaml config file.',
      );
  }

  final ProviderContainer _container;

  @override
  String get name => 'forge';

  @override
  String get description =>
      'This command forges a new package from your figma file.';

  Logger get _logger => _container.read(loggerProvider);

  VariablesRepository get _figmaVariablesRepository =>
      _container.read(variablesRepositoryProvider);

  FigmagePackageGenerator get _figmagePackageGenerator =>
      _container.read(figmagePackageGeneratorProvider);

  @override
  Future<int> run() async {
    final FigmageSettings settings;

    try {
      settings = await _container.read(
        settingsProvider((argResults: argResults!,)).future,
      );
    } catch (e) {
      _logger.err(e.toString());
      return ExitCode.usage.code;
    }

    final variablesProcess = _logger.progress("Fetching variables");
    final variables = await _figmaVariablesRepository.getVariables(
      fileId: settings.fileId,
      token: settings.token,
    );
    if (variables.isEmpty) {
      variablesProcess.complete(
        """
        No variables found in file ${settings.fileId}. Exiting without generating package.
      """,
      );
      return ExitCode.success.code;
    }

    final targetDir = Directory(settings.path);
    _logger.detail("Target directory: ${targetDir.path}");
    final process = _logger.progress("Generating package");
    await _figmagePackageGenerator.generate(
      projectName: "figmage_example",
      dir: targetDir,
      description: "A test ",
    );

    process.complete("Successfully generated package!");

    // TODO(tim): fill files
    return ExitCode.success.code;
  }
}
