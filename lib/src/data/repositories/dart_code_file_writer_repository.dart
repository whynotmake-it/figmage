import 'dart:io';

import 'package:figmage/src/domain/repositories/file_writer_repository.dart';

/// A [FileWriterRepository] for writing Dart code to files.
class DartCodeFileWriterRepository implements FileWriterRepository {
  @override
  Iterable<File> writeFiles({
    required Map<File, String> codeByFiles,
    bool append = false,
    bool createIfNotExists = true,
  }) sync* {
    for (final MapEntry(key: file, value: code) in codeByFiles.entries) {
      final exists = file.existsSync();

      if (exists == false && createIfNotExists) {
        file.createSync(recursive: true);
      } else if (exists == false && createIfNotExists == false) {
        continue;
      }
      try {
        file.writeAsStringSync(
          code,
          mode: append ? FileMode.append : FileMode.write,
        );
        yield file;
      } catch (_) {}
    }
  }
}
