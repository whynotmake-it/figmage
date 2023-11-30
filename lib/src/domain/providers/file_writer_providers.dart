import 'dart:io';

import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/repositories/file_writer_repository.dart';
import 'package:riverpod/riverpod.dart';

/// Writes the generated code to files and returns the list of files written.
final fileWriterProvider =
    FutureProvider.family<Iterable<File>, Map<File, String>>(
        (ref, codeByFiles) async {
  final repo = ref.watch(fileWriterRepositoryProvider);
  final logger = ref.watch(loggerProvider);
  final progress = logger.progress("Writing files...");
  try {
    final files = repo.writeFiles(codeByFiles: codeByFiles);
    progress.complete("Wrote ${files.length} files");
    return files;
  } catch (_) {
    progress.fail("Failed to write files");
    rethrow;
  }
});
