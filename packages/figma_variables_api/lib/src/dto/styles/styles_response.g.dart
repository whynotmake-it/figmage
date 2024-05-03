// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'styles_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StylesResponseCWProxy {
  StylesResponse status(int? status);

  StylesResponse error(bool? error);

  StylesResponse meta(StylesResponseMeta? meta);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StylesResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StylesResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  StylesResponse call({
    int? status,
    bool? error,
    StylesResponseMeta? meta,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStylesResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStylesResponse.copyWith.fieldName(...)`
class _$StylesResponseCWProxyImpl implements _$StylesResponseCWProxy {
  const _$StylesResponseCWProxyImpl(this._value);

  final StylesResponse _value;

  @override
  StylesResponse status(int? status) => this(status: status);

  @override
  StylesResponse error(bool? error) => this(error: error);

  @override
  StylesResponse meta(StylesResponseMeta? meta) => this(meta: meta);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StylesResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StylesResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  StylesResponse call({
    Object? status = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return StylesResponse(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as int?,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as bool?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as StylesResponseMeta?,
    );
  }
}

extension $StylesResponseCopyWith on StylesResponse {
  /// Returns a callable class that can be used as follows: `instanceOfStylesResponse.copyWith(...)` or like so:`instanceOfStylesResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StylesResponseCWProxy get copyWith => _$StylesResponseCWProxyImpl(this);
}

abstract class _$StylesResponseMetaCWProxy {
  StylesResponseMeta styles(List<Style> styles);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StylesResponseMeta(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StylesResponseMeta(...).copyWith(id: 12, name: "My name")
  /// ````
  StylesResponseMeta call({
    List<Style>? styles,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStylesResponseMeta.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStylesResponseMeta.copyWith.fieldName(...)`
class _$StylesResponseMetaCWProxyImpl implements _$StylesResponseMetaCWProxy {
  const _$StylesResponseMetaCWProxyImpl(this._value);

  final StylesResponseMeta _value;

  @override
  StylesResponseMeta styles(List<Style> styles) => this(styles: styles);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StylesResponseMeta(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StylesResponseMeta(...).copyWith(id: 12, name: "My name")
  /// ````
  StylesResponseMeta call({
    Object? styles = const $CopyWithPlaceholder(),
  }) {
    return StylesResponseMeta(
      styles: styles == const $CopyWithPlaceholder() || styles == null
          ? _value.styles
          // ignore: cast_nullable_to_non_nullable
          : styles as List<Style>,
    );
  }
}

extension $StylesResponseMetaCopyWith on StylesResponseMeta {
  /// Returns a callable class that can be used as follows: `instanceOfStylesResponseMeta.copyWith(...)` or like so:`instanceOfStylesResponseMeta.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StylesResponseMetaCWProxy get copyWith =>
      _$StylesResponseMetaCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StylesResponse _$StylesResponseFromJson(Map<String, dynamic> json) =>
    StylesResponse(
      status: json['status'] as int?,
      error: json['error'] as bool?,
      meta: json['meta'] == null
          ? null
          : StylesResponseMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StylesResponseToJson(StylesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'meta': instance.meta,
    };

StylesResponseMeta _$StylesResponseMetaFromJson(Map<String, dynamic> json) =>
    StylesResponseMeta(
      styles: (json['styles'] as List<dynamic>)
          .map((e) => Style.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StylesResponseMetaToJson(StylesResponseMeta instance) =>
    <String, dynamic>{
      'styles': instance.styles,
    };
