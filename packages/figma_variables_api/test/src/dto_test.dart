import 'dart:convert';
import 'dart:io';
import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:test/test.dart';

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

void main() {
  group('VariablesResponse', () {
    test('VariableCollection deserialization and serialization', () {
      final (variableCollection, jsonMap) = parseJsonFromFile(
        'variable_collection_example.json',
        (json) => VariableCollection.fromJson(json),
      );

      // Verify that the deserialized object has the expected properties.
      expect(variableCollection.defaultModeId, "1:0");
      expect(variableCollection.id, "VariableCollectionId:1:11");
      expect(variableCollection.name, "Sizes");
      expect(variableCollection.remote, false);
      expect(variableCollection.modes.length, 1);
      expect(
        variableCollection.modes[0],
        VariableMode(modeId: "1:0", name: "Mode 1"),
      );
      expect(
        variableCollection.key,
        "0ef9b579fdfca25a909eddad6b0803bf428f1708",
      );
      expect(variableCollection.hiddenFromPublishing, false);
      expect(variableCollection.variableIds, ["VariableID:1:12"]);

      // Serialize the VariableCollection object back to JSON.
      final serializedJson = variableCollection.toJson();

      // Verify that the serialized JSON matches the original JSON.
      expect(serializedJson, jsonMap);
    });

    test('Variable deserialization and serialization', () {
      final (variable, jsonMap) = parseJsonFromFile(
        'variable_example.json',
        (json) => Variable.fromJson(json),
      );

      expect(variable.id, "VariableID:33:8");
      expect(variable.name, "box-background-active");
      expect(variable.remote, false);
      expect(
        variable.key,
        "db60e2b2141198dff74e59f329863257348ec9d6",
      );
      expect(
        variable.variableCollectionId,
        "VariableCollectionId:33:7",
      );
      expect(variable.resolvedType, "COLOR");
      expect(variable.description, "");
      expect(variable.hiddenFromPublishing, false);

      expect(variable.scopes, ["ALL_SCOPES"]);
      expect(
        variable.codeSyntax,
        {
          "WEB": "box-background-active",
          "ANDROID": "box-background-active",
          "iOS": "box-background-active",
        },
      );

      // Serialize the Variable object back to JSON
      final serializedJson = variable.toJson();

      // Verify that the serialized JSON matches the original JSON
      expect(serializedJson, jsonMap);
    });

    test('VariablesResponse deserialization and serialization', () {
      final (variablesResponse, jsonMap) = parseJsonFromFile(
        'variables_response_example.json',
        (json) => VariablesResponse.fromJson(json),
      );

      // Basic Parsing and Property Validation
      expect(variablesResponse.status, 200);
      expect(variablesResponse.error, false);

      // Parsing Variable Collections
      expect(
        variablesResponse.meta.variableCollections.length,
        5,
      );

      final variableCollection1 = variablesResponse
          .meta.variableCollections['VariableCollectionId:1:11'];
      expect(variableCollection1, isNotNull);
      expect(variableCollection1!.defaultModeId, '1:0');
      expect(variableCollection1.id, 'VariableCollectionId:1:11');
      expect(variableCollection1.name, 'Sizes');
      expect(variableCollection1.remote, false);
      expect(
        variableCollection1.key,
        '0ef9b579fdfca25a909eddad6b0803bf428f1708',
      );
      expect(variableCollection1.hiddenFromPublishing, false);
      expect(variableCollection1.variableIds, contains('VariableID:1:12'));
      expect(variableCollection1.modes.length, 1);
      expect(variableCollection1.modes[0].modeId, '1:0');
      expect(variableCollection1.modes[0].name, 'Mode 1');

      // Parsing Variables
      expect(
        variablesResponse.meta.variables.length,
        11,
      );

      final variable1 = variablesResponse.meta.variables['VariableID:1:12'];

      expect(variable1, isNotNull);
      expect(variable1!.id, 'VariableID:1:12');
      expect(variable1.name, 'small');
      expect(variable1.remote, false);
      expect(variable1.key, '2e91fbae8fc380794adf6ac35c03f9fb8d9033c4');
      expect(variable1.variableCollectionId, 'VariableCollectionId:1:11');
      expect(variable1.resolvedType, 'FLOAT');
      expect(variable1.description, '');
      expect(variable1.hiddenFromPublishing, false);

      expect(variable1.scopes, ['ALL_SCOPES']);
      expect(variable1.codeSyntax, {});

      // Additional Validation
      final variable11 = variablesResponse.meta.variables['VariableID:28:11'];
      expect(variable11!.scopes, ['ALL_SCOPES']);
      expect(variable11.codeSyntax, {});

      final variable33_8 = variablesResponse.meta.variables['VariableID:33:8'];

      expect(variable33_8!.scopes, ['ALL_SCOPES']);
      expect(
        variable33_8.codeSyntax,
        {
          'WEB': 'box-background-active',
          'ANDROID': 'box-background-active',
          'iOS': 'box-background-active',
        },
      );

      // Serialize the Variable object back to JSON
      final serializedJson = variablesResponse.toJson();

      // Verify that the serialized JSON matches the original JSON
      expect(serializedJson, jsonMap);
    });
  });
}
