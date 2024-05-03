// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_content.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NodeContentCWProxy {
  NodeContent name(String? name);

  NodeContent role(String? role);

  NodeContent lastModified(DateTime? lastModified);

  NodeContent thumbnailUrl(String? thumbnailUrl);

  NodeContent version(String? version);

  NodeContent document(Node? document);

  NodeContent components(Map<String, Component>? components);

  NodeContent componentSets(Map<String, ComponentSet>? componentSets);

  NodeContent schemaVersion(int? schemaVersion);

  NodeContent styles(Map<String, Style>? styles);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NodeContent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NodeContent(...).copyWith(id: 12, name: "My name")
  /// ````
  NodeContent call({
    String? name,
    String? role,
    DateTime? lastModified,
    String? thumbnailUrl,
    String? version,
    Node? document,
    Map<String, Component>? components,
    Map<String, ComponentSet>? componentSets,
    int? schemaVersion,
    Map<String, Style>? styles,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNodeContent.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNodeContent.copyWith.fieldName(...)`
class _$NodeContentCWProxyImpl implements _$NodeContentCWProxy {
  const _$NodeContentCWProxyImpl(this._value);

  final NodeContent _value;

  @override
  NodeContent name(String? name) => this(name: name);

  @override
  NodeContent role(String? role) => this(role: role);

  @override
  NodeContent lastModified(DateTime? lastModified) =>
      this(lastModified: lastModified);

  @override
  NodeContent thumbnailUrl(String? thumbnailUrl) =>
      this(thumbnailUrl: thumbnailUrl);

  @override
  NodeContent version(String? version) => this(version: version);

  @override
  NodeContent document(Node? document) => this(document: document);

  @override
  NodeContent components(Map<String, Component>? components) =>
      this(components: components);

  @override
  NodeContent componentSets(Map<String, ComponentSet>? componentSets) =>
      this(componentSets: componentSets);

  @override
  NodeContent schemaVersion(int? schemaVersion) =>
      this(schemaVersion: schemaVersion);

  @override
  NodeContent styles(Map<String, Style>? styles) => this(styles: styles);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NodeContent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NodeContent(...).copyWith(id: 12, name: "My name")
  /// ````
  NodeContent call({
    Object? name = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? lastModified = const $CopyWithPlaceholder(),
    Object? thumbnailUrl = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? document = const $CopyWithPlaceholder(),
    Object? components = const $CopyWithPlaceholder(),
    Object? componentSets = const $CopyWithPlaceholder(),
    Object? schemaVersion = const $CopyWithPlaceholder(),
    Object? styles = const $CopyWithPlaceholder(),
  }) {
    return NodeContent(
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
      document: document == const $CopyWithPlaceholder()
          ? _value.document
          // ignore: cast_nullable_to_non_nullable
          : document as Node?,
      components: components == const $CopyWithPlaceholder()
          ? _value.components
          // ignore: cast_nullable_to_non_nullable
          : components as Map<String, Component>?,
      componentSets: componentSets == const $CopyWithPlaceholder()
          ? _value.componentSets
          // ignore: cast_nullable_to_non_nullable
          : componentSets as Map<String, ComponentSet>?,
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

extension $NodeContentCopyWith on NodeContent {
  /// Returns a callable class that can be used as follows: `instanceOfNodeContent.copyWith(...)` or like so:`instanceOfNodeContent.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NodeContentCWProxy get copyWith => _$NodeContentCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeContent _$NodeContentFromJson(Map<String, dynamic> json) => NodeContent(
      name: json['name'] as String?,
      role: json['role'] as String?,
      lastModified: json['lastModified'] == null
          ? null
          : DateTime.parse(json['lastModified'] as String),
      thumbnailUrl: json['thumbnailUrl'] as String?,
      version: json['version'] as String?,
      document: const NodeJsonConverter().fromJson(json['document']),
      components: (json['components'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Component.fromJson(e as Map<String, dynamic>)),
      ),
      componentSets: (json['componentSets'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, ComponentSet.fromJson(e as Map<String, dynamic>)),
      ),
      schemaVersion: (json['schemaVersion'] as num?)?.toInt(),
      styles: (json['styles'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Style.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$NodeContentToJson(NodeContent instance) =>
    <String, dynamic>{
      'name': instance.name,
      'role': instance.role,
      'lastModified': instance.lastModified?.toIso8601String(),
      'thumbnailUrl': instance.thumbnailUrl,
      'version': instance.version,
      'document': const NodeJsonConverter().toJson(instance.document),
      'components': instance.components,
      'componentSets': instance.componentSets,
      'schemaVersion': instance.schemaVersion,
      'styles': instance.styles,
    };
