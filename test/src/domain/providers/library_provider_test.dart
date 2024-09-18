import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/domain/generators/file_generator.dart';
import 'package:figmage/src/domain/providers/library_provider.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import '../../../test_util/create_container.dart';

class _MockLogger extends Mock implements Logger {}

class _MockProgress extends Mock implements Progress {}

class _MockFileGenerator extends Mock implements FileGenerator {}

void main() {
  group("generatorsProvider", () {
    late _MockLogger logger;
    late Map<File, _MockFileGenerator> mockGeneratedResults;

    late ProviderContainer container;

    setUp(() {
      logger = _MockLogger();
      when(() => logger.progress(any())).thenReturn(_MockProgress());

      mockGeneratedResults = {
        for (final type in TokenFileType.values)
          File("lib/src/${type.filename}"): _MockFileGenerator(),
      };

      for (final gen in mockGeneratedResults.values) {
        when(gen.generate).thenReturn(
          Library(
            (l) => l.body.add(const Code("class TestClass {}")),
          ),
        );
      }

      container = createContainer(
        overrides: [
          loggerProvider.overrideWith((ref) => logger),
        ],
      );
    });

    test('Calls each generator once', () async {
      final result = container.read(librariesProvider(mockGeneratedResults));
      expect(result, hasLength(TokenFileType.values.length));

      for (final gen in mockGeneratedResults.values) {
        verify(gen.generate);
        verifyNoMoreInteractions(gen);
      }
    });

    test('Returns a map of files to formatted code', () async {
      final result = container.read(librariesProvider(mockGeneratedResults));

      for (final MapEntry(key: file, value: code) in result.entries) {
        expect(code, contains("class TestClass {}"));
        expect(file.path, contains("lib/src/"));
      }
    });
  });
}
