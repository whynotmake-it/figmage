import 'dart:async';
import 'dart:io';

import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/repositories/config_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
    File file = const _DefaultFile(),
  }) async {
    final configFile = switch (file) {
      _DefaultFile() => File('./figmage.yaml'),
      _ => file,
    };
    _logger
      ..level = Level.info
      ..info('Reading config from ${configFile.path}');

    return Config(fileId: "asd", packageName: "asd");
  }

  /// Reads a YAML file and returns a [YamlMap].
  Future<YamlMap> _readYamlFile(File file) async {
    if (file.existsSync() == false) {
      throw ArgumentError.value(file, 'file', 'Config file does not exist.');
    }
    final yamlString = await file.readAsString();
    return loadYaml(yamlString) as YamlMap;
  }
}

/// This helper class allows for a default file instance in
/// [YamlConfigRepository]`.readConfigFromFile`.
///
/// You should never call any methods on instances of this class.
class _DefaultFile implements File {
  const _DefaultFile();

  @override
  Never noSuchMethod(Invocation invocation) {
    throw NoSuchMethodError.withInvocation(this, invocation);
  }
}
