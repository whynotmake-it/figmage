import 'dart:io';

import 'package:collection/collection.dart';
import 'package:figmage/src/domain/repositories/post_generation_repository.dart';
import 'package:mason_logger/mason_logger.dart';

/// A function that runs a process, like [Process.run].
typedef ProcessRunner = Future<ProcessResult> Function(
  String command,
  List<String> args, {
  String? workingDirectory,
});

/// {@template dart_post_generation_repository}
/// A post generation repository that runs maintenance tasks on the generated
/// code.
///
/// This repository finds the pubspec.yaml in generated files and runs the
/// following tasks on the directory containing the pubspec.yaml:
/// - `dart pub get`
/// - `dart format`
/// - `dart fix --apply`
/// {@endtemplate}
class DartPostGenerationRepository implements PostGenerationRepository {
  /// {@macro dart_post_generation_repository}
  ///
  /// Allows to override the [processRunner] for testing purposes, defaults
  /// to [Process.run].
  const DartPostGenerationRepository({
    ProcessRunner? processRunner,
  }) : _processRunner = processRunner ?? Process.run;

  final ProcessRunner _processRunner;

  @override
  Future<Iterable<File>> runMaintenanceTasks(
    Iterable<File> files, {
    Progress? progress,
  }) async {
    final pubspecYaml = files
        .firstWhereOrNull((element) => element.path.endsWith('pubspec.yaml'));

    if (pubspecYaml == null) {
      progress?.fail("No pubspec.yaml found in generated files");
      return files;
    }

    final directory = pubspecYaml.parent;

    try {
      progress?.update("Running pub get in ${directory.path}");
      await _processRunner(
        'dart',
        ['pub', 'get'],
        workingDirectory: directory.path,
      );
      progress?.update("Running dart format in ${directory.path}");
      await _processRunner(
        'dart',
        ['format', '.'],
        workingDirectory: directory.path,
      );
      progress?.update("Running dart fix in ${directory.path}");
      await _processRunner(
        'dart',
        ['fix', '--apply'],
        workingDirectory: directory.path,
      );
    } catch (_) {
      rethrow;
    }

    return files;
  }
}
