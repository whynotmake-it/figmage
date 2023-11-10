import 'dart:convert';

import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:test/test.dart';

import '../../../../util/parse_json_from_file.dart';

void main() {
  final sut = VariableCollectionDto(
    defaultModeId: "defaultModeId",
    id: "id",
    name: "name",
    remote: true,
    modes: [],
    key: "key",
    hiddenFromPublishing: true,
    variableIds: [],
  );

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

  group('props', () {
    test('contains as many values as keys in json', () async {
      final json = sut.toJson();
      expect(json.keys.length, equals(sut.props.length));
    });
  });

  group('==', () {
    test('two identical objects are equal', () async {
      final b = VariableCollectionDto(
        defaultModeId: "defaultModeId",
        id: "id",
        name: "name",
        remote: true,
        modes: [],
        key: "key",
        hiddenFromPublishing: true,
        variableIds: [],
      );
      expect(sut, equals(b));
    });
    test('two objects with different defaultModeId are not equal', () async {
      final b = VariableCollectionDto(
        defaultModeId: "defaultModeId2",
        id: "id",
        name: "name",
        remote: true,
        modes: [],
        key: "key",
        hiddenFromPublishing: true,
        variableIds: [],
      );
      expect(sut, isNot(equals(b)));
    });
  });
}
