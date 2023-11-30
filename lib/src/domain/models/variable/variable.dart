import 'package:equatable/equatable.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';

/// Figmas identifier for string variables.
const String kResolvedTypeString = 'STRING';

/// Figmas identifier for float variables.
const String kResolvedTypeNumber = 'FLOAT';

/// Figmas identifier for color variables.
const String kResolvedTypeColor = 'COLOR';

/// Figmas identifier for boolean variables.
const String kResolvedTypeBoolean = 'BOOLEAN';

/// {@template variable}
/// Represents a Figma variable with different data types.
///
/// The [Variable] class is used to model Figma variables with various data
/// types.
/// It provides constructors for different types of variables: boolean, float,
/// color, and string.
///
/// The [Variable] class is part of a sealed union type, and each constructor is
/// associated with a specific data type.
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
    required this.collectionModeNames,
  });

  /// The ID of this variable.
  final String id;

  /// The name of this variable.
  @override
  final String name;

  /// Whether this variable is remote.
  final bool remote;

  /// The key of this variable.
  final String key;

  /// The ID of the variable collection this variable belongs to.
  final String variableCollectionId;

  /// The name of the variable collection this variable belongs to.
  final String variableCollectionName;

  /// The resolved type of this variable (see constants above)
  final String resolvedType;

  /// The description of this variable.
  final String description;

  /// Whether this variable is hidden from publishing.
  final bool hiddenFromPublishing;

  /// The scopes of this variable.
  final List<String> scopes;

  /// The code syntax of this variable.
  final Map<String, String> codeSyntax;

  /// The collection mode names of this variable.
  final Map<String, String> collectionModeNames;

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
        collectionModeNames,
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
    required super.collectionModeNames,
    required this.valuesByMode,
  });

  @override
  final Map<String, AliasOr<int>> valuesByMode;
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
    required super.collectionModeNames,
    required this.valuesByMode,
  });

  @override
  final Map<String, AliasOr<double>> valuesByMode;
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
    required super.collectionModeNames,
    required this.valuesByMode,
  });

  @override
  final Map<String, AliasOr<String>> valuesByMode;
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
    required super.collectionModeNames,
    required this.valuesByMode,
  });

  @override
  final Map<String, AliasOr<bool>> valuesByMode;
}
