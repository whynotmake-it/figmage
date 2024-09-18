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
      expect(r, _expectedFile);
    });
  });
}

const _expectedFile = '''
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class Typography extends ThemeExtension<Typography> {
  const Typography({required this.fullName});

  Typography.standard()
      : fullName = GoogleFonts.getFont(
          'Roboto',
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.0,
          height: 1.0,
          decoration: TextDecoration.underline,
        );

  final TextStyle fullName;

  @override
  Typography copyWith([TextStyle? fullName]) =>
      Typography(fullName: fullName ?? this.fullName);

  @override
  Typography lerp(
    Typography other,
    double t,
  ) {
    if (other is! Typography) return this;
    return Typography(
        fullName: TextStyle.lerp(
      fullName,
      other.fullName,
      t,
    )!);
  }
}

extension TypographyBuildContextX on BuildContext {
  Typography get typography => Theme.of(this).extension<Typography>()!;
}
''';
