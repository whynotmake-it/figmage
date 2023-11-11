import 'package:figmage/src/generators/util.dart';
import 'package:test/test.dart';

void main() {
  group('generators util', () {
    group('ensureSampleKeys', () {
      test('returns true when all maps have the same keys', () {
        final maps = [
          {'a': 1, 'b': 2},
          {'a': 3, 'b': 4},
          {'a': 5, 'b': 6},
        ];
        expect(ensureSameKeys(maps), isTrue);
      });

      test('returns true when the list is empty', () {
        final maps = <Map<String, dynamic>>[];
        expect(ensureSameKeys(maps), isTrue);
      });

      test('returns false when maps have different keys', () {
        final maps = [
          {'a': 1, 'b': 2},
          {'a': 3, 'c': 4},
          {'a': 5, 'b': 6},
        ];
        expect(ensureSameKeys(maps), isFalse);
      });
    });
    group('convertToValidVariableName', () {
      test('leaves valid variable names unchanged', () {
        expect(convertToValidVariableName('hello_world'), equals('helloworld'));
        expect(convertToValidVariableName('hello123'), equals('hello123'));
      });

      test('converts path to camel case', () async {
        expect(convertToValidVariableName('Hello/world'), equals('helloWorld'));
        expect(
          convertToValidVariableName('Hello/world/Again'),
          equals('helloWorldAgain'),
        );
      });

      test('removes non-alphanumeric characters', () {
        expect(
          convertToValidVariableName('Hello/world/Again!!'),
          equals('helloWorldAgain'),
        );
        expect(
          convertToValidVariableName('Hello/world/Again/123'),
          equals('helloWorldAgain123'),
        );
      });

      test('converts leading numbers to valid variable names', () {
        expect(
          convertToValidVariableName('123Hello/world/Again'),
          equals(r'$123HelloWorldAgain'),
        );
      });
    });
  });

  group("convertToValidClassName", () {
    test('leaves valid class names unchanged', () {
      expect(convertToValidClassName('HelloWorld'), equals('HelloWorld'));
      expect(convertToValidClassName('Hello123'), equals('Hello123'));
    });

    test('converts leading lowercase letters to uppercase', () {
      expect(convertToValidClassName('helloWorld'), equals('HelloWorld'));
      expect(convertToValidClassName('hello123'), equals('Hello123'));
    });

    test('converts leading numbers to valid class names', () {
      expect(
          convertToValidClassName('123HelloWorld'), equals(r'$123HelloWorld'));
    });
  });
}
