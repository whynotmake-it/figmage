import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockFigmaClient extends Mock implements FigmaClient {}

void main() {
  group('FigmaClient', () {
    late MockFigmaClient mockClient;
    final fileId = 'fileId';

    setUp(() {
      mockClient = MockFigmaClient();
    });

    final successJson = {
      "status": 200,
      "error": false,
      "meta": {
        "variableCollections": {
          "VariableCollectionId:1:2": {
            "defaultModeId": "1:0",
            "id": "VariableCollectionId:1:2",
            "name": "colors",
            "remote": false,
            "modes": [
              {"modeId": "1:0", "name": "light"},
              {"modeId": "1:1", "name": "dark"},
            ],
            "key": "3f63d5816fbb74f3aed4ae2cb3dbd3f1488037a8",
            "hiddenFromPublishing": false,
            "variableIds": ["VariableID:1:3", "VariableID:1:4"],
          },
          "VariableCollectionId:1:5": {
            "defaultModeId": "1:2",
            "id": "VariableCollectionId:1:5",
            "name": "semantic",
            "remote": false,
            "modes": [
              {"modeId": "1:2", "name": "light"},
              {"modeId": "1:3", "name": "dark"},
            ],
            "key": "ec89a35a737d6d6d10be79952fb6743f0251bdb5",
            "hiddenFromPublishing": false,
            "variableIds": ["VariableID:1:6"],
          },
        },
        "variables": {
          "VariableID:1:3": {
            "id": "VariableID:1:3",
            "name": "mobile/green",
            "remote": false,
            "key": "78da5ee94aaa09f838e4930f42b079b6084ab2b4",
            "variableCollectionId": "VariableCollectionId:1:2",
            "resolvedType": "COLOR",
            "description": "",
            "hiddenFromPublishing": false,
            "valuesByMode": {
              "1:0": {
                "r": 0.3087500035762787,
                "g": 0.9750000238418579,
                "b": 0.6552000641822815,
                "a": 1,
              },
              "1:1": {
                "r": 0.08684027940034866,
                "g": 0.34166666865348816,
                "b": 0.21935009956359863,
                "a": 1,
              },
            },
            "scopes": ["ALL_SCOPES"],
            "codeSyntax": {},
          },
          "VariableID:1:4": {
            "id": "VariableID:1:4",
            "name": "desktop/green",
            "remote": false,
            "key": "84b4e321744d346c1ced1d5fbcd86ce00a8267b8",
            "variableCollectionId": "VariableCollectionId:1:2",
            "resolvedType": "COLOR",
            "description": "",
            "hiddenFromPublishing": false,
            "valuesByMode": {
              "1:0": {
                "r": 0.5916666388511658,
                "g": 1,
                "b": 0.6814999580383301,
                "a": 1,
              },
              "1:1": {
                "r": 0.41356873512268066,
                "g": 0.7875000238418579,
                "b": 0.28218749165534973,
                "a": 1,
              },
            },
            "scopes": ["ALL_SCOPES"],
            "codeSyntax": {},
          },
          "VariableID:1:6": {
            "id": "VariableID:1:6",
            "name": "mobile/green",
            "remote": false,
            "key": "d83bf4b5d61ecac59926728812c59bfa50898245",
            "variableCollectionId": "VariableCollectionId:1:5",
            "resolvedType": "COLOR",
            "description": "",
            "hiddenFromPublishing": false,
            "valuesByMode": {
              "1:2": {"type": "VARIABLE_ALIAS", "id": "VariableID:1:3"},
              "1:3": {"type": "VARIABLE_ALIAS", "id": "VariableID:1:3"},
            },
            "scopes": ["ALL_SCOPES"],
            "codeSyntax": {},
          },
        },
      },
    };

    test(
        'getLocalVariables should parse VariablesResponseDto from provided JSON',
        () async {
      when(() => mockClient.getLocalVariables(fileId)).thenAnswer(
        (_) async => VariablesResponseDto.fromJson(successJson),
      );

      final result = await mockClient.getLocalVariables(fileId);

      expect(result, isA<VariablesResponseDto>());
      expect(result.status, equals(200));
      expect(
        result.meta.variableCollections.keys,
        contains('VariableCollectionId:1:2'),
      );
      expect(
        result.meta.variableCollections.keys,
        contains('VariableCollectionId:1:5'),
      );
      expect(
        result.meta.variableCollections['VariableCollectionId:1:2']!.name,
        equals('colors'),
      );
      expect(
        result
            .meta.variableCollections['VariableCollectionId:1:2']!.modes.length,
        2,
      );
      expect(result.meta.variables.keys, contains('VariableID:1:3'));
      expect(result.meta.variables.keys, contains('VariableID:1:6'));
      expect(
        result.meta.variables['VariableID:1:3']!.name,
        equals('mobile/green'),
      );
      expect(
        result.meta.variables['VariableID:1:3']!.resolvedType,
        equals('COLOR'),
      );
    });

    test(
      'throws an Exception when the HTTP call fails',
      () async {
        when(() => mockClient.getLocalVariables(fileId)).thenThrow(
          Exception('Failed to load local variables'),
        );
        expect(
          () async {
            await mockClient.getLocalVariables(fileId);
          },
          throwsA(isA<Exception>()),
        );
      },
    );
  });
}
