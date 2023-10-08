import 'package:figma_variables_api/figma_variables_api.dart'
    as figma_datasource;
import 'package:figmage/src/domain/models/models.dart';
import 'package:figmage/src/domain/repositories/repositories.dart';
import 'package:collection/collection.dart';

typedef VariablesData = ({
  Map<String, Variable> variables,
  Map<String, figma_datasource.VariableCollection> variableCollections
});

class FigmaVariablesRepository implements VariablesRepository {
  /// Fetches variable values for a Figma file specified by [fileId]
  /// using the provided [token]. It filters the variables based on the [collectionsFilter],
  /// which is a list of collection names to include. If [collectionsFilter] is null,
  /// all collections are included.
  @override
  Future<Map<String, Map<String, T>>>
      getVariableValues<T extends VariableValue>({
    required String fileId,
    required String token,
    List<String>? collectionsFilter,
  }) async {
    final (:variables, :variableCollections) =
        fromDtoToModel(await _getLocaleVariables(fileId: fileId, token: token));

    return createValueModeMap(
      variables: variables,
      variableCollections: variableCollections,
      collectionsFilter: collectionsFilter,
    );
  }

  /// Returns a map where the keys represent mode names, and the values are maps
  /// containing variable names and their corresponding values of type [T].
  ///It filters the variables based on the [collectionsFilter],
  /// which is a list of collection names to include. If [collectionsFilter] is null,
  /// all collections are included.
  /// Throws [TypeError] if a variable points to a different [VariableValue]
  /// type than [T].
  /// Example usage:
  /// ```dart
  /// var colorMap = _createValueModeMap<VariableColorValue>(variables: variables, variableCollections: variableCollections');
  /// print(colorMap); // e.g., {'light': {'green': 0xFF00FF00}, 'dark': {'green': 0xFF008000}}
  /// ```
  Map<String, Map<String, T>> createValueModeMap<T extends VariableValue>({
    required Map<String, Variable> variables,
    required Map<String, figma_datasource.VariableCollection>
        variableCollections,
    List<String>? collectionsFilter,
  }) {
    assert(T != dynamic, 'Type argument T must not be dynamic.');
    assert(
      T != VariableAliasValue,
      'Type argument T must not be VariableAliasValue.',
    );

    final result = <String, Map<String, T>>{};

    //clean data
    if (T == BooleanValue) {
      variables.removeWhere((key, variable) => variable is! BooleanVariable);
    } else if (T == StringValue) {
      variables.removeWhere(
        (key, variable) => variable is! StringVariable,
      );
    } else if (T == NumberValue) {
      variables.removeWhere((key, variable) => variable is! FloatVariable);
    } else if (T == ColorValue) {
      variables.removeWhere(
        (key, variable) => variable is! ColorVariable,
      );
    } else {
      throw TypeError();
    }

    for (final variable in variables.values) {
      variable.valuesByMode.forEach((modeId, value) {
        final variableCollection =
            variableCollections[variable.variableCollectionId];

        final collectionInScope = collectionsFilter == null
            ? true
            : collectionsFilter.contains(variableCollection?.name);
        if (!collectionInScope) return;

        final modeName = variableCollection?.modes
            .firstWhereOrNull((mode) => mode.modeId == modeId)
            ?.name;
        assert(modeName != null, 'Mode name can not be null');

        final resultValue = value is T
            ? value
            : value is VariableAliasValue
                ? _getVariableModeValueRecursive<T>(
                    alias: value,
                    variables: variables,
                  )
                : throw TypeError();

        //This creates or get the modeMap for the modeName.
        final modeMap = result.putIfAbsent(modeName!, () => <String, T>{});
        //Figma allows variables with same names.
        //Here we check if we are overwriting something.
        final existingValue = modeMap.putIfAbsent(
          variable.name,
          () => resultValue,
        );
        if (existingValue != resultValue) {
          print(
              'Warning: Override value for variable ${variable.name} in mode $modeName. '
              'Existing value: $existingValue, new value: $resultValue');
        }
      });
    }
    return result;
  }

  /// Fetches and returns the locale variables and variable collections
  /// associated with a Figma file.
  ///
  /// Parameters:
  /// - [fileId]: The unique identifier of the Figma file to fetch variables from.
  /// - [token]: The authentication token for accessing the Figma API.
  ///
  /// Returns:
  /// A [Future] that resolves to a [VariableResponse] object containing the fetched
  /// variables and variable collections.
  ///
  /// Throws:
  /// - [FigmaError]: If there is an issue with the Figma API request.
  Future<figma_datasource.VariablesResponse> _getLocaleVariables({
    required String fileId,
    required String token,
  }) async {
    final client = figma_datasource.FigmaClient(token);
    //TODO gracefully handle any exceptions during the create process
    return await client.getLocalVariables(fileId);
  }

  /// Converts a Figma `VariablesResponse` DTO (Data Transfer Object) to a model
  /// representation of the variables and variable collections.
  ///
  /// Parameters:
  /// - [VariablesResponse]: The Figma `VariablesResponse` object obtained from
  ///   the datasource.
  ///
  /// Returns:
  /// A `VariablesData` object containing the converted variables and variable collections.
  VariablesData fromDtoToModel(
    figma_datasource.VariablesResponse variablesResponse,
  ) {
    final variableCollections = variablesResponse.meta.variableCollections;
    final variables = variablesResponse.meta.variables.map(
      (key, value) => MapEntry(
        key,
        Variable.fromJson(
          value.toJson(),
        ),
      ),
    );
    return (variables: variables, variableCollections: variableCollections);
  }

  /// Returns [T] for the given [alias] recursively.
  ///
  /// The [alias] parameter represents the variable alias to resolve recursively.
  /// The [variables] parameter is a [Map<String, Variable>]
  /// object containing the variables to search in.
  ///
  /// Throws [ArgumentError] if an alias points to a variable that cannot be found
  /// in the [variables] map.
  ///
  /// Throws [TypeError] if an alias points to a variable containing
  /// a different [VariableValue] than [T].
  ///
  /// If an alias points to a variable which has multiple modes,
  /// the value of the first mode is used, in accordance with Figma's behavior.
  T _getVariableModeValueRecursive<T extends VariableValue>({
    required VariableAliasValue alias,
    required Map<String, Variable> variables,
  }) {
    final current = variables[alias.value.id];
    if (current == null) {
      throw ArgumentError(
        'Could not find variable with the id: ${alias.value.id} in variables',
      );
    }
    final firstModeValue = current.valuesByMode.entries.first.value;
    if (firstModeValue is T) {
      return firstModeValue;
    } else if (firstModeValue is VariableAliasValue) {
      return _getVariableModeValueRecursive<T>(
        alias: firstModeValue,
        variables: variables,
      );
    } else {
      throw TypeError();
    }
  }
}
