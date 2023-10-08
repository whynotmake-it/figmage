import 'package:figmage/src/domain/models/variable/variable_value/variable_alias/variable_alias.dart';
import 'package:figmage/src/domain/models/variable/variable_value/variable_value.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'variable.freezed.dart';

part 'variable.g.dart';

@Freezed(toJson: true, fromJson: true)
class Variable with _$Variable {
  factory Variable.boolean({
    required String id,
    required String name,
    required String key,
    required String variableCollectionId,
    @JsonKey(fromJson: _boolMap)
    required Map<String, VariableValue> valuesByMode,
  }) = BooleanVariable;

  factory Variable.float({
    required String id,
    required String name,
    required String key,
    required String variableCollectionId,
    @JsonKey(fromJson: _floatMap)
    required Map<String, VariableValue> valuesByMode,
  }) = FloatVariable;

  factory Variable.color({
    required String id,
    required String name,
    required String key,
    required String variableCollectionId,
    @JsonKey(fromJson: _colorMap)
    required Map<String, VariableValue> valuesByMode,
  }) = ColorVariable;

  factory Variable.string({
    required String id,
    required String name,
    required String key,
    required String variableCollectionId,
    @JsonKey(fromJson: _stringMap)
    required Map<String, VariableValue> valuesByMode,
  }) = StringVariable;

  factory Variable.fromJson(Map<String, dynamic> json) {
    switch (json['resolvedType'] as String) {
      case 'BOOLEAN':
        return BooleanVariable.fromJson(json);
      case 'FLOAT':
        return FloatVariable.fromJson(json);
      case 'COLOR':
        return ColorVariable.fromJson(json);
      case 'STRING':
        return StringVariable.fromJson(json);
      default:
        throw Exception('Invalid resolvedType');
    }
  }
}

// Conversion function for Color
Map<String, VariableValue> _colorMap(Map<String, dynamic> rgbaJsonMap) {
  final colorMap = <String, VariableValue>{};
  rgbaJsonMap.forEach((key, value) {
    if (value.containsKey('r') &&
        value.containsKey('g') &&
        value.containsKey('b') &&
        value.containsKey('a')) {
      colorMap[key] = VariableValue.color(_rgbaToColor(value));
    } else {
      colorMap[key] =
          VariableValue.variableAlias(VariableAlias.fromJson(value));
    }
  });
  return colorMap;
}

// Conversion function for String
Map<String, VariableValue> _stringMap(Map<String, dynamic> jsonMap) {
  final stringMap = <String, VariableValue>{};
  jsonMap.forEach((key, value) {
    if (value is String) {
      stringMap[key] = VariableValue.string(value);
    } else {
      stringMap[key] =
          VariableValue.variableAlias(VariableAlias.fromJson(value));
    }
  });
  return stringMap;
}

// Conversion function for Bool
Map<String, VariableValue> _boolMap(Map<String, dynamic> jsonMap) {
  final boolMap = <String, VariableValue>{};
  jsonMap.forEach((key, value) {
    if (value is bool) {
      boolMap[key] = VariableValue.boolean(value);
    } else {
      boolMap[key] = VariableValue.variableAlias(VariableAlias.fromJson(value));
    }
  });
  return boolMap;
}

// Conversion function for Float
Map<String, VariableValue> _floatMap(Map<String, dynamic> jsonMap) {
  final floatMap = <String, VariableValue>{};
  jsonMap.forEach((key, value) {
    if (value is num) {
      floatMap[key] = VariableValue.number(value.toDouble());
    } else {
      floatMap[key] =
          VariableValue.variableAlias(VariableAlias.fromJson(value));
    }
  });
  return floatMap;
}

int _rgbaToColor(Map<String, dynamic>? rgbaJson) {
  if (rgbaJson == null) {
    throw ArgumentError('JSON object cannot be null');
  }

  for (final key in ['r', 'g', 'b', 'a']) {
    if (!rgbaJson.containsKey(key)) {
      throw FormatException('Missing key in JSON object: $key');
    }

    final value = rgbaJson[key];
    if (value is! num || value < 0 || value > 1) {
      throw FormatException(
        'Invalid value for key $key: $value (expected a number between 0 and 1)',
      );
    }
  }

  final int red = (rgbaJson['r'] * 255).round();
  final int green = (rgbaJson['g'] * 255).round();
  final int blue = (rgbaJson['b'] * 255).round();
  final int alpha = (rgbaJson['a'] * 255).round();

  return (alpha << 24) | (red << 16) | (green << 8) | blue;
}
