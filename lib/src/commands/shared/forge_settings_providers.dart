import 'package:args/args.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/providers/config_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:riverpod/riverpod.dart';

/// The arguments for the [settingsProvider] famil.
typedef SettingsProviderArgs = ({
  ArgResults argResults,
  String? configFilePath,
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
/// Returns an error if any aren't present.
final settingsProvider = FutureProvider.autoDispose
    .family<FigmageSettings, SettingsProviderArgs>((ref, args) async {
  final config = await ref.watch(configProvider(null).future);
});
