import 'package:args/args.dart';
import 'package:figmage/src/commands/shared/forge_settings_providers.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/providers/config_providers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import '../../../test_util/create_container.dart';

class _MockArgResults extends Mock implements ArgResults {}

void main() {
  group("settingsProvider", () {
    late ProviderContainer container;
    const config = Config(fileId: "fileId", packageName: "packageName");

    late ArgResults argResults;
    setUp(() {
      container = createContainer(
        overrides: [
          configProvider.overrideWith((ref, _) => config),
        ],
      );
      argResults = _MockArgResults();

      when(() => argResults['token']).thenReturn("arg_token");
      when(() => argResults['fileId']).thenReturn("arg_fileId");
      when(() => argResults['path']).thenReturn("arg_path");
      when(() => argResults.wasParsed('path')).thenReturn(true);
    });

    group('settingsProvider', () {
      test('returns token from argResults', () async {
        final result =
            await container.read(settingsProvider(argResults).future);
        expect(result.token, "arg_token");
      });

      test('prefers fileId from argResults', () async {
        final result =
            await container.read(settingsProvider(argResults).future);
        expect(result.fileId, "arg_fileId");
      });

      test('takes fileId from config if not in args', () async {
        when(() => argResults['fileId']).thenReturn(null);
        final result =
            await container.read(settingsProvider(argResults).future);
        expect(result.fileId, config.fileId);
      });

      test('returns path from argResults if parsed', () async {
        final result =
            await container.read(settingsProvider(argResults).future);
        expect(result.path, "arg_path");
      });

      test('throws an ArgumentError if path is not a string or null', () async {
        when(() => argResults['path']).thenReturn(0);
        await expectLater(
          () => container.read(settingsProvider(argResults).future),
          throwsA(
            isA<ArgumentError>().having((p0) => p0.name, 'name', 'path'),
          ),
        );
      });

      test('throws ArgumentError if token is missing', () async {
        when(() => argResults['token']).thenReturn(null);
        await expectLater(
          () => container.read(settingsProvider(argResults).future),
          throwsA(
            isA<ArgumentError>().having((p0) => p0.name, 'name', 'token'),
          ),
        );
      });
    });
  });
}
