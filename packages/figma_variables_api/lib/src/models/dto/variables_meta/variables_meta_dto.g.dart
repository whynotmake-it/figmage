// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variables_meta_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VariablesMetaDtoCWProxy {
  VariablesMetaDto variables(Map<String, VariableDto> variables);

  VariablesMetaDto variableCollections(
      Map<String, VariableCollectionDto> variableCollections);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariablesMetaDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariablesMetaDto(...).copyWith(id: 12, name: "My name")
  /// ````
  VariablesMetaDto call({
    Map<String, VariableDto>? variables,
    Map<String, VariableCollectionDto>? variableCollections,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVariablesMetaDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVariablesMetaDto.copyWith.fieldName(...)`
class _$VariablesMetaDtoCWProxyImpl implements _$VariablesMetaDtoCWProxy {
  const _$VariablesMetaDtoCWProxyImpl(this._value);

  final VariablesMetaDto _value;

  @override
  VariablesMetaDto variables(Map<String, VariableDto> variables) =>
      this(variables: variables);

  @override
  VariablesMetaDto variableCollections(
          Map<String, VariableCollectionDto> variableCollections) =>
      this(variableCollections: variableCollections);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariablesMetaDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariablesMetaDto(...).copyWith(id: 12, name: "My name")
  /// ````
  VariablesMetaDto call({
    Object? variables = const $CopyWithPlaceholder(),
    Object? variableCollections = const $CopyWithPlaceholder(),
  }) {
    return VariablesMetaDto(
      variables: variables == const $CopyWithPlaceholder() || variables == null
          ? _value.variables
          // ignore: cast_nullable_to_non_nullable
          : variables as Map<String, VariableDto>,
      variableCollections:
          variableCollections == const $CopyWithPlaceholder() ||
                  variableCollections == null
              ? _value.variableCollections
              // ignore: cast_nullable_to_non_nullable
              : variableCollections as Map<String, VariableCollectionDto>,
    );
  }
}

extension $VariablesMetaDtoCopyWith on VariablesMetaDto {
  /// Returns a callable class that can be used as follows: `instanceOfVariablesMetaDto.copyWith(...)` or like so:`instanceOfVariablesMetaDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VariablesMetaDtoCWProxy get copyWith => _$VariablesMetaDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariablesMetaDto _$VariablesMetaDtoFromJson(Map<String, dynamic> json) =>
    VariablesMetaDto(
      variables: (json['variables'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, VariableDto.fromJson(e as Map<String, dynamic>)),
      ),
      variableCollections:
          (json['variableCollections'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, VariableCollectionDto.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$VariablesMetaDtoToJson(VariablesMetaDto instance) =>
    <String, dynamic>{
      'variables': instance.variables.map((k, e) => MapEntry(k, e.toJson())),
      'variableCollections':
          instance.variableCollections.map((k, e) => MapEntry(k, e.toJson())),
    };
