import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:test/test.dart';

void main() {
  group('resolveValue', () {
    test('returns value for data case', () async {
      const aliasOr = AliasData(data: 42);
      expect(aliasOr.resolveValue, equals(42));
    });

    test('returns value for single nested alias case', () async {
      const aliasOr = Alias(id: 'someId', aliasOrValue: AliasData(data: 42));
      expect(aliasOr.resolveValue, equals(42));
    });

    test('returns value for double nested alias case', () async {
      const aliasOr = Alias(
        id: 'someId',
        aliasOrValue: Alias(
          id: 'someId',
          aliasOrValue: AliasData(data: 42),
        ),
      );
      expect(aliasOr.resolveValue, equals(42));
    });
  });
}
