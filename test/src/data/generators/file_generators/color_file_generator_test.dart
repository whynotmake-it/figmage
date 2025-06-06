import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/file_generators/color_file_generator.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:test/test.dart';

import '../../../../test_util/mock/mock_styles.dart';
import '../../../../test_util/mock/mock_variables.dart';
import '../common.dart';

void main() {
  useDartfmt();
  setUp(() {});

  group('ColorFileGenerator', () {
    late ColorFileGenerator sut;

    setUp(() {
      sut = ColorFileGenerator(
        tokens: [
          mockColorVariable,
          mockColorDesignStyle,
          mockColorVariableUnresolvable,
        ],
        implementsSettings: [
          const ImplementsSettings(
            collections: ['collection1'],
            interfaces: [
              InterfaceSettings(
                name: 'MyColors',
                import: 'my_colors.dart',
              ),
            ],
          ),
          const ImplementsSettings(
            interfaces: [
              InterfaceSettings(
                name: 'Tokens',
                import: 'tokens.dart',
              ),
            ],
          ),
        ],
      );
    });

    test('Should have correct type', () {
      expect(sut.type, equals(TokenFileType.color));
    });

    test('should build a library', () async {
      final result = sut.generate();
      final emitter = DartEmitter(allocator: Allocator());
      expect(result, equalsDart(expected, emitter));
    });
  });
}

const expected = """
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'my_colors.dart';
import 'tokens.dart';

@immutable
class ColorsCollection1 extends ThemeExtension<ColorsCollection1> 
  implements MyColors, Tokens{
  const ColorsCollection1({
    required this.colorColorName,
    required this.colorNameUnresolvable,
  });

  const ColorsCollection1.dark()
      : colorColorName = const Color(0xffffffff),
        colorNameUnresolvable = null;

  const ColorsCollection1.light()
      : colorColorName = const Color(0xff000000),
        colorNameUnresolvable = const Color(0x00aaaaaa);

  final Color colorColorName;

  final Color? colorNameUnresolvable;

  @override
  ColorsCollection1 copyWith([
    Color? colorColorName,
    Color? colorNameUnresolvable,
  ]) =>
      ColorsCollection1(
        colorColorName: colorColorName ?? this.colorColorName,
        colorNameUnresolvable:
            colorNameUnresolvable ?? this.colorNameUnresolvable,
      );

  @override
  ColorsCollection1 lerp(
    ColorsCollection1 other,
    double t,
  ) {
    if (other is! ColorsCollection1) return this;
    return ColorsCollection1(
      colorColorName: Color.lerp(
        colorColorName,
        other.colorColorName,
        t,
      )!,
      colorNameUnresolvable: Color.lerp(
        colorNameUnresolvable,
        other.colorNameUnresolvable,
        t,
      ),
    );
  }
}

extension ColorsCollection1BuildContextX on BuildContext {
  ColorsCollection1 get colorsCollection1 =>
      Theme.of(this).extension<ColorsCollection1>()!;
}

@immutable
class ColorsColors extends ThemeExtension<ColorsColors> implements Tokens {
  const ColorsColors({required this.colorName});

  const ColorsColors.standard() : colorName = const Color(0xffffffff);

  final Color colorName;

  @override
  ColorsColors copyWith([Color? colorName]) =>
      ColorsColors(colorName: colorName ?? this.colorName);

  @override
  ColorsColors lerp(
    ColorsColors other,
    double t,
  ) {
    if (other is! ColorsColors) return this;
    return ColorsColors(
        colorName: Color.lerp(
      colorName,
      other.colorName,
      t,
    )!);
  }
}

extension ColorsColorsBuildContextX on BuildContext {
  ColorsColors get colorsColors => Theme.of(this).extension<ColorsColors>()!;
}
""";
