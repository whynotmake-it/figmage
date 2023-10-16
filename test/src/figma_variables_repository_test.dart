import 'dart:convert';
import 'dart:io';

import 'package:figma_variables_api/figma_variables_api.dart';
// import 'package:figmage/src/data/repositories/figma_variables_repository.dart';
import 'package:figmage/src/data/repositories/scratch.dart';
import 'package:figmage/src/domain/models/models.dart';
import 'package:test/test.dart';

void main() {
  //helper function to load json
  (T, Map<String, dynamic>) parseJsonFromFile<T>(
    String relativePath,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final currentDirectory = Directory.current.path;
    final filePath = '$currentDirectory/test/src/mock_data/$relativePath';

    final jsonString = File(filePath).readAsStringSync();
    final jsonMap = json.decode(jsonString);

    return (fromJson(jsonMap), jsonMap);
  }

  group('fill aliases with aliases as tree', () {
    final (variablesResponse, _) = parseJsonFromFile(
      'variables_response_example.json',
      (json) => VariablesResponse.fromJson(json),
    );

    final variable = variablesResponse.meta.variables.values.first;

    variable.valuesByMode.forEach((key, value) {
      final result = getAliasTreeRecursive(
        aliasOr: value,
        variables: variablesResponse.meta.variables,
      );
      print(result);
    });
  });

  group('fromDtoToModel', () {
    // test('Converts a  VariablesResponse DTO to VariablesData', () {
    //   final (variablesResponse, _) = parseJsonFromFile(
    //     'variables_response_example.json',
    //     (json) => VariablesResponse.fromJson(json),
    //   );
    //   final repository = FigmaVariablesRepository();
    //   final result = repository.fromDtoToModel(variablesResponse);
    //   expect(result, isA<VariablesData>());
    // });
    // test('Converts a VariableData to a colorMap', () {
    //   final (variablesResponse, _) = parseJsonFromFile(
    //     'variables_response_example.json',
    //     (json) => VariablesResponse.fromJson(json),
    //   );
    //   final repository = FigmaVariablesRepository();
    //   final variableData = repository.fromDtoToModel(variablesResponse);
    //   final resolved =
    //       repository.resolveAliases(variables: variableData.variables);
    //   final colorMap = repository.createValueModeMap<int, ColorVariable>(
    //     variables: resolved,
    //   );
    //   print(colorMap);
    //   expect(colorMap, isA<Map<String, Map<String, Map<String, int>>>>());
    // Add specific expect statements for keys and their values
    // expect(
    //   colorMap['lightMode']!['colorWith2Aliases'],
    //   VariableValue.color(4294967295),
    // );
    // expect(
    //   colorMap['darkMode']!['colorWith2Aliases'],
    //   VariableValue.color(4278190080),
    // );
    // expect(
    //   colorMap['Mode 1']!['blue500'],
    //   VariableValue.color(4294967295),
    // );
    // expect(
    //   colorMap['Mode 1']!['blue800'],
    //   VariableValue.color(4278190080),
    // );
    // expect(
    //   colorMap['Mode 1']!['red500'],
    //   VariableValue.color(4294967295),
    // );
    // expect(
    //   colorMap['Mode 1']!['red800'],
    //   VariableValue.color(4278190080),
    // );
  });

  // test('Converts a VariableData to a numberMap', () {
  //   final (variablesResponse, _) = parseJsonFromFile(
  //     'variables_response_example.json',
  //     (json) => VariablesResponse.fromJson(json),
  //   );
  //   final repository = FigmaVariablesRepository();
  //   final variableData = repository.fromDtoToModel(variablesResponse);
  //
  //   final numberMap = repository.createValueModeMap<NumberValue>(
  //     variables: variableData.variables,
  //     variableCollections: variableData.variableCollections,
  //   );
  //   expect(numberMap, {
  //     'Mode 1': {'small': VariableValue.number(17.0)},
  //     'Mode 2': {'small': VariableValue.number(17.0)},
  //     'lightMode': {
  //       'NumberWith2Aliases': VariableValue.number(17.0),
  //       'NumberWithAlias': VariableValue.number(17.0),
  //       'number': VariableValue.number(17.0),
  //     },
  //     'darkMode': {
  //       'NumberWith2Aliases': VariableValue.number(17.0),
  //       'NumberWithAlias': VariableValue.number(17.0),
  //       'number': VariableValue.number(12.0),
  //     },
  //     'light': {'large': VariableValue.number(17.0)},
  //     'dark': {'large': VariableValue.number(27.0)},
  //   });
  // });
  //
  // test('Converts a VariableData to a stringMap', () {
  //   final (variablesResponse, _) = parseJsonFromFile(
  //     'variables_response_example.json',
  //     (json) => VariablesResponse.fromJson(json),
  //   );
  //   final repository = FigmaVariablesRepository();
  //   final variableData = repository.fromDtoToModel(variablesResponse);
  //
  //   final stringMap = repository.createValueModeMap<StringValue>(
  //     variables: variableData.variables,
  //     variableCollections: variableData.variableCollections,
  //   );
  //   expect(stringMap, {
  //     'lightMode': {'schrift': VariableValue.string('light')},
  //     'darkMode': {'schrift': VariableValue.string('dark')},
  //     'Mode 1': {
  //       'light': VariableValue.string('light'),
  //       'dark': VariableValue.string('dark'),
  //     },
  //   });
  // });
  //
  // test('Converts a VariableData to a colorMap', () {
  //   final (variablesResponse, _) = parseJsonFromFile(
  //     'variables_response_example.json',
  //     (json) => VariablesResponse.fromJson(json),
  //   );
  //   final repository = FigmaVariablesRepository();
  //   final variableData = repository.fromDtoToModel(variablesResponse);
  //
  //   final booleanMap = repository.createValueModeMap<BooleanValue>(
  //     variables: variableData.variables,
  //     variableCollections: variableData.variableCollections,
  //   );
  //   expect(booleanMap, {
  //     'lightMode': {'wahr': VariableValue.boolean(false)},
  //     'darkMode': {'wahr': VariableValue.boolean(true)},
  //     'Mode 1': {'Boolean': VariableValue.boolean(true)},
  //   });
  // });
  // });
}
