// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_styles_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FileStylesResponseCWProxy {
  FileStylesResponse name(String? name);

  FileStylesResponse role(String? role);

  FileStylesResponse lastModified(DateTime? lastModified);

  FileStylesResponse thumbnailUrl(String? thumbnailUrl);

  FileStylesResponse version(String? version);

  FileStylesResponse schemaVersion(int? schemaVersion);

  FileStylesResponse styles(Map<String, Style>? styles);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FileStylesResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FileStylesResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  FileStylesResponse call({
    String? name,
    String? role,
    DateTime? lastModified,
    String? thumbnailUrl,
    String? version,
    int? schemaVersion,
    Map<String, Style>? styles,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFileStylesResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFileStylesResponse.copyWith.fieldName(...)`
class _$FileStylesResponseCWProxyImpl implements _$FileStylesResponseCWProxy {
  const _$FileStylesResponseCWProxyImpl(this._value);

  final FileStylesResponse _value;

  @override
  FileStylesResponse name(String? name) => this(name: name);

  @override
  FileStylesResponse role(String? role) => this(role: role);

  @override
  FileStylesResponse lastModified(DateTime? lastModified) =>
      this(lastModified: lastModified);

  @override
  FileStylesResponse thumbnailUrl(String? thumbnailUrl) =>
      this(thumbnailUrl: thumbnailUrl);

  @override
  FileStylesResponse version(String? version) => this(version: version);

  @override
  FileStylesResponse schemaVersion(int? schemaVersion) =>
      this(schemaVersion: schemaVersion);

  @override
  FileStylesResponse styles(Map<String, Style>? styles) => this(styles: styles);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FileStylesResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FileStylesResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  FileStylesResponse call({
    Object? name = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? lastModified = const $CopyWithPlaceholder(),
    Object? thumbnailUrl = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? schemaVersion = const $CopyWithPlaceholder(),
    Object? styles = const $CopyWithPlaceholder(),
  }) {
    return FileStylesResponse(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as String?,
      lastModified: lastModified == const $CopyWithPlaceholder()
          ? _value.lastModified
          // ignore: cast_nullable_to_non_nullable
          : lastModified as DateTime?,
      thumbnailUrl: thumbnailUrl == const $CopyWithPlaceholder()
          ? _value.thumbnailUrl
          // ignore: cast_nullable_to_non_nullable
          : thumbnailUrl as String?,
      version: version == const $CopyWithPlaceholder()
          ? _value.version
          // ignore: cast_nullable_to_non_nullable
          : version as String?,
      schemaVersion: schemaVersion == const $CopyWithPlaceholder()
          ? _value.schemaVersion
          // ignore: cast_nullable_to_non_nullable
          : schemaVersion as int?,
      styles: styles == const $CopyWithPlaceholder()
          ? _value.styles
          // ignore: cast_nullable_to_non_nullable
          : styles as Map<String, Style>?,
    );
  }
}

extension $FileStylesResponseCopyWith on FileStylesResponse {
  /// Returns a callable class that can be used as follows: `instanceOfFileStylesResponse.copyWith(...)` or like so:`instanceOfFileStylesResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FileStylesResponseCWProxy get copyWith =>
      _$FileStylesResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileStylesResponse _$FileStylesResponseFromJson(Map<String, dynamic> json) =>
    FileStylesResponse(
      name: json['name'] as String?,
      role: json['role'] as String?,
      lastModified: json['lastModified'] == null
          ? null
          : DateTime.parse(json['lastModified'] as String),
      thumbnailUrl: json['thumbnailUrl'] as String?,
      version: json['version'] as String?,
      schemaVersion: (json['schemaVersion'] as num?)?.toInt(),
      styles: (json['styles'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Style.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$FileStylesResponseToJson(FileStylesResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'role': instance.role,
      'lastModified': instance.lastModified?.toIso8601String(),
      'thumbnailUrl': instance.thumbnailUrl,
      'version': instance.version,
      'schemaVersion': instance.schemaVersion,
      'styles': instance.styles,
    };
