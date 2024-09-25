import 'package:figmage/src/domain/shared/dart_symbol_conversion.dart';
import 'package:test/test.dart';

void main() {
  group('toDartPackageName', () {
    test('handles empty string', () {
      expect(toDartPackageName(''), equals('package'));
      expect(toDartPackageName('', defaultName: 'd'), equals('d'));
    });

    test('converts to lowercase', () {
      expect(toDartPackageName('MyPackage'), equals('mypackage'));
    });

    test('replaces spaces with underscores', () {
      expect(toDartPackageName('my package name'), equals('my_package_name'));
    });

    test('removes special characters', () {
      expect(
        toDartPackageName('my-package!name@2'),
        equals('my_package_name_2'),
      );
    });

    test('handles leading numbers', () {
      expect(toDartPackageName('123package'), equals('pkg_123package'));
    });

    test('removes consecutive underscores', () {
      expect(
        toDartPackageName('my__package___name'),
        equals('my_package_name'),
      );
    });

    test('removes leading and trailing underscores', () {
      expect(toDartPackageName('_my_package_'), equals('my_package'));
    });

    test('handles string with only special characters', () {
      expect(toDartPackageName(r'!@#$%^&*()'), equals('package'));
      expect(toDartPackageName(r'!@#$%^&*()', defaultName: 'd'), equals('d'));
    });

    test('handles reserved words', () {
      expect(toDartPackageName('class'), equals('class_pkg'));
      expect(toDartPackageName('if'), equals('if_pkg'));
      expect(toDartPackageName('while'), equals('while_pkg'));
    });

    test('handles mixed case and special characters', () {
      expect(
        toDartPackageName('My-Awesome_Package!123'),
        equals('my_awesome_package_123'),
      );
    });

    test('handles unicode characters', () {
      expect(toDartPackageName('пакет段落'), equals('package'));
      expect(toDartPackageName('пакет段落', defaultName: 'd'), equals('d'));
    });

    test('handles long strings', () {
      expect(
        toDartPackageName(
          'this_is_a_very_long_package_name_that_should_still_work_fine_123',
        ),
        equals(
          'this_is_a_very_long_package_name_that_should_still_work_fine_123',
        ),
      );
    });

    test('throws when provided default name is invalid', () async {
      expect(
        () => toDartPackageName('package', defaultName: '###'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
