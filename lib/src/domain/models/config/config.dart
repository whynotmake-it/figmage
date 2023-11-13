import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.g.dart';

/// {@template config}
/// A configuration for the figmage forge command, typically parsed from a
/// figmage.yaml file.
///
/// The only required arguments are the Figma file ID and the package name.
/// If nothing else is configured, the command will generate a package with all
/// color, typography, string and boolean tokens.
///
/// Number variables can be used to generate spacers, paddings and borders,
/// however, these are all off by default, as all number variables would be used
/// for all types of tokens which would clutter the namespace.
///
/// If you want to generate spacers, paddings or borders, you should consider
/// configuring `GenerationSettings.from` to only generate from a specific path.
/// {@endtemplate}
@JsonSerializable(anyMap: true, checked: true)
class Config with EquatableMixin {
  /// {@macro config}
  const Config({
    required this.fileId,
    required this.packageName,
    this.packageDescription = '',
    this.packageDir = '.',
    this.colors = const GenerationSettings(),
    this.typography = const GenerationSettings(),
    this.strings = const GenerationSettings(),
    this.bools = const GenerationSettings(),
    this.spacers = const GenerationSettings(generate: false),
    this.paddings = const GenerationSettings(generate: false),
    this.radii = const GenerationSettings(generate: false),
  });

  /// Initializes a [Config] from a json map.
  factory Config.fromMap(Map<dynamic, dynamic> json) => _$ConfigFromJson(json);

  /// figma file ID.
  final String fileId;

  /// The name of the generated dart package, e.g. figmage_example.
  final String packageName;

  /// The description of the generated dart package.
  final String packageDescription;

  /// The directory to generate the package in, relative to the config file.
  ///
  /// Defaults to the current directory.
  final String packageDir;

  /// Color generation settings, defaults to generating color tokens from
  /// all paths.
  final GenerationSettings colors;

  /// Typography generation settings, defaults to generating typography tokens
  /// from all paths.
  final GenerationSettings typography;

  /// String generation settings, defaults to generating string tokens from
  /// all paths.
  final GenerationSettings strings;

  /// Boolean generation settings, defaults to generating boolean tokens from
  /// all paths.
  final GenerationSettings bools;

  /// Spacers generation settings, defaults to not generating spacers.
  final GenerationSettings spacers;

  /// Paddings generation settings, defaults to not generating paddings.
  final GenerationSettings paddings;

  /// Borders generation settings, defaults to not generating borders.
  final GenerationSettings radii;

  @override
  List<Object?> get props => [
        fileId,
        packageName,
        packageDescription,
        packageDir,
        colors,
        typography,
        strings,
        bools,
        spacers,
        paddings,
        radii,
      ];
}

/// {@template generation_settings}
/// Settings for generating a type of token. This includes whether or not to
/// generate the token and which paths to generate from.
/// {@endtemplate}
@JsonSerializable(anyMap: true, checked: true)
class GenerationSettings with EquatableMixin {
  /// {@macro generation_settings}
  const GenerationSettings({
    @Default(true) this.generate = true,
    @Default(<String>[]) this.from = const <String>[],
  });

  /// Initializes a [GenerationSettings] from a json map.
  factory GenerationSettings.fromJson(Map<dynamic, dynamic> json) =>
      _$GenerationSettingsFromJson(json);

  /// Whether or not to generate the token, defaults to true.
  final bool generate;

  /// The paths to generate from, defaults to empty which means all paths.
  final Iterable<String> from;

  @override
  List<Object?> get props => [generate, ...from];
}
