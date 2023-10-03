// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable_collection.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VariableCollectionCWProxy {
  VariableCollection defaultModeId(String defaultModeId);

  VariableCollection id(String id);

  VariableCollection name(String name);

  VariableCollection remote(bool remote);

  VariableCollection modes(List<VariableMode> modes);

  VariableCollection key(String key);

  VariableCollection hiddenFromPublishing(bool hiddenFromPublishing);

  VariableCollection variableIds(List<String> variableIds);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariableCollection(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariableCollection(...).copyWith(id: 12, name: "My name")
  /// ````
  VariableCollection call({
    String? defaultModeId,
    String? id,
    String? name,
    bool? remote,
    List<VariableMode>? modes,
    String? key,
    bool? hiddenFromPublishing,
    List<String>? variableIds,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVariableCollection.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVariableCollection.copyWith.fieldName(...)`
class _$VariableCollectionCWProxyImpl implements _$VariableCollectionCWProxy {
  const _$VariableCollectionCWProxyImpl(this._value);

  final VariableCollection _value;

  @override
  VariableCollection defaultModeId(String defaultModeId) =>
      this(defaultModeId: defaultModeId);

  @override
  VariableCollection id(String id) => this(id: id);

  @override
  VariableCollection name(String name) => this(name: name);

  @override
  VariableCollection remote(bool remote) => this(remote: remote);

  @override
  VariableCollection modes(List<VariableMode> modes) => this(modes: modes);

  @override
  VariableCollection key(String key) => this(key: key);

  @override
  VariableCollection hiddenFromPublishing(bool hiddenFromPublishing) =>
      this(hiddenFromPublishing: hiddenFromPublishing);

  @override
  VariableCollection variableIds(List<String> variableIds) =>
      this(variableIds: variableIds);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariableCollection(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariableCollection(...).copyWith(id: 12, name: "My name")
  /// ````
  VariableCollection call({
    Object? defaultModeId = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? remote = const $CopyWithPlaceholder(),
    Object? modes = const $CopyWithPlaceholder(),
    Object? key = const $CopyWithPlaceholder(),
    Object? hiddenFromPublishing = const $CopyWithPlaceholder(),
    Object? variableIds = const $CopyWithPlaceholder(),
  }) {
    return VariableCollection(
      defaultModeId:
          defaultModeId == const $CopyWithPlaceholder() || defaultModeId == null
              ? _value.defaultModeId
              // ignore: cast_nullable_to_non_nullable
              : defaultModeId as String,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      remote: remote == const $CopyWithPlaceholder() || remote == null
          ? _value.remote
          // ignore: cast_nullable_to_non_nullable
          : remote as bool,
      modes: modes == const $CopyWithPlaceholder() || modes == null
          ? _value.modes
          // ignore: cast_nullable_to_non_nullable
          : modes as List<VariableMode>,
      key: key == const $CopyWithPlaceholder() || key == null
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as String,
      hiddenFromPublishing:
          hiddenFromPublishing == const $CopyWithPlaceholder() ||
                  hiddenFromPublishing == null
              ? _value.hiddenFromPublishing
              // ignore: cast_nullable_to_non_nullable
              : hiddenFromPublishing as bool,
      variableIds:
          variableIds == const $CopyWithPlaceholder() || variableIds == null
              ? _value.variableIds
              // ignore: cast_nullable_to_non_nullable
              : variableIds as List<String>,
    );
  }
}

extension $VariableCollectionCopyWith on VariableCollection {
  /// Returns a callable class that can be used as follows: `instanceOfVariableCollection.copyWith(...)` or like so:`instanceOfVariableCollection.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VariableCollectionCWProxy get copyWith =>
      _$VariableCollectionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariableCollection _$VariableCollectionFromJson(Map<String, dynamic> json) =>
    VariableCollection(
      defaultModeId: json['defaultModeId'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      remote: json['remote'] as bool,
      modes: (json['modes'] as List<dynamic>)
          .map((e) => VariableMode.fromJson(e as Map<String, dynamic>))
          .toList(),
      key: json['key'] as String,
      hiddenFromPublishing: json['hiddenFromPublishing'] as bool,
      variableIds: (json['variableIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$VariableCollectionToJson(VariableCollection instance) =>
    <String, dynamic>{
      'defaultModeId': instance.defaultModeId,
      'id': instance.id,
      'name': instance.name,
      'remote': instance.remote,
      'modes': instance.modes,
      'key': instance.key,
      'hiddenFromPublishing': instance.hiddenFromPublishing,
      'variableIds': instance.variableIds,
    };
