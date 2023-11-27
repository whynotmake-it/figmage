import 'package:figmage_package_generator/src/token_file_type.dart';
import 'package:test/test.dart';

void main() {
  group("TokenFileType", () {
    group('.fromFilename', () {
      test('works for colors', () async {
        expect(
          TokenFileType.fromFilename('colors.dart'),
          equals(TokenFileType.color),
        );
      });

      test('works for typography', () async {
        expect(
          TokenFileType.fromFilename('typography.dart'),
          equals(TokenFileType.typography),
        );
      });

      test('works for numbers', () async {
        expect(
          TokenFileType.fromFilename('numbers.dart'),
          equals(TokenFileType.numbers),
        );
      });

      test('works for spacers', () async {
        expect(
          TokenFileType.fromFilename('spacers.dart'),
          equals(TokenFileType.spacers),
        );
      });

      test('works for paddings', () async {
        expect(
          TokenFileType.fromFilename('paddings.dart'),
          equals(TokenFileType.paddings),
        );
      });

      test('works for radii', () async {
        expect(
          TokenFileType.fromFilename('radii.dart'),
          equals(TokenFileType.radii),
        );
      });

      test('works for strings', () async {
        expect(
          TokenFileType.fromFilename('strings.dart'),
          equals(TokenFileType.strings),
        );
      });

      test('works for bools', () async {
        expect(
          TokenFileType.fromFilename('bools.dart'),
          equals(TokenFileType.bools),
        );
      });

      test('throws for unknown file', () async {
        expect(
          () => TokenFileType.fromFilename('unknown.dart'),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('tryFromFilename', () {
      test('works for colors', () async {
        expect(
          TokenFileType.tryFromFilename('colors.dart'),
          equals(TokenFileType.color),
        );
      });

      test('returns null for unknown', () async {
        expect(TokenFileType.tryFromFilename("unknown.dart"), isNull);
      });
    });
  });
}
