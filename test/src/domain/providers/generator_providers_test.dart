import 'dart:io';

import 'package:figma/figma.dart';
import 'package:figmage/src/data/generators/color_theme_extension_generator.dart';
import 'package:figmage/src/data/generators/number_theme_extension_generator.dart';
import 'package:figmage/src/data/generators/padding_generator.dart';
import 'package:figmage/src/data/generators/spacer_generator.dart';
import 'package:figmage/src/data/generators/text_style_theme_extension_generator.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/figmage_settings.dart';
import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:figmage/src/domain/models/tokens_by_file_type.dart';
import 'package:figmage/src/domain/providers/design_token_providers.dart';
import 'package:figmage/src/domain/providers/figmage_package_generator_providers.dart';
import 'package:figmage/src/domain/providers/generator_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import '../../../test_util/mock/mock_variables.dart';

class _MockLogger extends Mock implements Logger {}

class _MockProgress extends Mock implements Progress {}

void main() {
  group("generatorsProvider", () {
    late _MockLogger logger;
    late TokensByFileType mockTokensByFileType;
    late Iterable<File> mockGenerated;

    late ProviderContainer container;

    late FigmageSettings settings;

    setUp(() {
      logger = _MockLogger();
      when(() => logger.progress(any())).thenReturn(_MockProgress());

      mockTokensByFileType = TokensByFileType(
        colorTokens: [
          const ColorStyle(id: "id", name: "name", value: 0xFFFFFFFF),
          // mockColorVariable,
        ],
        typographyTokens: [
          TextStyle(id: "id", name: "name", value: TypeStyle()),
        ],
        numberTokens: [mockFloatVariable],
        boolTokens: [mockBoolVariable],
        stringTokens: [mockStringVariable],
      );
      mockGenerated = [
        for (final type in TokenFileType.values)
          File("lib/src/${type.filename}"),
      ];

      container = ProviderContainer(
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
    tearDown(() {
      container.dispose();
    });

    test('returns all existing in test case where everything exists', () async {
      final result = await container.read(generatorsProvider(settings).future);
      expect(result, hasLength(5));
      expect(
        result,
        contains(isA<(File, ColorThemeExtensionGenerator)>()),
      );
      expect(
        result,
        contains(isA<(File, TextStyleThemeExtensionGenerator)>()),
      );
      expect(
        result,
        contains(isA<(File, NumberThemeExtensionGenerator)>()),
      );
      expect(
        result,
        contains(isA<(File, SpacerGenerator)>()),
      );
      expect(
        result,
        contains(isA<(File, PaddingGenerator)>()),
      );
    });

    test('all file paths are included', () async {
      final result = await container.read(generatorsProvider(settings).future);
      expect(
        result.map((e) => e.$1.path),
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
