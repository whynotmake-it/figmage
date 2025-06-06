import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:figmage/src/domain/generators/file_generator.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:riverpod/riverpod.dart';

/// Provides the library code for each file, based on the generators.
final librariesProvider =
    Provider.family<Map<File, String>, Map<File, FileGenerator>>(
  (ref, generatorsByFile) {
    final logger = ref.watch(loggerProvider);

    final progress = logger.progress(
      "Creating library form ${generatorsByFile.length} generation results...",
    );

    final dartfmt = DartFormatter(
      languageVersion: DartFormatter.latestLanguageVersion,
    );

    final emitter = DartEmitter(
      allocator: Allocator(),
      useNullSafetySyntax: true,
      orderDirectives: true,
    );

    final codeByFile = generatorsByFile.map((file, generator) {
      final code = generator.generate().accept(emitter);
      final formattedCode = dartfmt.format(code.toString());
      return MapEntry(file, formattedCode);
    });

    progress.complete();
    return codeByFile;
  },
);
