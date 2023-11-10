import 'dart:convert';

import 'package:figma_variables_api/src/models/dto/variable/variable_dto.dart';
import 'package:figma_variables_api/src/models/dto/variable_mode_value/variable_mode_value_dto.dart';
import 'package:test/test.dart';

import '../../../../util/parse_json_from_file.dart';

void main() {
  group('copyWith', () {
    test('updates the name', () {
      final variable = VariableDto(
        id: "VariableID:33:8",
        name: "box-background-active",
        remote: false,
        key: "db60e2b2141198dff74e59f329863257348ec9d6",
        variableCollectionId: "VariableCollectionId:33:7",
        resolvedType: "COLOR",
        description: "",
        hiddenFromPublishing: false,
        scopes: [],
        codeSyntax: {},
        valuesByMode: {},
      );

      final updatedVariable = variable.copyWith(name: 'newName');

      expect(updatedVariable.name, 'newName');
    });
  });
  group('props', () {
    test('contains the same amount of keys as json', () async {
      final (variable, json) = parseJsonFromFile(
        'variable_example.json',
        (json) => VariableDto.fromJson(json),
      );
      expect(variable.props.length, equals(json.keys.length));
    });
  });
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
          "33:0": VariableModeAliasDto(
            id: "VariableID:28:14",
            type: 'VARIABLE_ALIAS',
          ),
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
}
