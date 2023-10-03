// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variables_meta.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VariablesMetaCWProxy {
  VariablesMeta variables(Map<String, Variable> variables);

  VariablesMeta variableCollections(
      Map<String, VariableCollection> variableCollections);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariablesMeta(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariablesMeta(...).copyWith(id: 12, name: "My name")
  /// ````
  VariablesMeta call({
    Map<String, Variable>? variables,
    Map<String, VariableCollection>? variableCollections,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVariablesMeta.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVariablesMeta.copyWith.fieldName(...)`
class _$VariablesMetaCWProxyImpl implements _$VariablesMetaCWProxy {
  const _$VariablesMetaCWProxyImpl(this._value);

  final VariablesMeta _value;

  @override
  VariablesMeta variables(Map<String, Variable> variables) =>
      this(variables: variables);

  @override
  VariablesMeta variableCollections(
          Map<String, VariableCollection> variableCollections) =>
      this(variableCollections: variableCollections);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VariablesMeta(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VariablesMeta(...).copyWith(id: 12, name: "My name")
  /// ````
  VariablesMeta call({
    Object? variables = const $CopyWithPlaceholder(),
    Object? variableCollections = const $CopyWithPlaceholder(),
  }) {
    return VariablesMeta(
      variables: variables == const $CopyWithPlaceholder() || variables == null
          ? _value.variables
          // ignore: cast_nullable_to_non_nullable
          : variables as Map<String, Variable>,
      variableCollections:
          variableCollections == const $CopyWithPlaceholder() ||
                  variableCollections == null
              ? _value.variableCollections
              // ignore: cast_nullable_to_non_nullable
              : variableCollections as Map<String, VariableCollection>,
    );
  }
}

extension $VariablesMetaCopyWith on VariablesMeta {
  /// Returns a callable class that can be used as follows: `instanceOfVariablesMeta.copyWith(...)` or like so:`instanceOfVariablesMeta.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VariablesMetaCWProxy get copyWith => _$VariablesMetaCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariablesMeta _$VariablesMetaFromJson(Map<String, dynamic> json) =>
    VariablesMeta(
      variables: (json['variables'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Variable.fromJson(e as Map<String, dynamic>)),
      ),
      variableCollections:
          (json['variableCollections'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, VariableCollection.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$VariablesMetaToJson(VariablesMeta instance) =>
    <String, dynamic>{
      'variables': instance.variables.map((k, e) => MapEntry(k, e.toJson())),
      'variableCollections':
          instance.variableCollections.map((k, e) => MapEntry(k, e.toJson())),
    };
