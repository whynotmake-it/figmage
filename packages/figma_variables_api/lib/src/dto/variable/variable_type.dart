import 'package:json_annotation/json_annotation.dart';

enum VariableType {
  /// A string variable
  @JsonValue('STRING')
  string,

  /// A number variable
  @JsonValue('FLOAT')
  float,

  /// A color variable
  @JsonValue('COLOR')
  color,

  /// A boolean variable
  @JsonValue('BOOLEAN')
  boolean,
}
