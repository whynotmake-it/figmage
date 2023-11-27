import 'package:args/args.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/providers/config_providers.dart';
import 'package:riverpod/riverpod.dart';

/// The arguments for the [settingsProvider] famil.
typedef SettingsProviderArgs = ({
  ArgResults argResults,
});

/// All settings that are used for the `forge` and `reforge` commands.
typedef FigmageSettings = ({
  String token,
  String fileId,
  String path,
  Config? config,
});

/// Tries to parse the shared settings that are needed for the `forge` and
/// `reforge` commands.
///
/// Throws an error if any aren't present.
final settingsProvider = FutureProvider.autoDispose
    .family<FigmageSettings, SettingsProviderArgs>((ref, args) async {
  final configPath = switch (args.argResults['configPath']) {
    final String? configPath => configPath,
    _ => null,
  };

  final config = await ref.watch(configProvider(configPath).future);
  final argResults = args.argResults;

  try {
    return (
      token: switch (argResults['token']) {
        final String token => token,
        _ => throw ArgumentError.notNull('token'),
      },
      fileId: switch (argResults['fileId'] ?? config?.fileId) {
        final String fileId => fileId,
        _ => throw ArgumentError.notNull('fileId'),
      },
      path: switch (argResults['path']) {
        final String path => path,
        _ => throw ArgumentError.notNull('path'),
      },
      config: config
    );
  } catch (e) {
    throw ArgumentError('Missing arguments');
  }
});
