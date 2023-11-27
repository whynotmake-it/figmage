import 'dart:io';

import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/providers/config_providers.dart';
import 'package:figmage/src/domain/repositories/config_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import '../../../test_provider_listener.dart';

class _MockConfigRepository extends Mock implements ConfigRepository {}

void main() {
  group("configProvider", () {
    late ProviderContainer container;
    late _MockConfigRepository configRepository;
    const config = Config(fileId: "fileId", packageName: "packageName");

    setUp(() {
      configRepository = _MockConfigRepository();
      when(() => configRepository.readConfigFromFile(file: any(named: 'file')))
          .thenAnswer((_) async => config);

      container = ProviderContainer(
        overrides: [
          configRepositoryProvider.overrideWith((ref) => configRepository),
        ],
      );
    });
    tearDown(() {
      container.dispose();
    });

    test('pipes through mockRepository', () async {
      final listener = TestListener<AsyncValue<Config>>();
      container.listen(
        configProvider('path/to/file'),
        listener.call,
        fireImmediately: true,
      );
      await container.read(configProvider('path').future);
      verify(
        () => configRepository.readConfigFromFile(
          file: any(
            named: 'file',
            that: isA<File>().having((f) => f.path, 'path', 'path/to/file'),
          ),
        ),
      ).called(1);
      verifyInOrder([
        () => listener.call(null, const AsyncLoading()),
        () => listener.call(const AsyncLoading(), const AsyncData(config)),
      ]);
    });

    test('calls repo with null if no path provided', () {
      container.read(configProvider(null).future);
      verify(
        () => configRepository.readConfigFromFile(
          file: any(named: 'file', that: isNull),
        ),
      ).called(1);
    });
  });
}
