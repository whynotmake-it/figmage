import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/json_token.dart';
import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/providers/design_token_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/repositories/json_tokens_repository.dart';
import 'package:figmage/src/domain/repositories/styles_repository.dart';
import 'package:figmage/src/domain/repositories/variables_repository.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as path;
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import '../../../test_util/create_container.dart';
import '../../../test_util/mock/mock_styles.dart';
import '../../../test_util/mock/mock_variables.dart';

class _MockStylesRepository extends Mock implements StylesRepository {}

class _MockVariablesRepository extends Mock implements VariablesRepository {}

class _MockJsonTokensRepository extends Mock implements JsonTokensRepository {}

class _MockLogger extends Mock implements Logger {}

class _MockProgress extends Mock implements Progress {}

void main() {
  late _MockLogger logger;
  late _MockProgress progress;

  const mockSettings = (
    config: Config(),
    fileId: "fileId",
    path: ".",
    token: "token",
  );

  const mockSettingsWithDroppingUnresolved = (
    config: Config(dropUnresolved: true),
    fileId: "fileId",
    path: ".",
    token: "token",
  );

  setUp(() {
    logger = _MockLogger();
    progress = _MockProgress();
    when(() => logger.progress(any())).thenReturn(progress);
    when(() => logger.level).thenReturn(Level.verbose);
  });

  group('filterUnresolvedTokensProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = createContainer(
        overrides: [
          loggerProvider.overrideWith((ref) => logger),
          filteredTokensProvider.overrideWith(
            (ref, _) async => mockTokensForType,
          ),
        ],
      );
    });

    test('includes all tokens when dropUnresolved is false', () async {
      final result = await container.read(
        filterUnresolvedTokensProvider(
          mockSettings,
        ).future,
      );
      expect(result.unresolvable.colorTokens.length, 1);
      expect(result.resolvable.colorTokens.length, 1);
    });

    test('omits unresolved tokens when dropUnresolved is true', () async {
      final result = await container.read(
        filterUnresolvedTokensProvider(
          mockSettingsWithDroppingUnresolved,
        ).future,
      );
      expect(result.unresolvable.colorTokens.length, 0);
      expect(result.resolvable.colorTokens.length, 1);
    });
  });

  group("filteredTokensProvider", () {
    late ProviderContainer container;
    setUp(() {
      container = createContainer(
        overrides: [
          loggerProvider.overrideWith((ref) => logger),
          variablesProvider.overrideWith(
            (ref, args) => Future.value(mockVariables),
          ),
          stylesProvider.overrideWith(
            (ref, args) => Future.value(mockStyles),
          ),
        ],
      );
    });
    test('returns correctly filtered tokens', () async {
      final tokensByType =
          await container.read(filteredTokensProvider(mockSettings).future);
      expect(
        tokensByType.colorTokens,
        containsAll([
          mockColorDesignStyle,
          mockColorVariableUnresolvable,
          mockColorVariable,
        ]),
      );
      expect(tokensByType.colorTokens, hasLength(3));
      expect(
        tokensByType.typographyTokens,
        contains(mockTextDesignStyle),
      );
      expect(tokensByType.typographyTokens, hasLength(1));
      expect(
        tokensByType.numberTokens,
        contains(mockFloatVariable),
      );
      expect(tokensByType.numberTokens, hasLength(1));
      expect(
        tokensByType.boolTokens,
        contains(mockBoolVariable),
      );
      expect(tokensByType.boolTokens, hasLength(1));
      expect(
        tokensByType.stringTokens,
        contains(mockStringVariable),
      );
      expect(tokensByType.stringTokens, hasLength(1));
    });
    test('throws ArgumentError if neither variables nor tokens exist',
        () async {
      container = createContainer(
        overrides: [
          loggerProvider.overrideWith((ref) => logger),
          variablesProvider.overrideWith(
            (ref, args) => Future.value([]),
          ),
          stylesProvider.overrideWith(
            (ref, args) => Future.value([]),
          ),
        ],
      );
      expect(
        () => container.read(filteredTokensProvider(mockSettings).future),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('jsonTokensProvider', () {
    late ProviderContainer container;
    late _MockJsonTokensRepository jsonTokensRepository;

    setUp(() {
      jsonTokensRepository = _MockJsonTokensRepository();
      when(() => jsonTokensRepository.getTokens(paths: any(named: 'paths')))
          .thenAnswer((_) async => []);
      container = createContainer(
        overrides: [
          jsonTokensRepositoryProvider
              .overrideWith((ref) => jsonTokensRepository),
        ],
      );
    });

    test('resolves relative paths against settings.path', () async {
      const settings = (
        config: Config(
          json: JsonTokenSourceConfig(paths: ["tokens.json"]),
        ),
        fileId: null,
        path: "root",
        token: null,
      );

      await container.read(jsonTokensProvider(settings).future);

      final captured = verify(
        () => jsonTokensRepository.getTokens(
          paths: captureAny(named: 'paths'),
        ),
      ).captured.single as Iterable<String>;
      expect(captured.toList(), [path.join("root", "tokens.json")]);
    });
  });

  group('filteredTokensProvider with json tokens', () {
    late ProviderContainer container;

    const jsonSettings = (
      config: Config(
        json: JsonTokenSourceConfig(paths: ["tokens.json"]),
      ),
      fileId: null,
      path: ".",
      token: null,
    );

    setUp(() {
      final jsonToken = JsonToken<int>(
        name: "colors/primary",
        fullName: "ds/colors/primary",
        collectionName: "ds",
        collectionId: "ds",
        valuesByModeName: {
          "light": const AliasOr<int>.data(data: 0xffffffff),
        },
      );

      container = createContainer(
        overrides: [
          jsonTokensProvider.overrideWith((ref, _) async => [jsonToken]),
        ],
      );
    });

    test('uses json tokens when figma sources are missing', () async {
      final tokensByType =
          await container.read(filteredTokensProvider(jsonSettings).future);
      expect(tokensByType.colorTokens, hasLength(1));
      expect(
        tokensByType.colorTokens.first.fullName,
        equals("ds/colors/primary"),
      );
    });
  });

  group("variablesProvider", () {
    late ProviderContainer container;
    late _MockVariablesRepository variablesRepository;
    setUp(() {
      variablesRepository = _MockVariablesRepository();
      when(
        () => variablesRepository.getVariables(
          fileId: any(named: "fileId"),
          token: any(named: "token"),
        ),
      ).thenAnswer((_) async => mockVariables);
      container = createContainer(
        overrides: [
          variablesRepositoryProvider
              .overrideWith((ref) => variablesRepository),
          loggerProvider.overrideWith((ref) => logger),
        ],
      );
    });

    test('calls repository method with fileId and token', () async {
      await container.read(variablesProvider(mockSettings).future);
      verify(
        () => variablesRepository.getVariables(
          fileId: "fileId",
          token: "token",
        ),
      ).called(1);
    });
    test('throws ArgumentError if styles are empty', () async {
      when(
        () => variablesRepository.getVariables(
          fileId: any(named: "fileId"),
          token: any(named: "token"),
        ),
      ).thenAnswer((_) async => []);
      expect(
        () => container.read(variablesProvider(mockSettings).future),
        throwsA(isA<ArgumentError>()),
      );
    });
    group('on VariablesException', () {
      setUp(() {
        when(
          () => variablesRepository.getVariables(
            fileId: any(named: "fileId"),
            token: any(named: "token"),
          ),
        ).thenThrow(const UnknownVariablesException("unknown_message"));
      });
      test('rethrows', () async {
        expect(
          () => container.read(variablesProvider(mockSettings).future),
          throwsA(
            isA<UnknownVariablesException>().having(
              (p0) => p0.message,
              "message",
              "unknown_message",
            ),
          ),
        );
      });
      test('logs error', () async {
        try {
          await container.read(variablesProvider(mockSettings).future);
        } catch (_) {}
        verify(
          () => progress.fail("Failed to fetch variables: unknown_message"),
        ).called(1);
      });
    });
    group('on other Error', () {
      setUp(() {
        when(
          () => variablesRepository.getVariables(
            fileId: any(named: "fileId"),
            token: any(named: "token"),
          ),
        ).thenThrow(ArgumentError("error_message"));
      });
      test('rethrows', () async {
        expect(
          () => container.read(variablesProvider(mockSettings).future),
          throwsA(
            isA<ArgumentError>().having(
              (p0) => p0.message,
              "message",
              "error_message",
            ),
          ),
        );
      });
      test('logs error', () async {
        try {
          await container.read(variablesProvider(mockSettings).future);
        } catch (_) {}
        verify(
          () => progress.fail(
            "Failed to fetch variables for unknown reason "
            "(Invalid argument(s): error_message)",
          ),
        ).called(1);
      });
    });
  });
  group("stylesProvider", () {
    late ProviderContainer container;
    late _MockStylesRepository stylesRepository;
    setUp(() {
      stylesRepository = _MockStylesRepository();
      when(
        () => stylesRepository.getStyles(
          fileId: any(named: "fileId"),
          token: any(named: "token"),
          fromLibrary: false,
          onProgress: any(named: "onProgress"),
        ),
      ).thenAnswer((_) async => mockStyles);
      container = createContainer(
        overrides: [
          stylesRepositoryProvider.overrideWith((ref) => stylesRepository),
          loggerProvider.overrideWith((ref) => logger),
        ],
      );
    });

    test('calls repository method with fileId and token', () async {
      await container.read(stylesProvider(mockSettings).future);
      verify(
        () => stylesRepository.getStyles(
          fileId: "fileId",
          token: "token",
          fromLibrary: false,
          onProgress: any(named: "onProgress"),
        ),
      ).called(1);
    });
    test('throws ArgumentError if styles are empty', () async {
      when(
        () => stylesRepository.getStyles(
          fileId: any(named: "fileId"),
          token: any(named: "token"),
          fromLibrary: false,
          onProgress: any(named: "onProgress"),
        ),
      ).thenAnswer((_) async => []);
      expect(
        () => container.read(stylesProvider(mockSettings).future),
        throwsA(isA<ArgumentError>()),
      );
    });
    test('warns when duplicate style names are detected', () async {
      const duplicateStyles = [
        TextDesignStyle(
          id: "style-1",
          fullName: "duplicate/name",
          value: Typography(
            fontFamily: "Inter",
            fontFamilyPostScriptName: "Inter",
            fontSize: 12,
          ),
        ),
        TextDesignStyle(
          id: "style-2",
          fullName: "duplicate/name",
          value: Typography(
            fontFamily: "Inter",
            fontFamilyPostScriptName: "Inter",
            fontSize: 14,
          ),
        ),
      ];
      when(
        () => stylesRepository.getStyles(
          fileId: any(named: "fileId"),
          token: any(named: "token"),
          fromLibrary: false,
          onProgress: any(named: "onProgress"),
        ),
      ).thenAnswer((_) async => duplicateStyles);

      await container.read(stylesProvider(mockSettings).future);

      verify(
        () => logger.warn(any(that: contains("duplicate/name"))),
      ).called(1);
    });
    group('on StylesException', () {
      setUp(() {
        when(
          () => stylesRepository.getStyles(
            fileId: any(named: "fileId"),
            token: any(named: "token"),
            fromLibrary: false,
            onProgress: any(named: "onProgress"),
          ),
        ).thenThrow(const UnknownStylesException("unknown_message"));
      });
      test('rethrows', () async {
        expect(
          () => container.read(stylesProvider(mockSettings).future),
          throwsA(
            isA<UnknownStylesException>().having(
              (p0) => p0.message,
              "message",
              "unknown_message",
            ),
          ),
        );
      });
      test('logs error', () async {
        try {
          await container.read(stylesProvider(mockSettings).future);
        } catch (_) {}
        verify(
          () => progress.fail("Failed to fetch styles: unknown_message"),
        ).called(1);
      });
    });

    group('on other Error', () {
      setUp(() {
        when(
          () => stylesRepository.getStyles(
            fileId: any(named: "fileId"),
            token: any(named: "token"),
            fromLibrary: false,
            onProgress: any(named: "onProgress"),
          ),
        ).thenThrow(ArgumentError("error_message"));
      });
      test('rethrows', () async {
        expect(
          () => container.read(stylesProvider(mockSettings).future),
          throwsA(
            isA<ArgumentError>().having(
              (p0) => p0.message,
              "message",
              "error_message",
            ),
          ),
        );
      });
      test('logs error', () async {
        try {
          await container.read(stylesProvider(mockSettings).future);
        } catch (_) {}
        verify(
          () => progress.fail(
            "Failed to fetch styles for unknown reason "
            "(Invalid argument(s): error_message)",
          ),
        ).called(1);
      });
    });
  });
}
