// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable_mode_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VariableModeDtoCWProxy {
  VariableModeDto modeId(String modeId);

  VariableModeDto name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariableModeDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariableModeDto(...).copyWith(id: 12, name: "My name")
  /// ````
  VariableModeDto call({
    String modeId,
    String name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVariableModeDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVariableModeDto.copyWith.fieldName(...)`
class _$VariableModeDtoCWProxyImpl implements _$VariableModeDtoCWProxy {
  const _$VariableModeDtoCWProxyImpl(this._value);

  final VariableModeDto _value;

  @override
  VariableModeDto modeId(String modeId) => this(modeId: modeId);

  @override
  VariableModeDto name(String name) => this(name: name);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariableModeDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariableModeDto(...).copyWith(id: 12, name: "My name")
  /// ````
  VariableModeDto call({
    Object? modeId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return VariableModeDto(
      modeId: modeId == const $CopyWithPlaceholder()
          ? _value.modeId
          // ignore: cast_nullable_to_non_nullable
          : modeId as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $VariableModeDtoCopyWith on VariableModeDto {
  /// Returns a callable class that can be used as follows: `instanceOfVariableModeDto.copyWith(...)` or like so:`instanceOfVariableModeDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VariableModeDtoCWProxy get copyWith => _$VariableModeDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariableModeDto _$VariableModeDtoFromJson(Map<String, dynamic> json) =>
    VariableModeDto(
      modeId: json['modeId'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$VariableModeDtoToJson(VariableModeDto instance) =>
    <String, dynamic>{
      'modeId': instance.modeId,
      'name': instance.name,
    };
