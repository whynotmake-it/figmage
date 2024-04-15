import 'dart:io';

import 'package:figmage/src/data/generators/file_generators/color_file_generator.dart';
import 'package:figmage/src/data/generators/file_generators/number_file_generator.dart';
import 'package:figmage/src/data/generators/file_generators/padding_file_generator.dart';
import 'package:figmage/src/data/generators/file_generators/spacer_file_generator.dart';
import 'package:figmage/src/data/generators/file_generators/typography_file_generator.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/figmage_settings.dart';
import 'package:figmage/src/domain/models/tokens_by_file_type/tokens_by_type.dart';
import 'package:figmage/src/domain/providers/design_token_providers.dart';
import 'package:figmage/src/domain/providers/figmage_package_generator_providers.dart';
import 'package:figmage/src/domain/providers/generator_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import '../../../test_util/create_container.dart';
import '../../../test_util/mock/mock_styles.dart';
import '../../../test_util/mock/mock_variables.dart';

class _MockLogger extends Mock implements Logger {}

class _MockProgress extends Mock implements Progress {}

void main() {
  group("generatorsProvider", () {
    late _MockLogger logger;
    late TokensByType mockTokensByFileType;
    late Iterable<File> mockGenerated;

    late ProviderContainer container;

    late FigmageSettings settings;

    setUp(() {
      logger = _MockLogger();
      when(() => logger.progress(any())).thenReturn(_MockProgress());

      mockTokensByFileType = TokensByType(
        colorTokens: [
          mockColorDesignStyle,
          mockColorVariable,
        ],
        typographyTokens: [
          mockTextDesignStyle,
        ],
        numberTokens: [mockFloatVariable],
        boolTokens: [mockBoolVariable],
        stringTokens: [mockStringVariable],
      );
      mockGenerated = [
        for (final type in TokenFileType.values)
          File("lib/src/${type.filename}"),
      ];

      container = createContainer(
        overrides: [
          loggerProvider.overrideWith((ref) => logger),
          filteredTokensProvider
              .overrideWith((ref, arg) => mockTokensByFileType),
          generatedPackageProvider.overrideWith((ref, arg) => mockGenerated),
        ],
      );

      settings = (
        fileId: "fileId",
        path: ".",
        token: "token",
        config: const Config(),
      );
    });

    test('All types, 2 ColorThemeGenerators since 2 collections', () async {
      final result = await container.read(generatorsProvider(settings).future);
      expect(result, hasLength(5));
      expect(
        result.values,
        containsAll([
          isA<ColorFileGenerator>(),
          isA<TypographyFileGenerator>(),
          isA<NumberFileGenerator>(),
          isA<SpacerFileGenerator>(),
          isA<PaddingFileGenerator>(),
        ]),
      );
    });

    test('all file paths are included', () async {
      final result = await container.read(generatorsProvider(settings).future);
      expect(
        result.keys.map((e) => e.path),
        containsAll([
          "lib/src/colors.dart",
          "lib/src/typography.dart",
          "lib/src/numbers.dart",
          "lib/src/spacers.dart",
          "lib/src/paddings.dart",
        ]),
      );
    });
  });
}
