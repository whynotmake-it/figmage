import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:figmage/src/domain/models/models.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/repositories/repositories.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@visibleForTesting
typedef VariablesData = ({
  Map<String, Variable> variables,
  Map<String, VariableCollectionDto> variableCollections
});

class FigmaVariablesRepository implements VariablesRepository {
  /// Creates a map of Figma variable values organized by collection, mode, and variable name.
  ///
  /// This function takes a list of [Variable] instances and arranges their values in a
  /// hierarchical map structure. The resulting map is organized by collection, mode,
  /// and variable name. The type of value is specified by the generic type parameter [T],
  /// and it is constrained to the subtype of [Variable] represented by [V].
  ///
  /// Parameters:
  /// - [variables]: A list of [Variable] instances to extract values from.
  /// - [useNames]: A boolean flag indicating whether to use variable names (true) or
  ///   variable IDs (false) for map keys. Default is true.
  ///
  /// Generic Type Parameters:
  /// - [T]: The data type of the variable values to be included in the map.
  /// - [V]: A subtype of [Variable] representing the specific variable type for value extraction.
  ///
  /// Example:
  /// ```dart
  /// final variables = variables; // List of Variable instances;
  ///
  /// final valueMap = createValueModeMap<double, FloatVariable>(
  ///   variables: variables,
  ///   useNames: true,
  /// );
  /// ```
  Map<String, Map<String, Map<String, T>>>
      createValueModeMap<T, V extends Variable>({
    required List<Variable> variables,
    bool useNames = true,
  }) {
    assert(
      V != Variable,
      'Type argument T must be a specific type of variable.',
    );

    final result = <String, Map<String, Map<String, T>>>{};

    final variablesWithTypeV = variables.whereType<V>();

    for (final variable in variablesWithTypeV) {
      final collectionKey = useNames
          ? variable.variableCollectionName
          : variable.variableCollectionId;

      final collectionMap = result.putIfAbsent(
        collectionKey,
        () => <String, Map<String, T>>{},
      );

      variable.valuesByMode.forEach((modeId, aliasOr) {
        final modeKey =
            useNames ? variable.collectionModeNames[modeId]! : modeId;

        final modeMap = collectionMap.putIfAbsent(
          modeKey,
          () => <String, T>{},
        );

        final existingValue = modeMap.putIfAbsent(
          useNames ? variable.name : variable.id,
          () => (aliasOr as AliasOr<T>).resolveValue,
        );

        if (existingValue != (aliasOr as AliasOr<T>).resolveValue) {
          print(
            'Warning: Override value for variable ${variable.name} in mode $modeId.',
          );
        }
      });
    }

    return result;
  }

  Future<VariablesResponseDto> _getLocaleVariables({
    required String fileId,
    required String token,
  }) async {
    final client = FigmaClient(token);
    return await client.getLocalVariables(fileId);
  }

  /// Converts a list of DTO variables into model variables.
  ///
  /// Given a [VariablesResponseDto], this method processes the variables within it,
  /// maps them to model variables, and returns a list of variables.
  @visibleForTesting
  List<Variable> fromDtoToModel(
    VariablesResponseDto variablesResponse,
  ) {
    final variableCollections = variablesResponse.meta.variableCollections;
    final dtoVariables = variablesResponse.meta.variables;
    final variables = dtoVariables.values.map((dtoVariable) {
      final variableCollection =
          variableCollections[dtoVariable.variableCollectionId];
      assert(variableCollection != null, 'VariableCollection can not be null');
      final collectionModeNames = {
        for (final item in variableCollection!.modes) item.modeId: item.name,
      };
      final collectionName = variableCollection.name;

      if (dtoVariable.resolvedType == kResolvedTypeString) {
        final variable = StringVariable(
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
          valuesByMode: dtoVariable.valuesByMode.map(
            (key, value) => MapEntry(
              key,
              _resolveAlias(value: value, dtoVariables: dtoVariables),
            ),
          ),
          collectionModeNames: collectionModeNames,
        );
        return variable;
      } else if (dtoVariable.resolvedType == kResolvedTypeBoolean) {
        final variable = BooleanVariable(
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
          valuesByMode: dtoVariable.valuesByMode.map(
            (key, value) => MapEntry(
              key,
              _resolveAlias(value: value, dtoVariables: dtoVariables),
            ),
          ),
          collectionModeNames: collectionModeNames,
        );
        return variable;
      } else if (dtoVariable.resolvedType == kResolvedTypeColor) {
        final variable = ColorVariable(
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
          valuesByMode: dtoVariable.valuesByMode.map(
            (key, value) => MapEntry(
              key,
              _resolveAlias(value: value, dtoVariables: dtoVariables),
            ),
          ),
          collectionModeNames: collectionModeNames,
        );
        return variable;
      } else if (dtoVariable.resolvedType == kResolvedTypeNumber) {
        final variable = FloatVariable(
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
          valuesByMode: dtoVariable.valuesByMode.map(
            (key, value) => MapEntry(
              key,
              _resolveAlias(value: value, dtoVariables: dtoVariables),
            ),
          ),
          collectionModeNames: collectionModeNames,
        );
        return variable;
      } else {
        throw TypeError();
      }
    });
    return variables.toList();
  }

  @override
  Future<List<Variable>> getVariables({
    required String fileId,
    required String token,
  }) async {
    return fromDtoToModel(
      await _getLocaleVariables(fileId: fileId, token: token),
    );
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
    return switch (value) {
      VariableModeAliasDto() => Alias(
          id: value.id,
          aliasOrValue: _resolveAlias(
            value: dtoVariables[value.id]!.valuesByMode.values.first,
            dtoVariables: dtoVariables,
          ),
        ),
      VariableModeBooleanDto() => AliasData(data: value.value as T),
      VariableModeNumberDto() => AliasData(data: value.value as T),
      VariableModeStringDto() => AliasData(data: value.value as T),
      VariableModeColorDto() => AliasData(data: value.value as T),
    };
  }
}
