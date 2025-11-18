import 'package:figma/figma.dart';

enum VariableType {
  string,
  float,
  color,
  boolean,
}

extension VariableTypeX on VariableType {
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
