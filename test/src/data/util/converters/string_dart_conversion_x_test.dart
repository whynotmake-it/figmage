import 'package:figmage/src/data/util/converters/string_dart_conversion_x.dart';
import 'package:test/test.dart';

void main() {
  group("StringDartConversionX", () {
    group("toTitleCase", () {
      test("returns the string in title case", () {
        expect("hello".toTitleCase(), equals("Hello"));
      });

      test("returns the string in title case when the string is empty", () {
        expect("".toTitleCase(), equals(""));
      });
    });

    group("toCamelCase", () {
      test("returns the string in camel case", () {
        expect("Hello".toCamelCase(), equals("hello"));
      });

      test("returns the string in camel case when the string is empty", () {
        expect("".toCamelCase(), equals(""));
      });
    });

    group("removeLeadingNumbers", () {
      test("removes all leading numbers from the string", () {
        expect("123Hello".removeLeadingNumbers(), equals(r"$123Hello"));
      });

      test("returns the string when the string does not start with a number",
          () {
        expect("Hello123".removeLeadingNumbers(), equals("Hello123"));
      });
    });

    group("asCamelCasePath", () {
      test("returns the path segments in camel case", () {
        expect(
          "Hello/World/123".asCamelCasePath,
          equals(["hello", "World", "123"]),
        );
      });

      test("throws when the path does not contain any valid characters", () {
        expect(() => "".asCamelCasePath, throwsA(isA<ArgumentError>()));
      });
    });
  });
}
