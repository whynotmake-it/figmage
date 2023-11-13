import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.freezed.dart';

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
@freezed
class Config with _$Config {
  /// {@macro config}
  const factory Config({
    /// figma file ID.
    required String fileId,

    /// The name of the generated dart package, e.g. figmage_example.
    required String packageName,

    /// The description of the generated dart package.
    @Default('') String packageDescription,

    /// The directory to generate the package in, relative to the config file.
    ///
    /// Defaults to the current directory.
    @Default('.') String packageDir,

    /// Color generation settings, defaults to generating color tokens from
    /// all paths.
    @Default(GenerationSettings()) GenerationSettings colors,

    /// Typography generation settings, defaults to generating typography tokens
    /// from all paths.
    @Default(GenerationSettings()) GenerationSettings typography,

    /// String generation settings, defaults to generating string tokens from
    /// all paths.
    @Default(GenerationSettings()) GenerationSettings strings,

    /// Boolean generation settings, defaults to generating boolean tokens from
    /// all paths.
    @Default(GenerationSettings()) GenerationSettings bools,

    /// Spacers generation settings, defaults to not generating spacers.
    @Default(GenerationSettings(generate: false)) GenerationSettings spacers,

    /// Paddings generation settings, defaults to not generating paddings.
    @Default(GenerationSettings(generate: false)) GenerationSettings paddings,

    /// Borders generation settings, defaults to not generating borders.
    @Default(GenerationSettings(generate: false)) GenerationSettings radii,
  }) = _Config;

  const Config._();
}

/// {@template generation_settings}
/// Settings for generating a type of token. This includes whether or not to
/// generate the token and which paths to generate from.
/// {@endtemplate}
@freezed
sealed class GenerationSettings with _$Config {
  /// {@macro generation_settings}
  const factory GenerationSettings({
    /// Whether or not to generate the token, defaults to true.
    @Default(true) bool generate,

    /// The paths to generate from, defaults to empty which means all paths.
    @Default(<String>[]) Iterable<String> from,
  }) = _GenerationSettings;

  const GenerationSettings._();
}
