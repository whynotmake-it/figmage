import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'variable.freezed.dart';

/// Figmas identifier for string variables.
const String kResolvedTypeString = 'STRING';

/// Figmas identifier for float variables.
const String kResolvedTypeNumber = 'FLOAT';

/// Figmas identifier for color variables.
const String kResolvedTypeColor = 'COLOR';

/// Figmas identifier for boolean variables.
const String kResolvedTypeBoolean = 'BOOLEAN';

/// Represents a Figma variable with different data types.
///
/// The [Variable] class is used to model Figma variables with various data
/// types.
/// It provides constructors for different types of variables: boolean, float,
/// color, and string.
///
/// The [Variable] class is part of a sealed union type, and each constructor is
/// associated with a specific data type.
@Freezed()
sealed class Variable with _$Variable {
  /// A Figma variable with bool content.
  factory Variable.boolean({
    required String id,
    required String name,
    required bool remote,
    required String key,
    required String variableCollectionId,
    required String variableCollectionName,
    required String resolvedType,
    required String description,
    required bool hiddenFromPublishing,
    required List<String> scopes,
    required Map<String, String> codeSyntax,
    required Map<String, String> collectionModeNames,
    required Map<String, AliasOr<bool>> valuesByMode,
  }) = BooleanVariable;

  /// A Figma variable with float content.
  factory Variable.float({
    required String id,
    required String name,
    required bool remote,
    required String key,
    required String variableCollectionId,
    required String variableCollectionName,
    required String resolvedType,
    required String description,
    required bool hiddenFromPublishing,
    required List<String> scopes,
    required Map<String, String> codeSyntax,
    required Map<String, String> collectionModeNames,
    required Map<String, AliasOr<double>> valuesByMode,
  }) = FloatVariable;

  /// A Figma variable with color content.
  factory Variable.color({
    required String id,
    required String name,
    required bool remote,
    required String key,
    required String variableCollectionId,
    required String variableCollectionName,
    required String resolvedType,
    required String description,
    required bool hiddenFromPublishing,
    required List<String> scopes,
    required Map<String, String> codeSyntax,
    required Map<String, String> collectionModeNames,
    required Map<String, AliasOr<int>> valuesByMode,
  }) = ColorVariable;

  /// A Figma variable with string content.
  factory Variable.string({
    required String id,
    required String name,
    required bool remote,
    required String key,
    required String variableCollectionId,
    required String variableCollectionName,
    required String resolvedType,
    required String description,
    required bool hiddenFromPublishing,
    required List<String> scopes,
    required Map<String, String> codeSyntax,
    required Map<String, String> collectionModeNames,
    required Map<String, AliasOr<String>> valuesByMode,
  }) = StringVariable;
}
