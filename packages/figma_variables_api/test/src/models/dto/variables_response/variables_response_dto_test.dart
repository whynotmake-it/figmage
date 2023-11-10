import 'dart:convert';

import 'package:figma_variables_api/src/models/dto/variable/variable_dto.dart';
import 'package:figma_variables_api/src/models/dto/variable_collection/variable_collection_dto.dart';
import 'package:figma_variables_api/src/models/dto/variable_mode/variable_mode_dto.dart';
import 'package:figma_variables_api/src/models/dto/variable_mode_value/variable_mode_value_dto.dart';
import 'package:figma_variables_api/src/models/dto/variable_response/variables_response_dto.dart';
import 'package:figma_variables_api/src/models/dto/variables_meta/variables_meta_dto.dart';
import 'package:test/test.dart';

import '../../../../util/parse_json_from_file.dart';

void main() {
  group('props', () {
    test('contains the same amount of keys as json', () async {
      final (variablesResponse, json) = parseJsonFromFile(
        'variables_response_example.json',
        (json) => VariablesResponseDto.fromJson(json),
      );
      expect(variablesResponse.props.length, equals(json.keys.length));
    });
  });
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
              "33:0": VariableModeAliasDto(
                id: "VariableID:28:14",
                type: 'VARIABLE_ALIAS',
              ),
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
}
