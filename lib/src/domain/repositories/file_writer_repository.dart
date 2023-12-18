import 'dart:io';

import 'package:figmage/src/data/repositories/dart_code_file_writer_repository.dart';
import 'package:riverpod/riverpod.dart';

/// A provider for a [FileWriterRepository] that writes code to files.
final fileWriterRepositoryProvider =
    Provider<FileWriterRepository>((ref) => DartCodeFileWriterRepository());

/// A repository that can write a collection of files to disk.
abstract interface class FileWriterRepository {
  /// Writes a collection of files to disk.
  ///
  /// [codeByFiles] includes the files to be written to as keys, and the code
  /// that should be written to them as values.
  ///
  /// If [append] is false (default), the files get overwritten, if it is true,
  /// the code gets appended to the files.
  ///
  /// By default, all files in [codeByFiles] get created if they don't exist.
  /// If you don't want this, set [createIfNotExists] to false.
  ///
  /// Returns the list of successfully generated files.
  Iterable<File> writeFiles({
    required Map<File, String> codeByFiles,
    bool append = false,
    bool createIfNotExists = true,
  });
}
