import 'dart:async';
import 'dart:io';

import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/repositories/config_repository.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:yaml/yaml.dart';

/// {@template yaml_config_repository}
/// A [ConfigRepository] that reads from a YAML file, `./figmage.yaml` by
/// default.
/// {@endtemplate}
class YamlConfigRepository implements ConfigRepository {
  /// {@macro yaml_config_repository}
  YamlConfigRepository({
    Logger? logger,
  }) : _logger = logger ?? Logger();

  final Logger _logger;

  @override
  FutureOr<Config> readConfigFromFile({
    File? file,
  }) async {
    final configFile = switch (file) {
      null => File('./figmage.yaml'),
      _ => file,
    };

    _logger.info('Reading config from ${configFile.path}');

    final yamlMap = await _readYamlFile(configFile);

    final Config config;
    try {
      config = Config.fromMap(yamlMap);
    } catch (e) {
      throw FormatException(
        'Error when parsing config file: $e',
      );
    }
    _logger.detail('Parsed Config: $config');

    if (config.suspiciousFromDefined) {
      _logger.warn(
        'Your config includes at least one case in which you set a `generate` '
        'flag to false but put entries into `from` list. Make sure this is '
        'intended ',
      );
    }

    return config;
  }

  /// Reads a YAML file and returns a [YamlMap].
  Future<YamlMap> _readYamlFile(File file) async {
    if (file.existsSync() == false) {
      throw FileSystemException(
        'Config file $file does not exist.',
      );
    }
    final yamlString = await file.readAsString();
    return switch (loadYaml(yamlString)) {
      final YamlMap yamlMap => yamlMap,
      _ => throw FormatException(
          'Config file $file is not a valid YAML file.',
        ),
    };
  }
}
