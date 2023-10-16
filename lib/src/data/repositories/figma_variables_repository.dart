import 'package:figma_variables_api/figma_variables_api.dart'
    as figma_datasource;
import 'package:figmage/src/domain/models/models.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/repositories/repositories.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@visibleForTesting
typedef VariablesData = ({
  Map<String, Variable> variables,
  Map<String, figma_datasource.VariableCollection> variableCollections
});

class FigmaVariablesRepository implements VariablesRepository {
  /// Returns a map where the keys represent mode names, and the values are maps
  /// containing variable names and their corresponding values of type [T].
  ///It filters the variables based on the [collectionsFilter],
  /// which is a list of collection names to include. If [collectionsFilter] is null,
  /// all collections are included.
  /// Throws [TypeError] if a variable points to a different [VariableValue]
  /// type than [T].
  /// Example usage:
  /// ```dart
  /// var colorMap = _createValueModeMap<VariableColorValue>(
  ///    variables: variables,
  ///    variableCollections: variableCollections',
  /// );
  /// print(colorMap);
  /// //e.g., {'light': {'green': 0xFF00FF00}, 'dark': {'green': 0xFF008000}}
  /// ```
  @visibleForTesting
  Map<String, Map<String, Map<String, T>>>
      createValueModeMap<T, V extends Variable>({
    required List<Variable> variables,
  }) {
    // assert(
    //   V != Variable,
    //   'Type argument T must be a specific type of variable.',
    // );

    //CollectionID, ModeName, ValueName, Value
    final result = <String, Map<String, Map<String, T>>>{};

    //clean data
    final cleanedVariables = variables.whereType<V>();
    for (final variable in cleanedVariables) {
      //This creates or get the collectionsMap
      final collectionMap = result.putIfAbsent(
        variable.variableCollectionId,
        () => <String, Map<String, T>>{},
      );
      variable.valuesByMode.forEach((modeId, aliasOr) {
        //This creates or get the modeMap
        final modeMap = collectionMap.putIfAbsent(modeId, () => <String, T>{});
        final existingValue = modeMap.putIfAbsent(
          variable.name,
          () => (aliasOr as AliasOrData).data as T,
        );
        if (existingValue != (aliasOr as AliasOrData).data) {
          //this should never happen now...
          print(
            'Warning: Override value for variable ${variable.name} in mode $modeId.',
          );
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
  @visibleForTesting
  VariablesData fromDtoToModel(
    figma_datasource.VariablesResponse variablesResponse,
  ) {
    final variableCollections = variablesResponse.meta.variableCollections;
    final dtoVariables = variablesResponse.meta.variables;
    final variables = dtoVariables.map((key, dtoVariable) {
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
          valuesByMode: _stringMapFromJson(dtoVariable.valuesByMode),
          collectionModeNames: collectionModeNames,
        );
        return MapEntry(
          key,
          variable,
        );
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
          valuesByMode: _boolMapFromJson(dtoVariable.valuesByMode),
          collectionModeNames: collectionModeNames,
        );
        return MapEntry(
          key,
          variable,
        );
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
          valuesByMode: _colorMapFromJson(dtoVariable.valuesByMode),
          collectionModeNames: collectionModeNames,
        );
        return MapEntry(
          key,
          variable,
        );
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
          valuesByMode: _doubleMapFromJson(dtoVariable.valuesByMode),
          collectionModeNames: collectionModeNames,
        );
        return MapEntry(
          key,
          variable,
        );
      } else {
        throw TypeError();
      }
    });

    return (variables: variables, variableCollections: variableCollections);
  }

  @override
  Future<Map<String, Variable>> getVariables({
    required String fileId,
    required String token,
  }) async {
    final (:variables, :variableCollections) =
        fromDtoToModel(await _getLocaleVariables(fileId: fileId, token: token));
    return variables;
  }

  /// Returns [AliasOrData] for the given [aliasOrAlias] recursively.
  ///
  /// The [aliasOrAlias] parameter represents the variable alias to resolve recursively.
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
  AliasOr<T> _getAliasTreeRecursive<T>({
    required AliasOr<T> aliasOr,
    required Map<String, Variable> variables,
  }) {
    if (aliasOr is AliasData) {
      return aliasOr;
    } else if (aliasOr is Alias<T>) {
      final current = variables[aliasOr.id];
      if (current == null) {
        throw ArgumentError(
          'Could not find variable with the id: ${aliasOr.id} in variables',
        );
      }
      final firstModeValue = current.valuesByMode.entries.first.value;

      if (firstModeValue is AliasData<T>) {
        return aliasOr.copyWith(aliasOrValue: firstModeValue as AliasData<T>);
      }
      if (firstModeValue is Alias<T>) {
        return _getAliasTreeRecursive(
          aliasOr: firstModeValue as Alias<T>,
          variables: variables,
        );
      }
    }
    throw TypeError();
  }

  @override
  List<Variable> resolveAliases({required Map<String, Variable> variables}) {
    final result = <Variable>[];
    variables.forEach((key, variable) {
      if (variable is BooleanVariable) {
        final values = variable.valuesByMode.map((key, aliasOr) {
          if (aliasOr is AliasOrAlias<bool>) {
            return MapEntry(
              key,
              _getVariableModeValueRecursive<bool>(
                aliasOrAlias: aliasOr,
                variables: variables,
              ),
            );
          } else {
            return MapEntry(key, aliasOr);
          }
        });
        result.add(
          variable.copyWith(
            valuesByMode: values,
          ),
        );
      } else if (variable is StringVariable) {
        final values = variable.valuesByMode.map((key, aliasOr) {
          if (aliasOr is AliasOrAlias<String>) {
            return MapEntry(
              key,
              _getVariableModeValueRecursive<String>(
                aliasOrAlias: aliasOr,
                variables: variables,
              ),
            );
          } else {
            return MapEntry(key, aliasOr);
          }
        });
        result.add(
          variable.copyWith(
            valuesByMode: values,
          ),
        );
      } else if (variable is ColorVariable) {
        final values = variable.valuesByMode.map((key, aliasOr) {
          if (aliasOr is AliasOrAlias<int>) {
            return MapEntry(
              key,
              _getVariableModeValueRecursive<int>(
                aliasOrAlias: aliasOr,
                variables: variables,
              ),
            );
          } else {
            return MapEntry(key, aliasOr);
          }
        });
        result.add(
          variable.copyWith(
            valuesByMode: values,
          ),
        );
      } else if (variable is FloatVariable) {
        final values = variable.valuesByMode.map((key, aliasOr) {
          if (aliasOr is AliasOrAlias<double>) {
            return MapEntry(
              key,
              _getVariableModeValueRecursive<double>(
                aliasOrAlias: aliasOr,
                variables: variables,
              ),
            );
          } else {
            return MapEntry(key, aliasOr);
          }
        });
        result.add(
          variable.copyWith(
            valuesByMode: values,
          ),
        );
      }
    });
    return result;
  }

  /// Conversion function for StringVariables
  Map<String, AliasOr<String>> _stringMapFromJson(
    Map<String, dynamic> jsonMap,
  ) {
    final stringMap = <String, AliasOr<String>>{};
    jsonMap.forEach((key, value) {
      if (value is String) {
        stringMap[key] = AliasOr<String>.data(
          data: (value),
        );
      } else {
        stringMap[key] = AliasOr<String>.alias(
          alias: (VariableAlias.fromJson(value)),
        );
      }
    });
    return stringMap;
  }

  // Conversion function for Color
  Map<String, AliasOr<int>> _colorMapFromJson(
    Map<String, dynamic> rgbaJsonMap,
  ) {
    final colorMap = <String, AliasOr<int>>{};
    rgbaJsonMap.forEach((key, value) {
      if (value.containsKey('r') &&
          value.containsKey('g') &&
          value.containsKey('b') &&
          value.containsKey('a')) {
        colorMap[key] = AliasOr<int>.data(
          data: (_rgbaToColor(value)),
        );
      } else {
        colorMap[key] = AliasOr<int>.alias(
          alias: (VariableAlias.fromJson(value)),
        );
      }
    });
    return colorMap;
  }

// Conversion function for Bool
  Map<String, AliasOr<bool>> _boolMapFromJson(
    Map<String, dynamic> jsonMap,
  ) {
    final boolMap = <String, AliasOr<bool>>{};
    jsonMap.forEach((key, value) {
      if (value is bool) {
        boolMap[key] = AliasOr<bool>.data(
          data: (value),
        );
      } else {
        boolMap[key] = AliasOr<bool>.alias(
          alias: (VariableAlias.fromJson(value)),
        );
      }
    });
    return boolMap;
  }

// Conversion function for Float
  Map<String, AliasOr<double>> _doubleMapFromJson(
    Map<String, dynamic> jsonMap,
  ) {
    final floatMap = <String, AliasOr<double>>{};
    jsonMap.forEach((key, value) {
      if (value is num) {
        floatMap[key] = AliasOr<double>.data(
          data: (value.toDouble()),
        );
      } else {
        floatMap[key] = AliasOr<double>.alias(
          alias: (VariableAlias.fromJson(value)),
        );
      }
    });
    return floatMap;
  }

  int _rgbaToColor(Map<String, dynamic>? rgbaJson) {
    if (rgbaJson == null) {
      throw ArgumentError('JSON object cannot be null');
    }

    for (final key in ['r', 'g', 'b', 'a']) {
      if (!rgbaJson.containsKey(key)) {
        throw FormatException('Missing key in JSON object: $key');
      }

      final value = rgbaJson[key];
      if (value is! num || value < 0 || value > 1) {
        throw FormatException(
          'Invalid value for key $key: $value (expected a number between 0 and 1)',
        );
      }
    }

    final int red = (rgbaJson['r'] * 255).round();
    final int green = (rgbaJson['g'] * 255).round();
    final int blue = (rgbaJson['b'] * 255).round();
    final int alpha = (rgbaJson['a'] * 255).round();

    return (alpha << 24) | (red << 16) | (green << 8) | blue;
  }
}
