import 'package:figma/figma.dart';
import 'package:figmage/src/data/repositories/figma_variables_repository.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage/src/domain/models/variable/variable_type.dart' as domain;

import 'package:test/test.dart';

void main() {
  const variablesResponse = LocalVariablesResponse(
    meta: LocalVariablesMeta(
      variableCollections: {
        'VariableCollectionId:0:3': LocalVariableCollection(
          defaultModeId: '0:0',
          id: 'VariableCollectionId:0:3',
          name: 'collection',
          remote: false,
          modes: [
            Mode(modeId: '0:0', name: 'dark'),
            Mode(modeId: '1:0', name: 'light'),
          ],
          key: 'c32721b87efc240c6286c911cd457cf0384f7a34',
          hiddenFromPublishing: false,
          variableIds: [
            'VariableID:1:2',
            'VariableID:2:3',
            'VariableID:2:4',
            'VariableID:2:5',
          ],
        ),
      },
      variables: {
        'VariableID:1:2': LocalVariable(
          id: 'VariableID:1:2',
          name: 'green',
          remote: false,
          key: '26a211e627a2da8a80c0f06e0b776ba97a8780e3',
          variableCollectionId: 'VariableCollectionId:0:3',
          resolvedType: VariableResolvedDataType.color,
          description: '',
          hiddenFromPublishing: false,
          valuesByMode: {
            '0:0': Rgba(r: 0.708, g: 1, b: 0.0875, a: 1),
            '1:0': Rgba(r: 0.4666, g: 0.7541, b: 0.1006, a: 1),
          },
          scopes: [VariableScope.allScopes],
          codeSyntax: VariableCodeSyntax(),
        ),
        'VariableID:2:3': LocalVariable(
          id: 'VariableID:2:3',
          name: 'number',
          remote: false,
          key: '08c82898f886945e11a01e68840677696fa360b6',
          variableCollectionId: 'VariableCollectionId:0:3',
          resolvedType: VariableResolvedDataType.float,
          description: '',
          hiddenFromPublishing: false,
          valuesByMode: {
            '0:0': 1.0,
            '1:0': 0.0,
          },
          scopes: [VariableScope.allScopes],
          codeSyntax: VariableCodeSyntax(),
        ),
        'VariableID:2:4': LocalVariable(
          id: 'VariableID:2:4',
          name: 'string',
          remote: false,
          key: '347bb41e0005e314c7ed7474d85bb804686bed58',
          variableCollectionId: 'VariableCollectionId:0:3',
          resolvedType: VariableResolvedDataType.string,
          description: '',
          hiddenFromPublishing: false,
          valuesByMode: {
            '0:0': 'dark',
            '1:0': 'light',
          },
          scopes: [VariableScope.allScopes],
          codeSyntax: VariableCodeSyntax(),
        ),
        'VariableID:2:5': LocalVariable(
          id: 'VariableID:2:5',
          name: 'boolean',
          remote: false,
          key: '66393690efc9df6a02ed1e813f32e31091597487',
          variableCollectionId: 'VariableCollectionId:0:3',
          resolvedType: VariableResolvedDataType.boolean,
          description: '',
          hiddenFromPublishing: false,
          valuesByMode: {
            '0:0': true,
            '1:0': false,
          },
          scopes: [VariableScope.allScopes],
          codeSyntax: VariableCodeSyntax(),
        ),
      },
    ),
  );

  group('fromDtoToModel', () {
    test('Converts a LocalVariablesResponse to List<Variable>', () {
      final repository = FigmaVariablesRepository();
      final variables = repository.fromDtoToModel(variablesResponse);

      expect(variables, isA<List<Variable<dynamic>>>());
      expect(
        variables.first.key,
        equals('26a211e627a2da8a80c0f06e0b776ba97a8780e3'),
      );
      expect(variables.first.name, equals('green'));
      expect(variables.first.remote, equals(false));
      expect(
        variables.first.variableCollectionId,
        equals('VariableCollectionId:0:3'),
      );
      expect(variables.first.variableCollectionName, "collection");
      expect(variables.first.scopes, equals(const ['ALL_SCOPES']));
      expect(variables.first.codeSyntax, equals(const {}));
      expect(variables.first.resolvedType, equals(domain.VariableType.color));
      expect(variables.first.description, equals(''));
      expect(variables.first.hiddenFromPublishing, equals(false));
      expect(
        variables.first.valuesByModeId['0:0'],
        equals(const AliasOr<int>.data(data: 4290117398)),
      );
      expect(
        variables.first.valuesByModeId['1:0'],
        equals(const AliasOr<int>.data(data: 4286038042)),
      );
    });
  });
}
