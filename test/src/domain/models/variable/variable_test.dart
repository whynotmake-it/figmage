import 'package:test/test.dart';

import '../../../../test_util/mock/mock_variables.dart';

void main() {
  group('Variable', () {
    group('fullName', () {
      test('should return the name if collection is empty', () {
        final mockVariableWithEmptyCollection =
            mockBoolVariable.copyWith(variableCollectionName: "");
        expect(
          mockVariableWithEmptyCollection.fullName,
          mockVariableWithEmptyCollection.name,
        );
      });
      test('should put slash between collection name and variable name', () {
        expect(mockBoolVariable.fullName, 'collection1/boolName');
      });
    });
  });
}
