// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VariableDtoCWProxy {
  VariableDto id(String id);

  VariableDto name(String name);

  VariableDto remote(bool remote);

  VariableDto key(String key);

  VariableDto variableCollectionId(String variableCollectionId);

  VariableDto resolvedType(String resolvedType);

  VariableDto description(String description);

  VariableDto hiddenFromPublishing(bool hiddenFromPublishing);

  VariableDto valuesByMode(Map<String, dynamic> valuesByMode);

  VariableDto scopes(List<String> scopes);

  VariableDto codeSyntax(Map<String, String> codeSyntax);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariableDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariableDto(...).copyWith(id: 12, name: "My name")
  /// ````
  VariableDto call({
    String? id,
    String? name,
    bool? remote,
    String? key,
    String? variableCollectionId,
    String? resolvedType,
    String? description,
    bool? hiddenFromPublishing,
    Map<String, dynamic>? valuesByMode,
    List<String>? scopes,
    Map<String, String>? codeSyntax,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVariableDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVariableDto.copyWith.fieldName(...)`
class _$VariableDtoCWProxyImpl implements _$VariableDtoCWProxy {
  const _$VariableDtoCWProxyImpl(this._value);

  final VariableDto _value;

  @override
  VariableDto id(String id) => this(id: id);

  @override
  VariableDto name(String name) => this(name: name);

  @override
  VariableDto remote(bool remote) => this(remote: remote);

  @override
  VariableDto key(String key) => this(key: key);

  @override
  VariableDto variableCollectionId(String variableCollectionId) =>
      this(variableCollectionId: variableCollectionId);

  @override
  VariableDto resolvedType(String resolvedType) =>
      this(resolvedType: resolvedType);

  @override
  VariableDto description(String description) => this(description: description);

  @override
  VariableDto hiddenFromPublishing(bool hiddenFromPublishing) =>
      this(hiddenFromPublishing: hiddenFromPublishing);

  @override
  VariableDto valuesByMode(Map<String, dynamic> valuesByMode) =>
      this(valuesByMode: valuesByMode);

  @override
  VariableDto scopes(List<String> scopes) => this(scopes: scopes);

  @override
  VariableDto codeSyntax(Map<String, String> codeSyntax) =>
      this(codeSyntax: codeSyntax);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariableDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariableDto(...).copyWith(id: 12, name: "My name")
  /// ````
  VariableDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? remote = const $CopyWithPlaceholder(),
    Object? key = const $CopyWithPlaceholder(),
    Object? variableCollectionId = const $CopyWithPlaceholder(),
    Object? resolvedType = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? hiddenFromPublishing = const $CopyWithPlaceholder(),
    Object? valuesByMode = const $CopyWithPlaceholder(),
    Object? scopes = const $CopyWithPlaceholder(),
    Object? codeSyntax = const $CopyWithPlaceholder(),
  }) {
    return VariableDto(
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
      key: key == const $CopyWithPlaceholder() || key == null
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as String,
      variableCollectionId:
          variableCollectionId == const $CopyWithPlaceholder() ||
                  variableCollectionId == null
              ? _value.variableCollectionId
              // ignore: cast_nullable_to_non_nullable
              : variableCollectionId as String,
      resolvedType:
          resolvedType == const $CopyWithPlaceholder() || resolvedType == null
              ? _value.resolvedType
              // ignore: cast_nullable_to_non_nullable
              : resolvedType as String,
      description:
          description == const $CopyWithPlaceholder() || description == null
              ? _value.description
              // ignore: cast_nullable_to_non_nullable
              : description as String,
      hiddenFromPublishing:
          hiddenFromPublishing == const $CopyWithPlaceholder() ||
                  hiddenFromPublishing == null
              ? _value.hiddenFromPublishing
              // ignore: cast_nullable_to_non_nullable
              : hiddenFromPublishing as bool,
      valuesByMode:
          valuesByMode == const $CopyWithPlaceholder() || valuesByMode == null
              ? _value.valuesByMode
              // ignore: cast_nullable_to_non_nullable
              : valuesByMode as Map<String, dynamic>,
      scopes: scopes == const $CopyWithPlaceholder() || scopes == null
          ? _value.scopes
          // ignore: cast_nullable_to_non_nullable
          : scopes as List<String>,
      codeSyntax:
          codeSyntax == const $CopyWithPlaceholder() || codeSyntax == null
              ? _value.codeSyntax
              // ignore: cast_nullable_to_non_nullable
              : codeSyntax as Map<String, String>,
    );
  }
}

extension $VariableDtoCopyWith on VariableDto {
  /// Returns a callable class that can be used as follows: `instanceOfVariableDto.copyWith(...)` or like so:`instanceOfVariableDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VariableDtoCWProxy get copyWith => _$VariableDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariableDto _$VariableDtoFromJson(Map<String, dynamic> json) => VariableDto(
      id: json['id'] as String,
      name: json['name'] as String,
      remote: json['remote'] as bool,
      key: json['key'] as String,
      variableCollectionId: json['variableCollectionId'] as String,
      resolvedType: json['resolvedType'] as String,
      description: json['description'] as String,
      hiddenFromPublishing: json['hiddenFromPublishing'] as bool,
      valuesByMode: json['valuesByMode'] as Map<String, dynamic>,
      scopes:
          (json['scopes'] as List<dynamic>).map((e) => e as String).toList(),
      codeSyntax: Map<String, String>.from(json['codeSyntax'] as Map),
    );

Map<String, dynamic> _$VariableDtoToJson(VariableDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'remote': instance.remote,
      'key': instance.key,
      'variableCollectionId': instance.variableCollectionId,
      'resolvedType': instance.resolvedType,
      'description': instance.description,
      'hiddenFromPublishing': instance.hiddenFromPublishing,
      'valuesByMode': instance.valuesByMode,
      'scopes': instance.scopes,
      'codeSyntax': instance.codeSyntax,
    };
