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
    null => Directory.current,
    final String dir => Directory(dir),
    _ => throw ArgumentError.value(args['path'], 'path'),
  };

  final configPath = join(dir.path, 'figmage.yaml');

  final config = await ref.watch(configProvider(configPath).future);

  final fileIdFromArgs = args.wasParsed('fileId') ? args['fileId'] : null;
  final fileId = switch (fileIdFromArgs ?? config.fileId) {
    final String fileId => fileId,
    _ => null,
  };

  final tokenFromArgs = args.wasParsed('token') ? args['token'] : null;
  final token = switch (tokenFromArgs) {
    final String token => token,
    _ => null,
  };

  final hasJsonSources = config.json.paths.isNotEmpty;

  if (fileId == null && hasJsonSources == false) {
    throw ArgumentError.notNull('fileId');
  }

  if (fileId != null && token == null) {
    throw ArgumentError.notNull('token');
  }

  return (
    token: token,
    fileId: fileId,
    path: dir.path,
    config: config,
  );
});
