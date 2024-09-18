import 'dart:io';

import 'package:args/args.dart';
import 'package:figmage/src/domain/models/figmage_settings.dart';
import 'package:figmage/src/domain/providers/config_providers.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';

/// Tries to parse the shared settings that are needed for the `forge` command.
///
/// Throws an error if any aren't present.
final settingsProvider = FutureProvider.autoDispose
    .family<FigmageSettings, ArgResults>((ref, args) async {
  final dir = switch (args['path']) {
    final String dir => Directory(dir),
    _ => throw ArgumentError.notNull('path'),
  };

  final configPath = join(dir.path, 'figmage.yaml');

  final config = await ref.watch(configProvider(configPath).future);

  return (
    token: switch (args['token']) {
      final String token => token,
      _ => throw ArgumentError.notNull('token'),
    },
    fileId: switch (args['fileId'] ?? config.fileId) {
      final String fileId => fileId,
      _ => throw ArgumentError.notNull('fileId'),
    },
    path: dir.path,
    config: config,
  );
});
