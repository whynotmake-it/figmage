import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/providers/library_provider.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

class _MockLogger extends Mock implements Logger {}

class _MockProgress extends Mock implements Progress {}

void main() {
  group("generatorsProvider", () {
    late _MockLogger logger;
    late Iterable<File> mockGenerated;
    late Iterable<Iterable<ThemeClassGeneratorResult>> mockResults;
    late Map<File, Iterable<ThemeClassGeneratorResult>> mockGeneratedResults;

    late ProviderContainer container;

    setUp(() {
      logger = _MockLogger();
      when(() => logger.progress(any())).thenReturn(_MockProgress());

      mockGenerated = [
        for (final type in TokenFileType.values)
          File("lib/src/${type.filename}"),
      ];

      mockResults = [
        for (final type in TokenFileType.values)
          [
            (
              $class: Class((c) => c..name = type.className),
              $extension: Extension(
                (e) => e
                  ..name = '${type.className}BuildContextExtension'
                  ..on = refer('BuildContext'),
              ),
            ),
          ],
      ];

      mockGeneratedResults = Map.fromIterables(mockGenerated, mockResults);

      container = ProviderContainer(
        overrides: [
          loggerProvider.overrideWith((ref) => logger),
        ],
      );
    });
    tearDown(() {
      container.dispose();
    });

    test('Should convert all ThemeClassGeneratorResult to String', () async {
      final result = container.read(librariesProvider(mockGeneratedResults));
      expect(result, hasLength(TokenFileType.values.length));

      for (final file in result.keys) {
        final content = result[file];
        final type = TokenFileType.values
            .firstWhere((t) => file.path.contains(t.filename));

        expect(content, contains('class ${type.className}'));
        expect(
          content,
          contains(
            'extension ${type.className}BuildContextExtension on BuildContext',
          ),
        );
      }
    });
  });
}
