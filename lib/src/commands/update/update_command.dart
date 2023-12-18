import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:figmage/src/command_runner.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/providers/pub_updater_providers.dart';
import 'package:figmage/src/version.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';
import 'package:riverpod/riverpod.dart';

/// {@template update_command}
/// A command which updates the CLI.
/// {@endtemplate}
class UpdateCommand extends Command<int> {
  /// {@macro update_command}
  UpdateCommand(this._container);

  final ProviderContainer _container;

  Logger get _logger => _container.read(loggerProvider);

  PubUpdater get _pubUpdater => _container.read(pubUpdaterProvider);

  @override
  String get description => 'Update the CLI.';

  /// The name of this command in the command line.
  static const String commandName = 'update';

  @override
  String get name => commandName;

  @override
  Future<int> run() async {
    final updateCheckProgress = _logger.progress('Checking for updates');
    late final String latestVersion;
    try {
      latestVersion = await _pubUpdater.getLatestVersion(packageName);
    } catch (error) {
      updateCheckProgress.fail();
      _logger.err('$error');
      return ExitCode.software.code;
    }
    updateCheckProgress.complete('Checked for updates');

    final isUpToDate = packageVersion == latestVersion;
    if (isUpToDate) {
      _logger.info('CLI is already at the latest version.');
      return ExitCode.success.code;
    }

    final updateProgress = _logger.progress('Updating to $latestVersion');

    late final ProcessResult result;
    try {
      result = await _pubUpdater.update(
        packageName: packageName,
        versionConstraint: latestVersion,
      );
    } catch (error) {
      updateProgress.fail();
      _logger.err('$error');
      return ExitCode.software.code;
    }

    if (result.exitCode != ExitCode.success.code) {
      updateProgress.fail();
      _logger.err('Error updating CLI: ${result.stderr}');
      return ExitCode.software.code;
    }

    updateProgress.complete('Updated to $latestVersion');

    return ExitCode.success.code;
  }
}
