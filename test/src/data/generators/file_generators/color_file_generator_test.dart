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
        inheritanceSettings: [
          const InheritanceSettings(
            collections: ['collection1'],
            interfaces: [
              InterfaceSettings(
                name: 'MyColors',
                import: 'my_colors.dart',
              ),
            ],
          ),
          const InheritanceSettings(
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
class Collection1 extends ThemeExtension<Collection1> 
  implements MyColors, Tokens{
  const Collection1({
    required this.colorColorName,
    required this.colorNameUnresolvable,
  });

  const Collection1.dark()
      : colorColorName = const Color(0xffffffff),
        colorNameUnresolvable = null;

  const Collection1.light()
      : colorColorName = const Color(0xff000000),
        colorNameUnresolvable = const Color(0x00aaaaaa);

  final Color colorColorName;

  final Color? colorNameUnresolvable;

  @override
  Collection1 copyWith([
    Color? colorColorName,
    Color? colorNameUnresolvable,
  ]) =>
      Collection1(
        colorColorName: colorColorName ?? this.colorColorName,
        colorNameUnresolvable:
            colorNameUnresolvable ?? this.colorNameUnresolvable,
      );

  @override
  Collection1 lerp(
    Collection1 other,
    double t,
  ) {
    if (other is! Collection1) return this;
    return Collection1(
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

extension Collection1BuildContextX on BuildContext {
  Collection1 get collection1 =>
      Theme.of(this).extension<Collection1>()!;
}

@immutable
class Colors extends ThemeExtension<Colors> implements Tokens {
  const Colors({required this.colorName});

  const Colors.standard() : colorName = const Color(0xffffffff);

  final Color colorName;

  @override
  Colors copyWith([Color? colorName]) =>
      Colors(colorName: colorName ?? this.colorName);

  @override
  Colors lerp(
    Colors other,
    double t,
  ) {
    if (other is! Colors) return this;
    return Colors(
        colorName: Color.lerp(
      colorName,
      other.colorName,
      t,
    )!);
  }
}

extension ColorsBuildContextX on BuildContext {
  Colors get colors => Theme.of(this).extension<Colors>()!;
}
""";
