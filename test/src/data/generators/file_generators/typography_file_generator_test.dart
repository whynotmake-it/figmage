import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:figmage/src/data/generators/file_generators/typography_file_generator.dart';
import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:test/test.dart';

void main() {
  group('TypographyFileGenerator', () {
    late TypographyFileGenerator sut;

    setUp(() {
      sut = TypographyFileGenerator(
        tokens: [
          const TextDesignStyle(
            id: "id",
            fullName: "fullName",
            value: Typography(
              fontSize: 16,
              fontFamily: 'Roboto',
              fontFamilyPostScriptName: 'Roboto',
              decoration: TextDecoration.underline,
            ),
          ),
        ],
        useGoogleFonts: true,
      );
    });

    test('should have correct type', () {
      expect(sut.type, TokenFileType.typography);
    });

    test('generate', () async {
      final result = sut.generate();
      final library = LibraryBuilder();
      library.body.addAll(result);
      final emitter = DartEmitter(allocator: Allocator());
      final text = library.build().accept(emitter).toString();
      final r = DartFormatter().format(text);
      print(r);
    });
  });
}
