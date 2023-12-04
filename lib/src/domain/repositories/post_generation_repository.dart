import 'dart:io';

import 'package:figmage/src/data/repositories/dart_post_generation_repository.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:riverpod/riverpod.dart';

/// A provider for a [PostGenerationRepository] that runs maintenance tasks on
/// the generated code.
final postGenerationRepositoryProvider = Provider<PostGenerationRepository>(
  (_) => const DartPostGenerationRepository(),
);

/// A repository that can run maintenance tasks on the generated code after
/// it has been generated.
abstract interface class PostGenerationRepository {
  /// Runs maintenance tasks on the generated code.
  ///
  /// Parameters:
  /// - [files]: The list of files to run maintenance tasks on.
  /// - [progress]: The progress to use for updating (optional).
  ///
  /// Returns the list of files after maintenance tasks have been run.
  Future<Iterable<File>> runMaintenanceTasks(
    Iterable<File> files, {
    Progress? progress,
  });
}
