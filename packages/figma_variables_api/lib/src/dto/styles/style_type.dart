import 'package:json_annotation/json_annotation.dart';

/// The type of style as string enum.
enum StyleType {
  /// A fill style.
  @JsonValue('FILL')
  fill,

  /// A text style.
  @JsonValue('TEXT')
  text,

  /// An effect style.
  @JsonValue('EFFECT')
  effect,

  /// A grid style.
  @JsonValue('GRID')
  grid,
}

/// The type of style as string enum for keys.
enum StyleTypeKey {
  /// A fill style.
  @JsonValue('fill')
  fill,

  /// Multiple fill styles.
  @JsonValue('fills')
  fills,

  /// A stroke style.
  @JsonValue('stroke')
  stroke,

  /// Multiple stroke styles.
  @JsonValue('strokes')
  strokes,

  /// A text style.
  @JsonValue('text')
  text,

  /// An effect style.
  @JsonValue('effect')
  effect,

  /// A grid style.
  @JsonValue('grid')
  grid
}
