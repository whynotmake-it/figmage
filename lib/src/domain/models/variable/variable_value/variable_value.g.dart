// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BooleanValueImpl _$$BooleanValueImplFromJson(Map<String, dynamic> json) =>
    _$BooleanValueImpl(
      json['value'] as bool,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$BooleanValueImplToJson(_$BooleanValueImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$NumberValueImpl _$$NumberValueImplFromJson(Map<String, dynamic> json) =>
    _$NumberValueImpl(
      (json['value'] as num).toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NumberValueImplToJson(_$NumberValueImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$StringValueImpl _$$StringValueImplFromJson(Map<String, dynamic> json) =>
    _$StringValueImpl(
      json['value'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$StringValueImplToJson(_$StringValueImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$ColorValueImpl _$$ColorValueImplFromJson(Map<String, dynamic> json) =>
    _$ColorValueImpl(
      json['value'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ColorValueImplToJson(_$ColorValueImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$VariableAliasValueImpl _$$VariableAliasValueImplFromJson(
        Map<String, dynamic> json) =>
    _$VariableAliasValueImpl(
      VariableAlias.fromJson(json['value'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$VariableAliasValueImplToJson(
        _$VariableAliasValueImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };
