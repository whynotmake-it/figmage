import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:riverpod/riverpod.dart';

/// Provides a [Map<File, String>] based on
/// [Map<File, List<ThemeClassGeneratorResult>>].
final librariesProvider = Provider.family<Map<File, String>,
    Map<File, Iterable<({Class $class, Extension $extension})>>>(
  (ref, resultsByFile) {
    final logger = ref.watch(loggerProvider);

    final progress = logger.progress(
      "Creating library form ${resultsByFile.length} generation results...",
    );

    final libraryByFile = resultsByFile.map((file, results) {
      final libraryBuilder = LibraryBuilder();
      for (final result in results) {
        libraryBuilder.body.add(result.$class);
        libraryBuilder.body.add(result.$extension);
      }
      return MapEntry(file, libraryBuilder.build());
    });

    final dartfmt = DartFormatter();
    final emitter = DartEmitter(
      allocator: Allocator(),
      useNullSafetySyntax: true,
      orderDirectives: true,
    );

    final codeByFile = libraryByFile.map((file, library) {
      final codeString = '''
      ${ThemeClassGenerator.generatedFilePrefix}


      ${library.accept(emitter)}
    ''';
      return MapEntry(file, dartfmt.format(codeString));
    });

    progress.complete();
    return codeByFile;
  },
);
