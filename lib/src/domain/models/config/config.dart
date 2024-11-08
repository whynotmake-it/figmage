import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.g.dart';

/// {@template asset_node_settings}
/// Settings for a single asset node from Figma.
/// {@endtemplate}
@JsonSerializable(anyMap: true, checked: true)
class AssetNodeSettings with EquatableMixin {
  /// {@macro asset_node_settings}
  const AssetNodeSettings({
    required this.name,
    this.scales = const [1],
  });

  /// Initializes [AssetNodeSettings] from a json map.
  factory AssetNodeSettings.fromJson(Map<dynamic, dynamic> json) =>
      _$AssetNodeSettingsFromJson(json);

  /// The name to use for the asset.
  final String name;

  /// The scale factors to generate for this asset.
  final List<num> scales;

  /// Converts [AssetNodeSettings] to a json map.
  Map<String, dynamic> toJson() => _$AssetNodeSettingsToJson(this);

  @override
  List<Object?> get props => [name, scales];
}

/// {@template asset_group_settings}
/// Settings for a group of assets from Figma.
/// {@endtemplate}
@JsonSerializable(anyMap: true, checked: true)
class AssetGroupSettings with EquatableMixin {
  /// {@macro asset_group_settings}
  const AssetGroupSettings({
    required this.nodes,
  });

  /// Initializes [AssetGroupSettings] from a json map.
  factory AssetGroupSettings.fromJson(Map<dynamic, dynamic> json) =>
      _$AssetGroupSettingsFromJson(json);

  /// The nodes in this group, keyed by node ID.
  final Map<String, AssetNodeSettings> nodes;

  /// Converts [AssetGroupSettings] to a json map.
  Map<String, dynamic> toJson() => _$AssetGroupSettingsToJson(this);

  @override
  List<Object?> get props => [nodes];
}

/// {@template asset_generation_settings}
/// Settings for generating assets from Figma nodes.
/// {@endtemplate}
@JsonSerializable(anyMap: true, checked: true)
class AssetGenerationSettings extends GenerationSettings {
  /// {@macro asset_generation_settings}
  const AssetGenerationSettings({
    super.generate = false,
    this.groups = const {},
  });

  /// Initializes [AssetGenerationSettings] from a json map.
  factory AssetGenerationSettings.fromJson(Map<dynamic, dynamic> json) {
    final groups = <String, AssetGroupSettings>{};
    json.forEach((key, value) {
      if (key != 'generate' && value is Map) {
        groups[key.toString()] = AssetGroupSettings(
          nodes: (value as Map).map(
            (k, v) => MapEntry(
              k.toString(),
              AssetNodeSettings.fromJson(v as Map),
            ),
          ),
        );
      }
    });
    return AssetGenerationSettings(
      generate: json['generate'] as bool? ?? false,
      groups: groups,
    );
  }

  /// The asset groups, keyed by group name.
  final Map<String, AssetGroupSettings> groups;

  /// Converts [AssetGenerationSettings] to a json map.
  @override
  Map<String, dynamic> toJson() => _$AssetGenerationSettingsToJson(this);

  @override
  List<Object?> get props => [...super.props, groups];
}

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
@JsonSerializable(
  anyMap: true,
  checked: true,
  explicitToJson: true,
)
class Config with EquatableMixin {
  /// {@macro config}
  const Config({
    this.packageName,
    this.fileId,
    this.packageDescription = '',
    this.dropUnresolved = false,
    this.stylesFromLibrary = false,
    this.colors = const GenerationSettings(),
    this.typography = const TypographyGenerationSettings(),
    this.strings = const GenerationSettings(),
    this.bools = const GenerationSettings(),
    this.numbers = const GenerationSettings(),
    this.spacers = const GenerationSettings(generate: false),
    this.paddings = const GenerationSettings(generate: false),
    this.radii = const GenerationSettings(generate: false),
    this.assets = const AssetGenerationSettings(),
  });

  /// Initializes a [Config] from a json map.
  factory Config.fromMap(Map<dynamic, dynamic> json) => _$ConfigFromJson(json);

  /// The name of the generated dart package, e.g. figmage_example.
  ///
  /// Will default to the current directory name if not provided.
  final String? packageName;

  /// figma file ID.
  final String? fileId;

  /// The description of the generated dart package.
  final String packageDescription;

  /// Determines whether to drop unresolvable values.
  ///
  /// When true, values that
  /// cannot be resolved (e.g., an alias pointing to a missing variable) are
  /// omitted, ensuring all tokens are resolvable in all modes (e.g., light and
  /// dark mode). When false, unresolved variables are included but will return
  /// null. Defaults to false.
  final bool dropUnresolved;

  /// Whether to fetch the styles that were published to the library.
  ///
  /// If false, all styles will simply be fetched from the current state of the
  /// file.
  /// Defaults to false.
  final bool stylesFromLibrary;

  /// Color generation settings, defaults to generating color tokens from
  /// all paths.
  final GenerationSettings colors;

  /// Typography generation settings, defaults to generating typography tokens
  /// from all paths and using google fonts.
  final TypographyGenerationSettings typography;

  /// String generation settings, defaults to generating string tokens from
  /// all paths.
  final GenerationSettings strings;

  /// Boolean generation settings, defaults to generating boolean tokens from
  /// all paths.
  final GenerationSettings bools;

  /// Number generation settings, defaults to not generating number tokens from
  /// all paths.
  final GenerationSettings numbers;

  /// Spacers generation settings, defaults to not generating spacers.
  final GenerationSettings spacers;

  /// Paddings generation settings, defaults to not generating paddings.
  final GenerationSettings paddings;

  /// Borders generation settings, defaults to not generating borders.
  final GenerationSettings radii;

  /// Asset generation settings, defaults to not generating assets.
  final AssetGenerationSettings assets;

  /// All generation settings.
  List<GenerationSettings> get allGenerationSettings => [
        colors,
        typography,
        strings,
        bools,
        numbers,
        spacers,
        paddings,
        radii,
      ];

  /// Whether any setting defines at least one `from` but has `generate: false`.
  ///
  /// Is used to warn the user that there might be a potential error.
  bool get suspiciousFromDefined => allGenerationSettings
      .any((element) => element.from.isNotEmpty && element.generate == false);

  /// Converts a [Config] to a map.
  Map<dynamic, dynamic> toJson() => _$ConfigToJson(this);

  @override
  List<Object?> get props => [
        fileId,
        packageName,
        packageDescription,
        dropUnresolved,
        stylesFromLibrary,
        colors,
        typography,
        strings,
        bools,
        numbers,
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
    this.generate = true,
    this.from = const <String>[],
  });

  /// Initializes a [GenerationSettings] from a json map.
  factory GenerationSettings.fromJson(Map<dynamic, dynamic> json) =>
      _$GenerationSettingsFromJson(json);

  /// Whether or not to generate the token, defaults to true.
  final bool generate;

  /// The paths to generate from, defaults to empty which means all paths.
  final Iterable<String> from;

  /// Converts a [GenerationSettings] to a map.
  Map<dynamic, dynamic> toJson() => _$GenerationSettingsToJson(this);

  @override
  List<Object?> get props => [generate, ...from];
}

/// {@template typography_generation_settings}
/// Settings for generating typography tokens. This includes whether or not to
/// generate the token, which paths to generate from and whether or not to use
/// google fonts.
/// {@endtemplate}
@JsonSerializable(anyMap: true, checked: true)
class TypographyGenerationSettings extends GenerationSettings {
  /// {@macro typography_generation_settings}
  const TypographyGenerationSettings({
    super.generate,
    super.from,
    this.useGoogleFonts = true,
  });

  /// Initializes a [TypographyGenerationSettings] from a json map.
  factory TypographyGenerationSettings.fromJson(Map<dynamic, dynamic> json) =>
      _$TypographyGenerationSettingsFromJson(json);

  /// Whether to use google fonts for obtaining the font families, defaults to
  /// true.
  final bool useGoogleFonts;

  /// Converts a [TypographyGenerationSettings] to a map.
  @override
  Map<dynamic, dynamic> toJson() => _$TypographyGenerationSettingsToJson(this);

  @override
  List<Object?> get props => [...super.props, useGoogleFonts];
}
