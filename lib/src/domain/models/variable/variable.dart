import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'variable.freezed.dart';

const String kResolvedTypeString = 'STRING';
const String kResolvedTypeNumber = 'FLOAT';
const String kResolvedTypeColor = 'COLOR';
const String kResolvedTypeBoolean = 'BOOLEAN';

@Freezed()
class Variable with _$Variable {
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
