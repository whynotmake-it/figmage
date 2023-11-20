// coverage:ignore-file
// TODO(Jesper): when implemented add test
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:figmage/src/data/generators/color_theme_extension_generator.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage/src/domain/providers/config_providers.dart';
import 'package:figmage/src/domain/providers/figmage_package_generator_providers.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/repositories/variables_repository.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:riverpod/riverpod.dart';
import 'package:yaml/yaml.dart';

/// {@template forge_command}
///
/// `figmage forge <path> --token <token> --fileId <fileId>`
/// A [Command] to exemplify a sub command
/// {@endtemplate}
class ForgeCommand extends Command<int> {
  /// {@macro forge_command}
  ForgeCommand(this._container) {
    argParser
      ..addOption(
        "path",
        defaultsTo: ".",
        help: '''
          The ouptut path for the generated package. Defaults to the current directory.
        ''',
      )
      ..addOption(
        "token",
        abbr: "t",
        help: "Your figma API token",
        mandatory: true,
      )
      ..addOption(
        "fileId",
        abbr: "f",
        help: "Your figma file ID",
      );
  }

  final ProviderContainer _container;

  @override
  String get name => 'forge';

  @override
  String get description =>
      'This command forges a new package from your figma file.';

  Logger get _logger => _container.read(loggerProvider);

  VariablesRepository get _figmaVariablesRepository =>
      _container.read(variablesRepositoryProvider);

  FigmagePackageGenerator get _figmagePackageGenerator =>
      _container.read(figmagePackageGeneratorProvider);

  @override
  Future<int> run() async {
    final token = argResults?['token'] as String?;
    final maybeConfig = await _container.read(configProvider(null).future);
    final fileId = (argResults?['fileId'] ?? maybeConfig?.fileId) as String?;

    if (token == null || fileId == null) {
      _logger.err('Both token and fileId are required.');
      return ExitCode.usage.code;
    }

    final targetDir = Directory.current;
    final process = _logger.progress("Generating package");
    await _figmagePackageGenerator.generate(
      projectName: "figmage_example",
      dir: targetDir,
      description: "A test ",
    );
    process.complete("Successfully generated package!");

    //VARIABLES
    final variables = await _figmaVariablesRepository.getVariables(
      fileId: fileId,
      token: token,
    );

    if (maybeConfig == null || maybeConfig['colors'] == true) {
      //Generate colors from variables
      final collectionColorMaps = _figmaVariablesRepository
          .createValueModeMap<int, ColorVariable>(variables: variables);
      final colorGenerators = collectionColorMaps.entries.map((entry) {
        return ColorThemeExtensionGenerator(
          className: entry.key,
          valuesByNameByMode: entry.value,
        );
      }).toList();
      final colorExtensions = await Future.wait(
        colorGenerators.map(
          (g) => Future.value(
            g.generate(),
          ),
        ),
      );

      _appendCodeEntriesToFile(
        colorExtensions,
        '${Directory.current.path}/figmage_example/lib/src/tokens/colors.dart',
      );
    }

    return ExitCode.success.code;
  }
}
