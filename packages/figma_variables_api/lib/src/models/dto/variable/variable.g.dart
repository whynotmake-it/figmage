// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VariableCWProxy {
  Variable id(String id);

  Variable name(String name);

  Variable remote(bool remote);

  Variable key(String key);

  Variable variableCollectionId(String variableCollectionId);

  Variable resolvedType(String resolvedType);

  Variable description(String description);

  Variable hiddenFromPublishing(bool hiddenFromPublishing);

  Variable valuesByMode(Map<String, VariableModeValue> valuesByMode);

  Variable scopes(List<String> scopes);

  Variable codeSyntax(Map<String, dynamic> codeSyntax);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Variable(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Variable(...).copyWith(id: 12, name: "My name")
  /// ````
  Variable call({
    String? id,
    String? name,
    bool? remote,
    String? key,
    String? variableCollectionId,
    String? resolvedType,
    String? description,
    bool? hiddenFromPublishing,
    Map<String, VariableModeValue>? valuesByMode,
    List<String>? scopes,
    Map<String, dynamic>? codeSyntax,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVariable.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVariable.copyWith.fieldName(...)`
class _$VariableCWProxyImpl implements _$VariableCWProxy {
  const _$VariableCWProxyImpl(this._value);

  final Variable _value;

  @override
  Variable id(String id) => this(id: id);

  @override
  Variable name(String name) => this(name: name);

  @override
  Variable remote(bool remote) => this(remote: remote);

  @override
  Variable key(String key) => this(key: key);

  @override
  Variable variableCollectionId(String variableCollectionId) =>
      this(variableCollectionId: variableCollectionId);

  @override
  Variable resolvedType(String resolvedType) =>
      this(resolvedType: resolvedType);

  @override
  Variable description(String description) => this(description: description);

  @override
  Variable hiddenFromPublishing(bool hiddenFromPublishing) =>
      this(hiddenFromPublishing: hiddenFromPublishing);

  @override
  Variable valuesByMode(Map<String, VariableModeValue> valuesByMode) =>
      this(valuesByMode: valuesByMode);

  @override
  Variable scopes(List<String> scopes) => this(scopes: scopes);

  @override
  Variable codeSyntax(Map<String, dynamic> codeSyntax) =>
      this(codeSyntax: codeSyntax);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Variable(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Variable(...).copyWith(id: 12, name: "My name")
  /// ````
  Variable call({
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
    return Variable(
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
              : valuesByMode as Map<String, VariableModeValue>,
      scopes: scopes == const $CopyWithPlaceholder() || scopes == null
          ? _value.scopes
          // ignore: cast_nullable_to_non_nullable
          : scopes as List<String>,
      codeSyntax:
          codeSyntax == const $CopyWithPlaceholder() || codeSyntax == null
              ? _value.codeSyntax
              // ignore: cast_nullable_to_non_nullable
              : codeSyntax as Map<String, dynamic>,
    );
  }
}

extension $VariableCopyWith on Variable {
  /// Returns a callable class that can be used as follows: `instanceOfVariable.copyWith(...)` or like so:`instanceOfVariable.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VariableCWProxy get copyWith => _$VariableCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Variable _$VariableFromJson(Map<String, dynamic> json) => Variable(
      id: json['id'] as String,
      name: json['name'] as String,
      remote: json['remote'] as bool,
      key: json['key'] as String,
      variableCollectionId: json['variableCollectionId'] as String,
      resolvedType: json['resolvedType'] as String,
      description: json['description'] as String,
      hiddenFromPublishing: json['hiddenFromPublishing'] as bool,
      valuesByMode: (json['valuesByMode'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, VariableModeValue.fromJson(e as Map<String, dynamic>)),
      ),
      scopes:
          (json['scopes'] as List<dynamic>).map((e) => e as String).toList(),
      codeSyntax: json['codeSyntax'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$VariableToJson(Variable instance) => <String, dynamic>{
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
