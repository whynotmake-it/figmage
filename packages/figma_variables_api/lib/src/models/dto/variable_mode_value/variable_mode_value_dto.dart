import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'variable_mode_value_dto.g.dart';

sealed class VariableModeValueDto extends Equatable {
  const VariableModeValueDto();
  factory VariableModeValueDto.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('r') &&
        json.containsKey('g') &&
        json.containsKey('b') &&
        json.containsKey('a')) {
      return VariableModeColorValueDto.fromJson(json);
    }

    // Check if it's an "alias" JSON format
    else if (json.containsKey('type') && json['type'] == 'VARIABLE_ALIAS') {
      return VariableModeAliasDto.fromJson(json);
    }

    // Check if it's a "stringValue" JSON format
    else if (json.length == 1 && json.values.first is String) {
      return VariableModeStringValueDto.fromJson(json);
    }

    // Check if it's a "booleanValue" JSON format
    else if (json.length == 1 && json.values.first is bool) {
      return VariableModeBooleanValueDto.fromJson(json);
    }

    // Check if it's a "numberValue" JSON format
    else if (json.length == 1 && json.values.first is num) {
      return VariableModeNumberValueDto.fromJson(json);
    } else {
      throw Exception('Could not identify the following mode value: $json');
    }
  }

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
@CopyWith()
class VariableModeAliasDto extends VariableModeValueDto {
  VariableModeAliasDto({
    required this.type,
    required this.id,
  });

  factory VariableModeAliasDto.fromJson(Map<String, dynamic> json) =>
      _$VariableModeAliasDtoFromJson(json);

  final String type;
  final String id;

  @override
  List<Object?> get props => [type, id];
}

@JsonSerializable()
@CopyWith()
class VariableModeStringValueDto extends VariableModeValueDto {
  VariableModeStringValueDto({
    required this.value,
  });

  factory VariableModeStringValueDto.fromJson(Map<String, dynamic> json) =>
      _$VariableModeStringValueDtoFromJson(json);

  final String value;

  @override
  List<Object?> get props => [value];
}

@JsonSerializable()
@CopyWith()
class VariableModeNumberValueDto extends VariableModeValueDto {
  VariableModeNumberValueDto({
    required this.value,
  });

  factory VariableModeNumberValueDto.fromJson(Map<String, dynamic> json) =>
      _$VariableModeNumberValueDtoFromJson(json);

  final double value;

  @override
  List<Object?> get props => [value];
}

@JsonSerializable()
@CopyWith()
class VariableModeColorValueDto extends VariableModeValueDto {
  VariableModeColorValueDto({
    required this.value,
  });

  factory VariableModeColorValueDto.fromJson(Map<String, dynamic> json) =>
      _$VariableModeColorValueDtoFromJson(json);

  final int value;

  @override
  List<Object?> get props => [value];
}

@JsonSerializable()
@CopyWith()
class VariableModeBooleanValueDto extends VariableModeValueDto {
  VariableModeBooleanValueDto({
    required this.value,
  });

  factory VariableModeBooleanValueDto.fromJson(Map<String, dynamic> json) =>
      _$VariableModeBooleanValueDtoFromJson(json);

  final bool value;

  @override
  List<Object?> get props => [value];
}
