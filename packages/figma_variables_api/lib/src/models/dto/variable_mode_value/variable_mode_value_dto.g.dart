// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable_mode_value_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariableModeBooleanDto _$VariableModeBooleanDtoFromJson(
        Map<String, dynamic> json) =>
    VariableModeBooleanDto(
      value: json['value'] as bool,
    );

Map<String, dynamic> _$VariableModeBooleanDtoToJson(
        VariableModeBooleanDto instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

VariableModeNumberDto _$VariableModeNumberDtoFromJson(
        Map<String, dynamic> json) =>
    VariableModeNumberDto(
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$VariableModeNumberDtoToJson(
        VariableModeNumberDto instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

VariableModeStringDto _$VariableModeStringDtoFromJson(
        Map<String, dynamic> json) =>
    VariableModeStringDto(
      value: json['value'] as String,
    );

Map<String, dynamic> _$VariableModeStringDtoToJson(
        VariableModeStringDto instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

VariableModeColorDto _$VariableModeColorDtoFromJson(
        Map<String, dynamic> json) =>
    VariableModeColorDto(
      r: (json['r'] as num).toDouble(),
      g: (json['g'] as num).toDouble(),
      b: (json['b'] as num).toDouble(),
      a: (json['a'] as num).toDouble(),
    );

Map<String, dynamic> _$VariableModeColorDtoToJson(
        VariableModeColorDto instance) =>
    <String, dynamic>{
      'r': instance.r,
      'g': instance.g,
      'b': instance.b,
      'a': instance.a,
    };

VariableModeAliasDto _$VariableModeAliasDtoFromJson(
        Map<String, dynamic> json) =>
    VariableModeAliasDto(
      type: json['type'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$VariableModeAliasDtoToJson(
        VariableModeAliasDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
    };
