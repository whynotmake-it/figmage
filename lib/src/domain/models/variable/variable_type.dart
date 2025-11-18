import 'package:figma/figma.dart';

/// Represents the type of a Figma variable.
enum VariableType {
  /// String variable type.
  string,
  /// Float/number variable type.
  float,
  /// Color variable type.
  color,
  /// Boolean variable type.
  boolean,
}

/// Extension methods for [VariableType].
extension VariableTypeX on VariableType {
  /// Converts a Figma [VariableResolvedDataType] to a [VariableType].
  static VariableType fromResolvedDataType(
    VariableResolvedDataType resolvedType,
  ) {
    return switch (resolvedType) {
      VariableResolvedDataType.string => VariableType.string,
      VariableResolvedDataType.float => VariableType.float,
      VariableResolvedDataType.color => VariableType.color,
      VariableResolvedDataType.boolean => VariableType.boolean,
    };
  }
}
