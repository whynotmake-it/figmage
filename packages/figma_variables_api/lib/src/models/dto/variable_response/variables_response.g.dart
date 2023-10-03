// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variables_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VariablesResponseCWProxy {
  VariablesResponse status(int status);

  VariablesResponse error(bool error);

  VariablesResponse meta(VariablesMeta meta);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariablesResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariablesResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  VariablesResponse call({
    int? status,
    bool? error,
    VariablesMeta? meta,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVariablesResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVariablesResponse.copyWith.fieldName(...)`
class _$VariablesResponseCWProxyImpl implements _$VariablesResponseCWProxy {
  const _$VariablesResponseCWProxyImpl(this._value);

  final VariablesResponse _value;

  @override
  VariablesResponse status(int status) => this(status: status);

  @override
  VariablesResponse error(bool error) => this(error: error);

  @override
  VariablesResponse meta(VariablesMeta meta) => this(meta: meta);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariablesResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariablesResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  VariablesResponse call({
    Object? status = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return VariablesResponse(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as int,
      error: error == const $CopyWithPlaceholder() || error == null
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as bool,
      meta: meta == const $CopyWithPlaceholder() || meta == null
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as VariablesMeta,
    );
  }
}

extension $VariablesResponseCopyWith on VariablesResponse {
  /// Returns a callable class that can be used as follows: `instanceOfVariablesResponse.copyWith(...)` or like so:`instanceOfVariablesResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VariablesResponseCWProxy get copyWith =>
      _$VariablesResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariablesResponse _$VariablesResponseFromJson(Map<String, dynamic> json) =>
    VariablesResponse(
      status: json['status'] as int,
      error: json['error'] as bool,
      meta: VariablesMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VariablesResponseToJson(VariablesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'meta': instance.meta,
    };
