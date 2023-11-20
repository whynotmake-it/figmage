import 'dart:io';

import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/repositories/config_repository.dart';
import 'package:riverpod/riverpod.dart';

/// Parses and returns a [Config] from a YAML file.
///
/// You can pass a filepath to the file you want to read from. If you don't pass
/// a filepath, the default `./figmage.yaml` will be used.
final configProvider =
    FutureProvider.autoDispose.family<Config?, String?>((ref, path) {
  final repo = ref.watch(configRepositoryProvider);
  return repo.readConfigFromFile(file: path != null ? File(path) : null);
});
