import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:figmage/src/data/repositories/figma_variables_repository.dart';
import 'package:figmage/src/domain/models/models.dart';
import 'package:figmage/src/generators/builder/color_from_int_builder.dart';
import 'package:figmage/src/generators/theme_extension_generator.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as path;

const String colorExtensionSymbol = 'Color';
const String colorExtensionSymbolUrl = 'package:flutter/material.dart';

/// {@template forge_command}
///
/// `figmage forge`
/// A [Command] to exemplify a sub command
/// {@endtemplate}
class ForgeCommand extends Command<int> {
  /// {@macro forge_command}
  ForgeCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser.addOption(
      "token",
      abbr: "t",
      help: "Your figma API token",
    );
    argParser.addOption(
      "fileId",
      abbr: "f",
      help: "Your figma file ID",
    );
  }

  @override
  String get description =>
      'This command forges a new package from your figma file.';

  @override
  String get name => 'forge';

  final Logger _logger;

  @override
  Future<int> run() async {
    final YamlMap? maybeConfig = await readFigmageConfig(_logger);
    final token = argResults?['token'];
    final fileId = argResults?['fileId'] ?? maybeConfig?['fileId'];

    if (token == null || fileId == null) {
      _logger.err('Both token and fileId are required.');
      return ExitCode.usage.code;
    }

    final packageGenerator = FigmagePackageGenerator();
    final targetDir = Directory.current;
    final process = _logger.progress("Generating package");
    await packageGenerator.generate(
      projectName: "figmage_example",
      dir: targetDir,
      description: "A test ",
    );
    process.complete("Successfully generated package!");

    //VARIABLES
    final repo = FigmaVariablesRepository();
    final variables = await repo.getVariables(fileId: fileId, token: token);

    if (maybeConfig == null || maybeConfig['colors'] == true) {
      //Generate colors from variables
      final collectionColorMaps =
          repo.createValueModeMap<int, ColorVariable>(variables: variables);
      final colorGenerators = collectionColorMaps.entries.map((entry) {
        return ThemeExtensionGenerator<int>(
          className: entry.key,
          valueMaps: entry.value,
          extensionSymbol: colorExtensionSymbol,
          extensionSymbolUrl: colorExtensionSymbolUrl,
          valueToConstructorArguments: colorFromIntBuilder,
        );
      }).toList();
      final colorExtensions = await Future.wait(
        colorGenerators.map(
          (g) => Future.value(
            g.justGenerate(),
          ),
        ),
      );

      colorExtensions.insert(0, "import '$colorExtensionSymbolUrl';");

      appendListToFile(
        colorExtensions,
        '${Directory.current.path}/figmage_example/lib/src/tokens/colors.dart',
      );
    }

    return ExitCode.success.code;
  }
}

Future<YamlMap?> readFigmageConfig(Logger logger) async {
  final projectRoot = Directory.current;
  final figmageConfigPath = path.join(projectRoot.path, 'figmage.yaml');

  final figmageConfigFile = File(figmageConfigPath);

  if (await figmageConfigFile.exists()) {
    try {
      final yamlString = await figmageConfigFile.readAsString();
      final YamlMap? yamlMap = loadYaml(yamlString);
      return yamlMap;
    } catch (e, stack) {
      logger.warn('Errors occurred while parsing the YAML file:');
      logger.err(e.toString());
    }
  }
  return null;
}

void appendListToFile(List<String> entries, String filePath) {
  final file = File(filePath);

  // Create the file if it doesn't exist
  if (!file.existsSync()) {
    file.createSync(recursive: true);
  }

  // Open the file in append mode
  final sink = file.openWrite(mode: FileMode.append);

  // Append each entry to the file, separated by a line break
  for (final entry in entries) {
    sink.write('$entry\n');
  }

  // Close the file
  sink.close();
}
