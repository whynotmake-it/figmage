import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.freezed.dart';

/// {@template config}
/// A configuration for the figmage forge command.
/// {@endtemplate}
@freezed
class Config with _$Config {
  /// {@macro config}
  const factory Config({
    /// figma file ID.
    required String fileId,

    /// Include color generation.
    required bool generateColors,

    /// Include text style generation.
    required bool generateTextStyles,

    /// Include String generation
    required bool generateStrings,

    /// Include bool generation
    required bool generateBools,

    /// Include spacers generation
    required bool generateSpacers,
  }) = _Config;

  const Config._();
}
