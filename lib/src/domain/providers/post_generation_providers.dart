import 'dart:io';

import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/repositories/post_generation_repository.dart';
import 'package:riverpod/riverpod.dart';

/// Runs maintenance tasks on the generated code using
/// [PostGenerationRepository].
///
/// Returns the list of files after maintenance tasks have been run.
final postGenerationTasksProvider = FutureProvider.autoDispose
    .family<Iterable<File>, Iterable<File>>((ref, files) async {
  final logger = ref.watch(loggerProvider);
  final repo = ref.watch(postGenerationRepositoryProvider);
  final progress = logger.progress("Running post generation tasks...");
  try {
    final result = await repo.runMaintenanceTasks(files, progress: progress);
    progress.complete("Ran post generation tasks.");
    return result;
  } catch (_) {
    progress.fail("Failed to run post generation tasks");
    rethrow;
  }
});
