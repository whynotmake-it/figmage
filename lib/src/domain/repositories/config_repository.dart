import 'dart:async';
import 'dart:io';

import 'package:figmage/src/domain/models/config/config.dart';

/// A repository that can read a configuration file and return a [Config].
///
/// For documentation on the configuration itself, refer to [Config].
abstract interface class ConfigRepository {
  /// Reads a configuration [file] and returns a [Config].
  ///
  /// If [file] is null or omitted, the implementation should try to read a
  /// sensible default file.
  FutureOr<Config> readConfigFromFile({
    File? file,
  });
}
