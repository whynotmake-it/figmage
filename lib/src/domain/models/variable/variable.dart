import 'package:equatable/equatable.dart';
import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';

/// {@template variable}
/// Represents a Figma variable with different data types.
///
/// The [Variable] sealed class is used to model Figma variables with various
/// data types.
/// It provides classes for different types of variables: boolean, float,
/// color, and string.
/// {@endtemplate}
sealed class Variable<T> with EquatableMixin implements DesignToken<T> {
  /// {@macro variable}
  const Variable({
    required this.id,
    required this.name,
    required this.remote,
    required this.key,
    required this.variableCollectionId,
    required this.variableCollectionName,
    required this.resolvedType,
    required this.description,
    required this.hiddenFromPublishing,
    required this.scopes,
    required this.codeSyntax,
    required this.collectionModeNamesById,
    this.deletedButReferenced,
  });

  /// The ID of this variable.
  final String id;

  /// The name of this variable.
  @override
  final String name;

  /// The name of the collection.
  @override
  String get collectionName => variableCollectionName;

  /// The id of the collection, which is used to separate tokens into classes.
  @override
  String get collectionId => variableCollectionId;

  /// Whether this variable is remote.
  final bool remote;

  /// The key of this variable.
  final String key;

  /// The ID of the variable collection this variable belongs to.
  final String variableCollectionId;

  /// The name of the variable collection this variable belongs to.
  final String variableCollectionName;

  /// The resolved type of this variable (see constants above)
  final VariableType resolvedType;

  /// The description of this variable.
  final String description;

  /// Whether this variable is hidden from publishing.
  final bool hiddenFromPublishing;

  /// The scopes of this variable.
  final List<String> scopes;

  /// The code syntax of this variable.
  final Map<String, String> codeSyntax;

  /// The collection mode names of this variable, by their mode's ID.
  final Map<String, String> collectionModeNamesById;

  /// Whether this variable is deleted but still referenced.
  ///
  /// This occurs when you bind a property or variable alias to a variable,
  /// and then use the "Local variables" menu to delete the variable.
  final bool? deletedButReferenced;

  @override
  Map<String, AliasOr<T>> get valuesByModeName => valuesByModeId.map(
        (key, value) => MapEntry(collectionModeNamesById[key]!, value),
      );

  @override
  String get fullName => switch (variableCollectionName) {
        "" => name,
        _ => "$variableCollectionName/$name",
      };

  @override
  List<Object?> get props => [
        id,
        name,
        remote,
        key,
        variableCollectionId,
        variableCollectionName,
        resolvedType,
        description,
        hiddenFromPublishing,
        scopes,
        codeSyntax,
        collectionModeNamesById,
        deletedButReferenced,
      ];

  @override
  bool? get stringify => true;
}

/// {@template color_variable}
/// A [Variable] with a color value.
/// {@endtemplate}
class ColorVariable extends Variable<int> {
  /// {@macro color_variable}
  const ColorVariable({
    required super.id,
    required super.name,
    required super.remote,
    required super.key,
    required super.variableCollectionId,
    required super.variableCollectionName,
    required super.resolvedType,
    required super.description,
    required super.hiddenFromPublishing,
    required super.scopes,
    required super.codeSyntax,
    required super.collectionModeNamesById,
    required this.valuesByModeId,
    super.deletedButReferenced,
  });

  @override
  final Map<String, AliasOr<int>> valuesByModeId;
}

/// {@template float_variable}
/// A variable with a float (double) value.
/// {@endtemplate}
class FloatVariable extends Variable<double> {
  /// {@macro float_variable}
  const FloatVariable({
    required super.id,
    required super.name,
    required super.remote,
    required super.key,
    required super.variableCollectionId,
    required super.variableCollectionName,
    required super.resolvedType,
    required super.description,
    required super.hiddenFromPublishing,
    required super.scopes,
    required super.codeSyntax,
    required super.collectionModeNamesById,
    required this.valuesByModeId,
    super.deletedButReferenced,
  });

  @override
  final Map<String, AliasOr<double>> valuesByModeId;
}

/// {@template string_variable}
/// A variable with a string value.
/// {@endtemplate}
class StringVariable extends Variable<String> {
  /// {@macro string_variable}
  const StringVariable({
    required super.id,
    required super.name,
    required super.remote,
    required super.key,
    required super.variableCollectionId,
    required super.variableCollectionName,
    required super.resolvedType,
    required super.description,
    required super.hiddenFromPublishing,
    required super.scopes,
    required super.codeSyntax,
    required super.collectionModeNamesById,
    required this.valuesByModeId,
    super.deletedButReferenced,
  });

  @override
  final Map<String, AliasOr<String>> valuesByModeId;
}

/// {@template bool_variable}
/// A variable with a boolean value.
/// {@endtemplate}
class BoolVariable extends Variable<bool> {
  /// {@macro bool_variable}
  const BoolVariable({
    required super.id,
    required super.name,
    required super.remote,
    required super.key,
    required super.variableCollectionId,
    required super.variableCollectionName,
    required super.resolvedType,
    required super.description,
    required super.hiddenFromPublishing,
    required super.scopes,
    required super.codeSyntax,
    required super.collectionModeNamesById,
    required this.valuesByModeId,
    super.deletedButReferenced,
  });

  @override
  final Map<String, AliasOr<bool>> valuesByModeId;
}
