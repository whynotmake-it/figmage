import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:figmage/src/data/repositories/figma_variables_repository.dart';
import 'package:figmage/src/domain/models/models.dart';
import 'package:figmage/src/generators/color_theme_extension_generator.dart';
import 'package:figmage/src/generators/theme_extension_generator.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

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
    final maybeConfig = await readFigmageConfig(_logger);
    final token = argResults?['token'] as String?;
    final fileId = (argResults?['fileId'] ?? maybeConfig?['fileId']) as String?;

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
    final variables = await repo.getVariables(
      fileId: fileId as String,
      token: token as String,
    );

    if (maybeConfig == null || maybeConfig['colors'] == true) {
      //Generate colors from variables
      final collectionColorMaps =
          repo.createValueModeMap<int, ColorVariable>(variables: variables);
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

  // ignore: avoid_slow_async_io
  if (await figmageConfigFile.exists()) {
    try {
      final yamlString = await figmageConfigFile.readAsString();
      final yamlMap = loadYaml(yamlString);
      return yamlMap as YamlMap?;
    } catch (e, _) {
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
