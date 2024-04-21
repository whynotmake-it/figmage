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
        expect(variables, hasLength(3));
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
          'light': {
            'boolName': true,
            'colorName': 4278190080,
            'colorNameUnresolvable': 11184810,
            'floatName': 1.0,
            'stringName': 'light',
          },
          'dark': {
            'boolName': false,
            'colorName': 4294967295,
            'colorNameUnresolvable': null,
            'floatName': 0.0,
            'stringName': 'dark',
          },
        });
      });

      test("should order modes alphabetically", () {
        final valuesByNameByMode = mockVariables.valuesByNameByMode;
        expect(valuesByNameByMode.keys, containsAllInOrder(["dark", "light"]));
      });

      test("should order names alphabetically", () {
        final valuesByNameByMode = mockVariables.valuesByNameByMode;
        expect(
          valuesByNameByMode.values,
          everyElement(
            isA<Map<String, dynamic>>().having(
              (p0) => p0.keys,
              "keys",
              containsAllInOrder([
                "boolName",
                "colorName",
                "floatName",
                "stringName",
              ]),
            ),
          ),
        );
      });
    });
  });
}
