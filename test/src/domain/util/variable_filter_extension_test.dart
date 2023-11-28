import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage/src/domain/util/token_filter_x.dart';
import 'package:test/test.dart';

import '../../../test_util/mock/mock_variables.dart';

void main() {
  group('VariableFilterX', () {
    group("filterByFrom", () {
      test("should return all if from is empty", () {
        final variables =
            mockVariables.filterByFrom(const GenerationSettings());
        expect(variables, mockVariables);
      });
      test("filters by prefix correctly", () {
        final variables = mockVariables.filterByFrom(
          const GenerationSettings(from: ['collection1/']),
        );
        expect(variables, hasLength(2));
        expect(
          variables,
          everyElement(
            isA<Variable<dynamic>>().having(
              (p0) => p0.variableCollectionName,
              "variable collection name",
              "collection1",
            ),
          ),
        );
      });
    });
    group("valuesByNameByMode", () {
      test("should return an empty map if there are no variables", () {
        final valuesByNameByMode = <Variable<dynamic>>[].valuesByNameByMode;
        expect(valuesByNameByMode, isEmpty);
      });
      test("should return a map of values by name by mode", () {
        final valuesByNameByMode = mockVariables.valuesByNameByMode;
        expect(valuesByNameByMode, {
          "light": {
            "boolName": true,
            "colorName": 0xFF000000,
            "floatName": 1,
            "stringName": "light",
          },
          "dark": {
            "boolName": false,
            "colorName": 0xFFFFFFFF,
            "floatName": 0,
            "stringName": "dark",
          },
        });
      });
    });
  });
}
