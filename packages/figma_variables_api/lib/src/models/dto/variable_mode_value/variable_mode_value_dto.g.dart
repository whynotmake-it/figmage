// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable_mode_value_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VariableModeValueDtoCWProxy {
  VariableModeValueDto type(String type);

  VariableModeValueDto id(String id);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariableModeValueDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariableModeValueDto(...).copyWith(id: 12, name: "My name")
  /// ````
  VariableModeValueDto call({
    String? type,
    String? id,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVariableModeValueDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVariableModeValueDto.copyWith.fieldName(...)`
class _$VariableModeValueDtoCWProxyImpl
    implements _$VariableModeValueDtoCWProxy {
  const _$VariableModeValueDtoCWProxyImpl(this._value);

  final VariableModeValueDto _value;

  @override
  VariableModeValueDto type(String type) => this(type: type);

  @override
  VariableModeValueDto id(String id) => this(id: id);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariableModeValueDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariableModeValueDto(...).copyWith(id: 12, name: "My name")
  /// ````
  VariableModeValueDto call({
    Object? type = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
  }) {
    return VariableModeValueDto(
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
    );
  }
}

extension $VariableModeValueDtoCopyWith on VariableModeValueDto {
  /// Returns a callable class that can be used as follows: `instanceOfVariableModeValueDto.copyWith(...)` or like so:`instanceOfVariableModeValueDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VariableModeValueDtoCWProxy get copyWith =>
      _$VariableModeValueDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariableModeValueDto _$VariableModeValueDtoFromJson(
        Map<String, dynamic> json) =>
    VariableModeValueDto(
      type: json['type'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$VariableModeValueDtoToJson(
        VariableModeValueDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
    };
