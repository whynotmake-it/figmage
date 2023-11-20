import 'dart:io';

import 'package:figmage/src/domain/repositories/file_writer_repository.dart';

class DartCodeFileWriter implements FileWriterRepository {
  @override
  Future<void> writeFiles(
      {required Map<File, String> codeByFiles,
      bool append = false,
      bool createIfNotExists = true}) {
    // TODO: implement writeFiles
    throw UnimplementedError();
  }
}
