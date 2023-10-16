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
  group(
    'VariableCollection',
    () {
      group('fromJson', () {
        test('works for valid json', () {
          final (variableCollection, _) = parseJsonFromFile(
            'variable_collection_example.json',
            (json) => VariableCollectionDto.fromJson(json),
          );
          expect(variableCollection.defaultModeId, "1:0");
          expect(variableCollection.id, "VariableCollectionId:1:11");
          expect(variableCollection.name, "Sizes");
          expect(variableCollection.remote, false);
          expect(variableCollection.modes.length, 1);
          expect(
            variableCollection.modes[0],
            VariableModeDto(modeId: "1:0", name: "Mode 1"),
          );
          expect(
            variableCollection.key,
            "0ef9b579fdfca25a909eddad6b0803bf428f1708",
          );
          expect(variableCollection.hiddenFromPublishing, false);
          expect(variableCollection.variableIds, ["VariableID:1:12"]);
        });
        test('throws for invalid json', () {
          final jsonString =
              '{"someKey": "value", "someOtherKey": "someOtherValue"}';
          expect(
            () => VariableCollectionDto.fromJson(json.decode(jsonString)),
            throwsA(TypeMatcher<TypeError>()),
          );
        });
      });
      group('toJson', () {
        test('works for valid object', () {
          final variableCollection = VariableCollectionDto(
            defaultModeId: "1:0",
            id: "VariableCollectionId:1:11",
            name: "Sizes",
            remote: false,
            modes: [VariableModeDto(modeId: "1:0", name: "Mode 1")],
            key: "0ef9b579fdfca25a909eddad6b0803bf428f1708",
            hiddenFromPublishing: false,
            variableIds: ["VariableID:1:12"],
          );

          final jsonMap = variableCollection.toJson();

          expect(jsonMap, {
            "defaultModeId": "1:0",
            "id": "VariableCollectionId:1:11",
            "name": "Sizes",
            "remote": false,
            "modes": [
              {"modeId": "1:0", "name": "Mode 1"},
            ],
            "key": "0ef9b579fdfca25a909eddad6b0803bf428f1708",
            "hiddenFromPublishing": false,
            "variableIds": ["VariableID:1:12"],
          });
        });
      });
    },
  );

  group(
    'VariablesResponse',
    () {
      group('fromJson', () {
        test('works for valid json', () {
          final (variable, _) = parseJsonFromFile(
            'variable_example.json',
            (json) => VariableDto.fromJson(json),
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
        });
        test('Throws for invalid json', () {
          final jsonString =
              '{"someKey": "value", "someOtherKey": "someOtherValue"}';
          expect(
            () => VariableDto.fromJson(json.decode(jsonString)),
            throwsA(TypeMatcher<TypeError>()),
          );
        });
      });
      group('toJson', () {
        test('works for valid object', () {
          final variable = VariableDto(
            id: "VariableID:33:8",
            name: "box-background-active",
            remote: false,
            key: "db60e2b2141198dff74e59f329863257348ec9d6",
            variableCollectionId: "VariableCollectionId:33:7",
            resolvedType: "COLOR",
            description: "",
            hiddenFromPublishing: false,
            scopes: ["ALL_SCOPES"],
            codeSyntax: {
              "WEB": "box-background-active",
              "ANDROID": "box-background-active",
              "iOS": "box-background-active",
            },
            valuesByMode: {
              "33:0": {
                "type": "VARIABLE_ALIAS",
                "id": "VariableID:28:14",
              },
            },
          );

          final jsonMap = variable.toJson();

          expect(jsonMap, {
            "id": "VariableID:33:8",
            "name": "box-background-active",
            "remote": false,
            "key": "db60e2b2141198dff74e59f329863257348ec9d6",
            "variableCollectionId": "VariableCollectionId:33:7",
            "resolvedType": "COLOR",
            "description": "",
            "hiddenFromPublishing": false,
            "scopes": ["ALL_SCOPES"],
            "codeSyntax": {
              "WEB": "box-background-active",
              "ANDROID": "box-background-active",
              "iOS": "box-background-active",
            },
            "valuesByMode": {
              "33:0": {
                "type": "VARIABLE_ALIAS",
                "id": "VariableID:28:14",
              },
            },
          });
        });
      });
    },
  );

  group('VariablesResponse', () {
    group('fromJson', () {
      test('works for valid json', () {
        final (variablesResponse, jsonMap) = parseJsonFromFile(
          'variables_response_example.json',
          (json) => VariablesResponseDto.fromJson(json),
        );

        expect(variablesResponse.status, 200);
        expect(variablesResponse.error, false);

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

        final variable11 = variablesResponse.meta.variables['VariableID:28:11'];
        expect(variable11!.scopes, ['ALL_SCOPES']);
        expect(variable11.codeSyntax, {});

        final variable33_8 =
            variablesResponse.meta.variables['VariableID:33:8'];

        expect(variable33_8!.scopes, ['ALL_SCOPES']);
        expect(
          variable33_8.codeSyntax,
          {
            'WEB': 'box-background-active',
            'ANDROID': 'box-background-active',
            'iOS': 'box-background-active',
          },
        );

        final serializedJson = variablesResponse.toJson();

        expect(serializedJson, jsonMap);
      });

      test('throws for invalid json', () {
        final jsonString =
            '{"someKey": "value", "someOtherKey": "someOtherValue"}';
        expect(
          () => VariablesResponseDto.fromJson(json.decode(jsonString)),
          throwsA(TypeMatcher<TypeError>()),
        );
      });
    });
    test('works for valid object', () {
      final variablesResponse = VariablesResponseDto(
        status: 200,
        error: false,
        meta: VariablesMetaDto(
          variableCollections: {
            'VariableCollectionId:1:11': VariableCollectionDto(
              defaultModeId: '1:0',
              id: 'VariableCollectionId:1:11',
              name: 'Sizes',
              remote: false,
              key: '0ef9b579fdfca25a909eddad6b0803bf428f1708',
              hiddenFromPublishing: false,
              variableIds: ['VariableID:1:12'],
              modes: [VariableModeDto(modeId: '1:0', name: 'Mode 1')],
            ),
          },
          variables: {
            'VariableID:1:12': VariableDto(
              id: 'VariableID:1:12',
              name: 'small',
              remote: false,
              key: '2e91fbae8fc380794adf6ac35c03f9fb8d9033c4',
              variableCollectionId: 'VariableCollectionId:1:11',
              resolvedType: 'FLOAT',
              description: '',
              hiddenFromPublishing: false,
              scopes: ['ALL_SCOPES'],
              codeSyntax: {},
              valuesByMode: {
                "33:0": {
                  "type": "VARIABLE_ALIAS",
                  "id": "VariableID:28:14",
                },
              },
            ),
          },
        ),
      );

      final serializedJson = variablesResponse.toJson();

      final expectedJson = {
        'status': 200,
        'error': false,
        'meta': {
          'variableCollections': {
            'VariableCollectionId:1:11': {
              'defaultModeId': '1:0',
              'id': 'VariableCollectionId:1:11',
              'name': 'Sizes',
              'remote': false,
              'key': '0ef9b579fdfca25a909eddad6b0803bf428f1708',
              'hiddenFromPublishing': false,
              'variableIds': ['VariableID:1:12'],
              'modes': [
                {'modeId': '1:0', 'name': 'Mode 1'},
              ],
            },
          },
          'variables': {
            'VariableID:1:12': {
              'id': 'VariableID:1:12',
              'name': 'small',
              'remote': false,
              'key': '2e91fbae8fc380794adf6ac35c03f9fb8d9033c4',
              'variableCollectionId': 'VariableCollectionId:1:11',
              'resolvedType': 'FLOAT',
              'description': '',
              'hiddenFromPublishing': false,
              'scopes': ['ALL_SCOPES'],
              'codeSyntax': {},
              'valuesByMode': {
                "33:0": {
                  "type": "VARIABLE_ALIAS",
                  "id": "VariableID:28:14",
                },
              },
            },
          },
        },
      };

      // Verify that the serialized JSON matches the expected JSON
      expect(serializedJson, expectedJson);
    });
  });
}
