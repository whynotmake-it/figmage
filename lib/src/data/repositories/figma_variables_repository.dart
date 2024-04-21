import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage/src/domain/repositories/variables_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Visible for testing
@visibleForTesting
typedef VariablesData = ({
  Map<String, Variable<dynamic>> variables,
  Map<String, VariableCollectionDto> variableCollections
});

/// The implementation of [VariablesRepository] for Figma.
class FigmaVariablesRepository implements VariablesRepository {
  @override
  Future<List<Variable<dynamic>>> getVariables({
    required String fileId,
    required String token,
  }) async {
    return fromDtoToModel(
      await _getLocaleVariables(fileId: fileId, token: token),
    );
  }

  Future<VariablesResponseDto> _getLocaleVariables({
    required String fileId,
    required String token,
  }) async {
    final client = FigmaClient(token);
    try {
      // ignore: unnecessary_await_in_return
      return await client.getLocalVariables(fileId);
    } on FigmaException catch (e) {
      if (e.code == 403) {
        throw UnauthorizedVariablesException(e.message);
      } else {
        throw UnknownVariablesException(e.message);
      }
    } catch (e) {
      throw UnknownVariablesException(e.toString());
    }
  }

  /// Converts a list of DTO variables into model variables.
  ///
  /// Given a [VariablesResponseDto], this method processes the variables within
  /// it, maps them to model variables, and returns a list of variables.
  @visibleForTesting
  List<Variable<dynamic>> fromDtoToModel(
    VariablesResponseDto variablesResponse,
  ) {
    final variableCollections = variablesResponse.meta.variableCollections;
    final dtoVariables = variablesResponse.meta.variables;

    final variables = dtoVariables.values.map((dtoVariable) {
      final variableCollection =
          variableCollections[dtoVariable.variableCollectionId];
      assert(variableCollection != null, 'VariableCollection can not be null');
      final modeNamesById = {
        for (final item in variableCollection!.modes) item.modeId: item.name,
      };
      final collectionName = variableCollection.name;

      return switch (dtoVariable.resolvedType) {
        kResolvedTypeString => StringVariable(
            id: dtoVariable.id,
            name: dtoVariable.name,
            remote: dtoVariable.remote,
            key: dtoVariable.key,
            variableCollectionId: dtoVariable.variableCollectionId,
            variableCollectionName: collectionName,
            resolvedType: dtoVariable.resolvedType,
            description: dtoVariable.description,
            hiddenFromPublishing: dtoVariable.hiddenFromPublishing,
            scopes: dtoVariable.scopes,
            codeSyntax: dtoVariable.codeSyntax,
            valuesByModeId: dtoVariable.valuesByMode.map(
              (key, value) => MapEntry(
                key,
                _resolveAlias(value: value, dtoVariables: dtoVariables),
              ),
            ),
            collectionModeNamesById: modeNamesById,
          ),
        kResolvedTypeBoolean => BoolVariable(
            id: dtoVariable.id,
            name: dtoVariable.name,
            remote: dtoVariable.remote,
            key: dtoVariable.key,
            variableCollectionId: dtoVariable.variableCollectionId,
            variableCollectionName: collectionName,
            resolvedType: dtoVariable.resolvedType,
            description: dtoVariable.description,
            hiddenFromPublishing: dtoVariable.hiddenFromPublishing,
            scopes: dtoVariable.scopes,
            codeSyntax: dtoVariable.codeSyntax,
            valuesByModeId: dtoVariable.valuesByMode.map(
              (key, value) => MapEntry(
                key,
                _resolveAlias(value: value, dtoVariables: dtoVariables),
              ),
            ),
            collectionModeNamesById: modeNamesById,
          ),
        kResolvedTypeColor => ColorVariable(
            id: dtoVariable.id,
            name: dtoVariable.name,
            remote: dtoVariable.remote,
            key: dtoVariable.key,
            variableCollectionId: dtoVariable.variableCollectionId,
            variableCollectionName: collectionName,
            resolvedType: dtoVariable.resolvedType,
            description: dtoVariable.description,
            hiddenFromPublishing: dtoVariable.hiddenFromPublishing,
            scopes: dtoVariable.scopes,
            codeSyntax: dtoVariable.codeSyntax,
            valuesByModeId: dtoVariable.valuesByMode.map(
              (key, value) => MapEntry(
                key,
                _resolveAlias(value: value, dtoVariables: dtoVariables),
              ),
            ),
            collectionModeNamesById: modeNamesById,
          ),
        kResolvedTypeNumber => FloatVariable(
            id: dtoVariable.id,
            name: dtoVariable.name,
            remote: dtoVariable.remote,
            key: dtoVariable.key,
            variableCollectionId: dtoVariable.variableCollectionId,
            variableCollectionName: collectionName,
            resolvedType: dtoVariable.resolvedType,
            description: dtoVariable.description,
            hiddenFromPublishing: dtoVariable.hiddenFromPublishing,
            scopes: dtoVariable.scopes,
            codeSyntax: dtoVariable.codeSyntax,
            valuesByModeId: dtoVariable.valuesByMode.map(
              (key, value) => MapEntry(
                key,
                _resolveAlias(value: value, dtoVariables: dtoVariables),
              ),
            ),
            collectionModeNamesById: modeNamesById,
          ),
        _ => throw UnsupportedError(
            "The variable type ${dtoVariable.resolvedType} is not supported",
          ),
      };
    });
    return variables.cast<Variable<dynamic>>().toList();
  }

  /// A helper function for resolving alias values within Figma variables.
  ///
  /// Parameters:
  /// - `value`: The variable mode value data to resolve.
  /// - `dtoVariables`: A map of variable data for resolving aliases.
  ///
  /// Returns an [AliasOr] object containing the resolved value.
  AliasOr<T> _resolveAlias<T>({
    required VariableModeValueDto value,
    required Map<String, VariableDto> dtoVariables,
  }) {
    if (value case final VariableModeAliasDto aliasDto) {
      if (dtoVariables.containsKey(aliasDto.id) == false) {
        return AliasUnresolved(id: aliasDto.id);
      }
    }
    return switch (value) {
      VariableModeAliasDto() => Alias(
          id: value.id,
          aliasOrValue: _resolveAlias(
            value: dtoVariables[value.id]!.valuesByMode.values.first,
            dtoVariables: dtoVariables,
          ),
        ),
      VariableModeBooleanDto() => AliasData(data: value.value as T),
      VariableModeDoubleDto() => AliasData(data: value.value as T),
      VariableModeStringDto() => AliasData(data: value.value as T),
      VariableModeColorDto() => AliasData(data: value.value as T),
    };
  }
}
