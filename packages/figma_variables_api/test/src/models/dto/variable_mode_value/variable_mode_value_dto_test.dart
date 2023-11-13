import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:test/test.dart';

void main() {
  group('VariableModeValueDto', () {
    group('fromJson', () {
      test('works for bool', () {
        final json = true;
        final result = VariableModeValueDto.fromJson(json);
        expect(result as VariableModeBooleanDto, isA<VariableModeBooleanDto>());
        expect(result.value, equals(json));
      });

      test('works for num', () {
        final json = 42;
        final result = VariableModeValueDto.fromJson(json);
        expect(result as VariableModeDoubleDto, isA<VariableModeDoubleDto>());
        expect(result.value, equals(json));
      });

      test('works for string', () {
        final json = 'hello';
        final result = VariableModeValueDto.fromJson(json);
        expect(result as VariableModeStringDto, isA<VariableModeStringDto>());
        expect(result.value, equals(json));
      });

      test('works for color', () {
        final json = {
          'r': 1,
          'g': 2,
          'b': 3,
          'a': 4,
        };
        final result = VariableModeValueDto.fromJson(json);
        expect(result as VariableModeColorDto, isA<VariableModeColorDto>());
        expect((result).r, equals(json['r']));
        expect((result).g, equals(json['g']));
        expect((result).b, equals(json['b']));
        expect((result).a, equals(json['a']));
      });

      test('works for alias', () {
        final json = {'type': 'VARIABLE_ALIAS', 'id': 'someId'};
        final result = VariableModeValueDto.fromJson(json);
        expect(result as VariableModeAliasDto, isA<VariableModeAliasDto>());
        expect((result).id, equals(json['id']));
        expect((result).type, equals(json['type']));
      });

      test('throws for unknown type', () {
        final json = {'unknown': 'type'};
        expect(() => VariableModeValueDto.fromJson(json), throwsException);
      });
    });
  });

  group('VariableModeBooleanDto', () {
    group('toJson', () {
      test('works', () {
        final value = true;
        final result = VariableModeBooleanDto(value: value).toJson();
        expect(result, equals(value));
      });
    });

    group('equality', () {
      test('same is equal', () {
        final value = VariableModeBooleanDto(value: true);
        final value2 = VariableModeBooleanDto(value: true);
        expect(value, equals(value2));
      });

      test('different is not equal', () {
        final value = VariableModeBooleanDto(value: true);
        final value2 = VariableModeBooleanDto(value: false);
        expect(value, isNot(equals(value2)));
      });
    });
  });

  group('VariableModeNumberDto', () {
    group('toJson', () {
      test('works', () {
        final value = 42.0;
        final result = VariableModeDoubleDto(value: value).toJson();
        expect(result, equals(value));
      });
    });

    group('equality', () {
      test('same is equal', () {
        final value = VariableModeDoubleDto(value: 42);
        final value2 = VariableModeDoubleDto(value: 42);
        expect(value, equals(value2));
      });

      test('different is not equal', () {
        final value = VariableModeDoubleDto(value: 42);
        final value2 = VariableModeDoubleDto(value: 43);
        expect(value, isNot(equals(value2)));
      });
    });
  });

  group('VariableModeStringDto', () {
    group('toJson', () {
      test('works', () {
        final value = 'hello';
        final result = VariableModeStringDto(value: value).toJson();
        expect(result, equals(value));
      });
    });

    group('equality', () {
      test('same is equal', () {
        final value = VariableModeStringDto(value: 'hello');
        final value2 = VariableModeStringDto(value: 'hello');
        expect(value, equals(value2));
      });

      test('different is not equal', () {
        final value = VariableModeStringDto(value: 'hello');
        final value2 = VariableModeStringDto(value: 'world');
        expect(value, isNot(equals(value2)));
      });
    });
  });

  group('VariableModeColorDto', () {
    group('toJson', () {
      test('works', () {
        final value = VariableModeColorDto(
          r: 1,
          g: 2,
          b: 3,
          a: 4,
        ).toJson();
        expect(value, equals({'r': 1, 'g': 2, 'b': 3, 'a': 4}));
      });
    });

    group('value', () {
      test('works for white', () {
        final value = VariableModeColorDto(
          r: 1,
          g: 1,
          b: 1,
          a: 1,
        ).value;
        expect(value, 0xFFFFFFFF);
      });

      test('works for black', () {
        final value = VariableModeColorDto(
          r: 0,
          g: 0,
          b: 0,
          a: 1,
        ).value;
        expect(value, 0xFF000000);
      });
    });
    group('equality', () {
      test('same is equal', () {
        final value = VariableModeColorDto(
          r: 1,
          g: 1,
          b: 1,
          a: 1,
        );
        final value2 = VariableModeColorDto(
          r: 1,
          g: 1,
          b: 1,
          a: 1,
        );
        expect(value, equals(value2));
      });

      test('different is not equal', () {
        final value = VariableModeColorDto(
          r: 1,
          g: 1,
          b: 1,
          a: 1,
        );
        final value2 = VariableModeColorDto(
          r: 1,
          g: 1,
          b: 1,
          a: 0,
        );
        expect(value, isNot(equals(value2)));
      });
    });
  });

  group('VariableModeAliasDto', () {
    group('toJson', () {
      test('works', () {
        final value = VariableModeAliasDto(
          id: 'someId',
          type: 'VARIABLE_ALIAS',
        ).toJson();
        expect(value, equals({'id': 'someId', 'type': 'VARIABLE_ALIAS'}));
      });
    });

    group('equality', () {
      test('same is equal', () {
        final value = VariableModeAliasDto(
          id: 'someId',
          type: 'VARIABLE_ALIAS',
        );
        final value2 = VariableModeAliasDto(
          id: 'someId',
          type: 'VARIABLE_ALIAS',
        );
        expect(value, equals(value2));
      });

      test('different is not equal', () {
        final value = VariableModeAliasDto(
          id: 'someId',
          type: 'VARIABLE_ALIAS',
        );
        final value2 = VariableModeAliasDto(
          id: 'someId2',
          type: 'VARIABLE_ALIAS',
        );
        expect(value, isNot(equals(value2)));
      });
    });
  });
}
