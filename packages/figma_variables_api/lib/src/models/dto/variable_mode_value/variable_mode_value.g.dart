// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable_mode_value.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VariableModeValueCWProxy {
  VariableModeValue type(String type);

  VariableModeValue id(String id);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariableModeValue(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariableModeValue(...).copyWith(id: 12, name: "My name")
  /// ````
  VariableModeValue call({
    String? type,
    String? id,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVariableModeValue.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVariableModeValue.copyWith.fieldName(...)`
class _$VariableModeValueCWProxyImpl implements _$VariableModeValueCWProxy {
  const _$VariableModeValueCWProxyImpl(this._value);

  final VariableModeValue _value;

  @override
  VariableModeValue type(String type) => this(type: type);

  @override
  VariableModeValue id(String id) => this(id: id);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariableModeValue(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariableModeValue(...).copyWith(id: 12, name: "My name")
  /// ````
  VariableModeValue call({
    Object? type = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
  }) {
    return VariableModeValue(
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

extension $VariableModeValueCopyWith on VariableModeValue {
  /// Returns a callable class that can be used as follows: `instanceOfVariableModeValue.copyWith(...)` or like so:`instanceOfVariableModeValue.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VariableModeValueCWProxy get copyWith =>
      _$VariableModeValueCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariableModeValue _$VariableModeValueFromJson(Map<String, dynamic> json) =>
    VariableModeValue(
      type: json['type'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$VariableModeValueToJson(VariableModeValue instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
    };
