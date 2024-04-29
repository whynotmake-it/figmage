// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nodes_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NodesResponseCWProxy {
  NodesResponse name(String? name);

  NodesResponse role(String? role);

  NodesResponse lastModified(DateTime? lastModified);

  NodesResponse thumbnailUrl(String? thumbnailUrl);

  NodesResponse err(String? err);

  NodesResponse nodes(Map<String, NodeContent>? nodes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NodesResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NodesResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  NodesResponse call({
    String? name,
    String? role,
    DateTime? lastModified,
    String? thumbnailUrl,
    String? err,
    Map<String, NodeContent>? nodes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNodesResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNodesResponse.copyWith.fieldName(...)`
class _$NodesResponseCWProxyImpl implements _$NodesResponseCWProxy {
  const _$NodesResponseCWProxyImpl(this._value);

  final NodesResponse _value;

  @override
  NodesResponse name(String? name) => this(name: name);

  @override
  NodesResponse role(String? role) => this(role: role);

  @override
  NodesResponse lastModified(DateTime? lastModified) =>
      this(lastModified: lastModified);

  @override
  NodesResponse thumbnailUrl(String? thumbnailUrl) =>
      this(thumbnailUrl: thumbnailUrl);

  @override
  NodesResponse err(String? err) => this(err: err);

  @override
  NodesResponse nodes(Map<String, NodeContent>? nodes) => this(nodes: nodes);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NodesResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NodesResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  NodesResponse call({
    Object? name = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? lastModified = const $CopyWithPlaceholder(),
    Object? thumbnailUrl = const $CopyWithPlaceholder(),
    Object? err = const $CopyWithPlaceholder(),
    Object? nodes = const $CopyWithPlaceholder(),
  }) {
    return NodesResponse(
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
      err: err == const $CopyWithPlaceholder()
          ? _value.err
          // ignore: cast_nullable_to_non_nullable
          : err as String?,
      nodes: nodes == const $CopyWithPlaceholder()
          ? _value.nodes
          // ignore: cast_nullable_to_non_nullable
          : nodes as Map<String, NodeContent>?,
    );
  }
}

extension $NodesResponseCopyWith on NodesResponse {
  /// Returns a callable class that can be used as follows: `instanceOfNodesResponse.copyWith(...)` or like so:`instanceOfNodesResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NodesResponseCWProxy get copyWith => _$NodesResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodesResponse _$NodesResponseFromJson(Map<String, dynamic> json) =>
    NodesResponse(
      name: json['name'] as String?,
      role: json['role'] as String?,
      lastModified: json['lastModified'] == null
          ? null
          : DateTime.parse(json['lastModified'] as String),
      thumbnailUrl: json['thumbnailUrl'] as String?,
      err: json['err'] as String?,
      nodes: (json['nodes'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, NodeContent.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$NodesResponseToJson(NodesResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'role': instance.role,
      'lastModified': instance.lastModified?.toIso8601String(),
      'thumbnailUrl': instance.thumbnailUrl,
      'err': instance.err,
      'nodes': instance.nodes,
    };
