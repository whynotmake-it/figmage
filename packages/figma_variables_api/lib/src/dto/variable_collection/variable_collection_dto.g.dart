// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable_collection_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VariableCollectionDtoCWProxy {
  VariableCollectionDto defaultModeId(String defaultModeId);

  VariableCollectionDto id(String id);

  VariableCollectionDto name(String name);

  VariableCollectionDto remote(bool remote);

  VariableCollectionDto modes(List<VariableModeDto> modes);

  VariableCollectionDto key(String key);

  VariableCollectionDto hiddenFromPublishing(bool hiddenFromPublishing);

  VariableCollectionDto variableIds(List<String> variableIds);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariableCollectionDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariableCollectionDto(...).copyWith(id: 12, name: "My name")
  /// ````
  VariableCollectionDto call({
    String defaultModeId,
    String id,
    String name,
    bool remote,
    List<VariableModeDto> modes,
    String key,
    bool hiddenFromPublishing,
    List<String> variableIds,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVariableCollectionDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVariableCollectionDto.copyWith.fieldName(...)`
class _$VariableCollectionDtoCWProxyImpl
    implements _$VariableCollectionDtoCWProxy {
  const _$VariableCollectionDtoCWProxyImpl(this._value);

  final VariableCollectionDto _value;

  @override
  VariableCollectionDto defaultModeId(String defaultModeId) =>
      this(defaultModeId: defaultModeId);

  @override
  VariableCollectionDto id(String id) => this(id: id);

  @override
  VariableCollectionDto name(String name) => this(name: name);

  @override
  VariableCollectionDto remote(bool remote) => this(remote: remote);

  @override
  VariableCollectionDto modes(List<VariableModeDto> modes) =>
      this(modes: modes);

  @override
  VariableCollectionDto key(String key) => this(key: key);

  @override
  VariableCollectionDto hiddenFromPublishing(bool hiddenFromPublishing) =>
      this(hiddenFromPublishing: hiddenFromPublishing);

  @override
  VariableCollectionDto variableIds(List<String> variableIds) =>
      this(variableIds: variableIds);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariableCollectionDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariableCollectionDto(...).copyWith(id: 12, name: "My name")
  /// ````
  VariableCollectionDto call({
    Object? defaultModeId = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? remote = const $CopyWithPlaceholder(),
    Object? modes = const $CopyWithPlaceholder(),
    Object? key = const $CopyWithPlaceholder(),
    Object? hiddenFromPublishing = const $CopyWithPlaceholder(),
    Object? variableIds = const $CopyWithPlaceholder(),
  }) {
    return VariableCollectionDto(
      defaultModeId: defaultModeId == const $CopyWithPlaceholder()
          ? _value.defaultModeId
          // ignore: cast_nullable_to_non_nullable
          : defaultModeId as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      remote: remote == const $CopyWithPlaceholder()
          ? _value.remote
          // ignore: cast_nullable_to_non_nullable
          : remote as bool,
      modes: modes == const $CopyWithPlaceholder()
          ? _value.modes
          // ignore: cast_nullable_to_non_nullable
          : modes as List<VariableModeDto>,
      key: key == const $CopyWithPlaceholder()
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as String,
      hiddenFromPublishing: hiddenFromPublishing == const $CopyWithPlaceholder()
          ? _value.hiddenFromPublishing
          // ignore: cast_nullable_to_non_nullable
          : hiddenFromPublishing as bool,
      variableIds: variableIds == const $CopyWithPlaceholder()
          ? _value.variableIds
          // ignore: cast_nullable_to_non_nullable
          : variableIds as List<String>,
    );
  }
}

extension $VariableCollectionDtoCopyWith on VariableCollectionDto {
  /// Returns a callable class that can be used as follows: `instanceOfVariableCollectionDto.copyWith(...)` or like so:`instanceOfVariableCollectionDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VariableCollectionDtoCWProxy get copyWith =>
      _$VariableCollectionDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariableCollectionDto _$VariableCollectionDtoFromJson(
        Map<String, dynamic> json) =>
    VariableCollectionDto(
      defaultModeId: json['defaultModeId'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      remote: json['remote'] as bool,
      modes: (json['modes'] as List<dynamic>)
          .map((e) => VariableModeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      key: json['key'] as String,
      hiddenFromPublishing: json['hiddenFromPublishing'] as bool,
      variableIds: (json['variableIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$VariableCollectionDtoToJson(
        VariableCollectionDto instance) =>
    <String, dynamic>{
      'defaultModeId': instance.defaultModeId,
      'id': instance.id,
      'name': instance.name,
      'remote': instance.remote,
      'modes': instance.modes.map((e) => e.toJson()).toList(),
      'key': instance.key,
      'hiddenFromPublishing': instance.hiddenFromPublishing,
      'variableIds': instance.variableIds,
    };
