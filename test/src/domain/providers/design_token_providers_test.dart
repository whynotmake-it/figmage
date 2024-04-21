import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/providers/design_token_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/repositories/styles_repository.dart';
import 'package:figmage/src/domain/repositories/variables_repository.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import '../../../test_util/create_container.dart';
import '../../../test_util/mock/mock_styles.dart';
import '../../../test_util/mock/mock_variables.dart';

class _MockStylesRepository extends Mock implements StylesRepository {}

class _MockVariablesRepository extends Mock implements VariablesRepository {}

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
        ),
      ).called(1);
    });
    test('throws ArgumentError if styles are empty', () async {
      when(
        () => stylesRepository.getStyles(
          fileId: any(named: "fileId"),
          token: any(named: "token"),
        ),
      ).thenAnswer((_) async => []);
      expect(
        () => container.read(stylesProvider(mockSettings).future),
        throwsA(isA<ArgumentError>()),
      );
    });
    group('on StylesException', () {
      setUp(() {
        when(
          () => stylesRepository.getStyles(
            fileId: any(named: "fileId"),
            token: any(named: "token"),
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
