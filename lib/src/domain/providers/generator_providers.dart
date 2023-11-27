import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/color_theme_extension_generator.dart';
import 'package:figmage/src/data/generators/number_theme_extension_generator.dart';
import 'package:figmage/src/data/generators/padding_generator.dart';
import 'package:figmage/src/data/generators/spacer_generator.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:riverpod/riverpod.dart';

/// The arguments for the [generatorProvider]
typedef GeneratorProviderArgs = ({
  String filename,
  List<Variable> variables,
  GenerationSettings settings,
});

/// Provides a [ThemeClassGenerator] based on the filename, variables and
/// settings, if there is a supported generator.
final generatorProvider =
    Provider.family<ThemeClassGenerator?, GeneratorProviderArgs>(
  (ref, args) {
    final type = TokenFileType.tryFromFilename(args.filename);
    if (type == null || args.settings.generate == false) return null;

    final valuesByNameByMode = switch (type) {
      TokenFileType.color => args.variables.whereType<ColorVariable>(),
      TokenFileType.numbers ||
      TokenFileType.spacers ||
      TokenFileType.paddings ||
      TokenFileType.radii =>
        args.variables.whereType<FloatVariable>(),
      TokenFileType.strings => args.variables.whereType<StringVariable>(),
      TokenFileType.bools => args.variables.whereType<BooleanVariable>(),
      // TODO(tim): support
      TokenFileType.typography => args.variables,
    }
        .filterByFrom(args.settings)
        .valuesByNameByMode;

    return switch (type) {
      TokenFileType.color => ColorThemeExtensionGenerator(
          className: "ThemeColors",
          valuesByNameByMode: valuesByNameByMode.cast(),
        ),
      TokenFileType.numbers => NumberThemeExtensionGenerator(
          className: "ThemeNumbers",
          valuesByNameByMode: valuesByNameByMode.cast(),
        ),
      TokenFileType.spacers => SpacerGenerator(
          className: "ThemeSpacers",
          valueNames: valuesByNameByMode.keys.toList(),
          numberReference: const Reference("ThemeNumbers", "numbers.dart"),
        ),
      TokenFileType.paddings => PaddingGenerator(
          className: "ThemePaddings",
          valueNames: valuesByNameByMode.keys.toList(),
          numberReference: const Reference("ThemeNumbers", "numbers.dart"),
        ),
      TokenFileType.radii => null,
      TokenFileType.strings => null,
      TokenFileType.bools => null,
      TokenFileType.typography => null,
    };
  },
);

extension _VariableFilterX<T extends Variable> on Iterable<T> {
  Iterable<T> filterByFrom(GenerationSettings settings) => where(
        (variable) =>
            settings.from.isEmpty ||
            settings.from.any(variable.name.startsWith),
      );

  Map<String, Map<String, dynamic>> get valuesByNameByMode {
    final allModes = expand((variable) => variable.valuesByMode.keys).toSet();
    return {
      for (final mode in allModes)
        mode: {
          for (final variable in this)
            if (variable.valuesByMode.containsKey(mode))
              variable.name: variable.valuesByMode[mode],
        },
    };
  }
}
