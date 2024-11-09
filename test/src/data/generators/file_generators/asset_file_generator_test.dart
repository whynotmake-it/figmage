import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/file_generators/asset_file_generator.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:test/test.dart';

import '../common.dart';

void main() {
  useDartfmt();
  setUp(() {});

  group('AssetFileGenerator', () {
    late AssetFileGenerator sut;

    setUp(() {
      sut = AssetFileGenerator(
        assets: {
          '1:5': ['check.png', 'check@2x.png'],
          '23:1': ['exampleName.png'],
        },
        packageName: 'test_package',
      );
    });

    test('Should have correct type', () {
      expect(sut.type, equals(TokenFileType.assets));
    });

    test('should build a library', () async {
      final result = sut.generate();
      final emitter = DartEmitter(allocator: Allocator());
      expect(result, equalsDart(expected, emitter));
    });
  });
}

const expected = r'''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';

@immutable
final class Assets {
  const Assets();

  static const String _basePath = 'assets/';

  /// Rendered from frame 1:5
  static const String checkPng = '${_basePath}check.png';

  /// Rendered from frame 1:5
  static const String check2xPng = '${_basePath}check@2x.png';

  /// Rendered from frame 23:1
  static const String exampleNamePng = '${_basePath}exampleName.png';

  AssetImage get checkPngImage => AssetImage(checkPng, package: 'test_package');

  AssetImage get check2xPngImage => AssetImage(check2xPng, package: 'test_package');
  
  AssetImage get exampleNamePngImage => AssetImage(exampleNamePng, package: 'test_package');
}

extension AssetsBuildContextX on BuildContext {
  Assets get assets => Assets();
}

''';
