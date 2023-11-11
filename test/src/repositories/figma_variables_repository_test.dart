import 'dart:convert';
import 'dart:io';

import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:figmage/src/data/repositories/figma_variables_repository.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';

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
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

    return (fromJson(jsonMap), jsonMap);
  }

  group('fromDtoToModel', () {
    test('Converts a  VariablesResponse DTO to VariablesData', () {
      final (variablesResponseDto, _) = parseJsonFromFile(
        'variables_response_example.json',
        VariablesResponseDto.fromJson,
      );
      final repository = FigmaVariablesRepository();
      final variables = repository.fromDtoToModel(variablesResponseDto);

      expect(variables, isA<List<Variable>>());
    });

    test('Converts a List<Variable> to a colorMap using names', () {
      final (variablesResponse, _) = parseJsonFromFile(
        'variables_response_example.json',
        VariablesResponseDto.fromJson,
      );
      final repository = FigmaVariablesRepository();
      final variables = repository.fromDtoToModel(variablesResponse);
      final colorMap = repository.createValueModeMap<int, ColorVariable>(
        variables: variables,
      );
      expect(
        colorMap['semantic']!['lightMode']!['colorWith2Aliases'],
        equals(4294967295),
      );
      expect(
        colorMap['semantic']!['lightMode']!['colorWithAlias'],
        equals(4294967295),
      );
      expect(
        colorMap['semantic']!['lightMode']!['color'],
        equals(4294967295),
      );

      expect(
        colorMap['semantic']!['darkMode']!['colorWith2Aliases'],
        equals(4278190080),
      );
      expect(
        colorMap['semantic']!['darkMode']!['colorWithAlias'],
        equals(4278190080),
      );
      expect(
        colorMap['semantic']!['darkMode']!['color'],
        equals(4278190080),
      );

      expect(
        colorMap['core']!['Mode 1']!['blue500'],
        equals(4294967295),
      );
      expect(
        colorMap['core']!['Mode 1']!['blue800'],
        equals(4278190080),
      );
      expect(
        colorMap['core']!['Mode 1']!['red500'],
        equals(4294967295),
      );
      expect(
        colorMap['core']!['Mode 1']!['red800'],
        equals(4278190080),
      );
    });

    test('Converts a List<Variable> to a colorMap with ids', () {
      final (variablesResponse, _) = parseJsonFromFile(
        'variables_response_example.json',
        VariablesResponseDto.fromJson,
      );
      final repository = FigmaVariablesRepository();
      final variables = repository.fromDtoToModel(variablesResponse);
      final colorMap = repository.createValueModeMap<int, ColorVariable>(
        variables: variables,
        useNames: false,
      );

      expect(
        colorMap['VariableCollectionId:28:10']!['28:3']!['VariableID:28:11'],
        equals(4294967295),
      );
      expect(
        colorMap['VariableCollectionId:28:10']!['28:3']!['VariableID:33:4'],
        equals(4294967295),
      );
      expect(
        colorMap['VariableCollectionId:28:10']!['28:3']!['VariableID:114:5'],
        equals(4294967295),
      );

      expect(
        colorMap['VariableCollectionId:28:10']!['28:4']!['VariableID:28:11'],
        equals(4278190080),
      );
      expect(
        colorMap['VariableCollectionId:28:10']!['28:4']!['VariableID:33:4'],
        equals(4278190080),
      );
      expect(
        colorMap['VariableCollectionId:28:10']!['28:4']!['VariableID:114:5'],
        equals(4278190080),
      );

      expect(
        colorMap['VariableCollectionId:28:7']!['28:2']!['VariableID:28:9'],
        equals(4294967295),
      );
      expect(
        colorMap['VariableCollectionId:28:7']!['28:2']!['VariableID:28:12'],
        equals(4278190080),
      );
      expect(
        colorMap['VariableCollectionId:28:7']!['28:2']!['VariableID:33:2'],
        equals(4294967295),
      );
      expect(
        colorMap['VariableCollectionId:28:7']!['28:2']!['VariableID:33:3'],
        equals(4278190080),
      );
    });

    test('Converts a List<Variable> to a numberMap using names', () {
      final (variablesResponse, _) = parseJsonFromFile(
        'variables_response_example.json',
        VariablesResponseDto.fromJson,
      );
      final repository = FigmaVariablesRepository();
      final variables = repository.fromDtoToModel(variablesResponse);
      final numberMap = repository.createValueModeMap<double, FloatVariable>(
        variables: variables,
      );
      expect(numberMap['Sizes']!['Mode 1']!['small'], equals(17.0));
      expect(numberMap['Sizes']!['Mode 2']!['small'], equals(17.0));

      expect(
        numberMap['semantic']!['lightMode']!['NumberWith2Aliases'],
        equals(17.0),
      );
      expect(
        numberMap['semantic']!['lightMode']!['NumberWithAlias'],
        equals(17.0),
      );
      expect(numberMap['semantic']!['lightMode']!['number'], equals(17.0));

      expect(
        numberMap['semantic']!['darkMode']!['NumberWith2Aliases'],
        equals(17.0),
      );
      expect(
        numberMap['semantic']!['darkMode']!['NumberWithAlias'],
        equals(17.0),
      );
      expect(numberMap['semantic']!['darkMode']!['number'], equals(12.0));

      expect(numberMap['BaseSize']!['light']!['large'], equals(17.0));
      expect(numberMap['BaseSize']!['dark']!['large'], equals(27.0));
    });

    test('Converts a List<Variable> to a booleanMap using names', () {
      final (variablesResponse, _) = parseJsonFromFile(
        'variables_response_example.json',
        VariablesResponseDto.fromJson,
      );
      final repository = FigmaVariablesRepository();
      final variables = repository.fromDtoToModel(variablesResponse);
      final booleanMap = repository.createValueModeMap<bool, BooleanVariable>(
        variables: variables,
      );

      expect(booleanMap['semantic']!['lightMode']!['wahr'], equals(false));
      expect(booleanMap['semantic']!['darkMode']!['wahr'], equals(true));
      expect(booleanMap['core']!['Mode 1']!['Boolean'], equals(true));
    });

    test('Converts a List<Variable> to a stringMap using names', () {
      final (variablesResponse, _) = parseJsonFromFile(
        'variables_response_example.json',
        VariablesResponseDto.fromJson,
      );
      final repository = FigmaVariablesRepository();
      final variables = repository.fromDtoToModel(variablesResponse);
      final stringMap = repository.createValueModeMap<String, StringVariable>(
        variables: variables,
      );

      expect(stringMap['semantic']!['lightMode']!['schrift'], equals('light'));
      expect(stringMap['semantic']!['darkMode']!['schrift'], equals('dark'));
      expect(stringMap['core']!['Mode 1']!['light'], equals('light'));
      expect(stringMap['core']!['Mode 1']!['dark'], equals('dark'));
    });
  });
}
