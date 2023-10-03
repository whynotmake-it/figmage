// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable_mode.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VariableModeCWProxy {
  VariableMode modeId(String modeId);

  VariableMode name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariableMode(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariableMode(...).copyWith(id: 12, name: "My name")
  /// ````
  VariableMode call({
    String? modeId,
    String? name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVariableMode.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVariableMode.copyWith.fieldName(...)`
class _$VariableModeCWProxyImpl implements _$VariableModeCWProxy {
  const _$VariableModeCWProxyImpl(this._value);

  final VariableMode _value;

  @override
  VariableMode modeId(String modeId) => this(modeId: modeId);

  @override
  VariableMode name(String name) => this(name: name);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariableMode(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariableMode(...).copyWith(id: 12, name: "My name")
  /// ````
  VariableMode call({
    Object? modeId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return VariableMode(
      modeId: modeId == const $CopyWithPlaceholder() || modeId == null
          ? _value.modeId
          // ignore: cast_nullable_to_non_nullable
          : modeId as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $VariableModeCopyWith on VariableMode {
  /// Returns a callable class that can be used as follows: `instanceOfVariableMode.copyWith(...)` or like so:`instanceOfVariableMode.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VariableModeCWProxy get copyWith => _$VariableModeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariableMode _$VariableModeFromJson(Map<String, dynamic> json) => VariableMode(
      modeId: json['modeId'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$VariableModeToJson(VariableMode instance) =>
    <String, dynamic>{
      'modeId': instance.modeId,
      'name': instance.name,
    };
