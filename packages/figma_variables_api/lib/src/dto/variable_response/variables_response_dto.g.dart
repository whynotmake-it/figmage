// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variables_response_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VariablesResponseDtoCWProxy {
  VariablesResponseDto status(int status);

  VariablesResponseDto error(bool error);

  VariablesResponseDto meta(VariablesMetaDto meta);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariablesResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariablesResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  VariablesResponseDto call({
    int status,
    bool error,
    VariablesMetaDto meta,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVariablesResponseDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVariablesResponseDto.copyWith.fieldName(...)`
class _$VariablesResponseDtoCWProxyImpl
    implements _$VariablesResponseDtoCWProxy {
  const _$VariablesResponseDtoCWProxyImpl(this._value);

  final VariablesResponseDto _value;

  @override
  VariablesResponseDto status(int status) => this(status: status);

  @override
  VariablesResponseDto error(bool error) => this(error: error);

  @override
  VariablesResponseDto meta(VariablesMetaDto meta) => this(meta: meta);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariablesResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariablesResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  VariablesResponseDto call({
    Object? status = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return VariablesResponseDto(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as int,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as bool,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as VariablesMetaDto,
    );
  }
}

extension $VariablesResponseDtoCopyWith on VariablesResponseDto {
  /// Returns a callable class that can be used as follows: `instanceOfVariablesResponseDto.copyWith(...)` or like so:`instanceOfVariablesResponseDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VariablesResponseDtoCWProxy get copyWith =>
      _$VariablesResponseDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariablesResponseDto _$VariablesResponseDtoFromJson(
        Map<String, dynamic> json) =>
    VariablesResponseDto(
      status: (json['status'] as num).toInt(),
      error: json['error'] as bool,
      meta: VariablesMetaDto.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VariablesResponseDtoToJson(
        VariablesResponseDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'meta': instance.meta.toJson(),
    };
