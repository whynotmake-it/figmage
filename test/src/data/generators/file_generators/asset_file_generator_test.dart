import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/file_generators/asset_file_generator.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/figmage_settings.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:test/test.dart';

import '../common.dart';

void main() {
  useDartfmt();
  setUp(() {});

  group('AssetFileGenerator', () {
    late AssetFileGenerator sut;
    late FigmageSettings settings;

    setUp(() {
      settings = (
        fileId: 'fileId',
        token: 'token',
        path: 'path',
        config: const Config(
          assets: AssetGenerationSettings(
            generate: true,
            nodes: {
              '1:5': AssetNodeSettings(
                name: 'check',
                scales: {1, 2},
              ),
              '23:1': AssetNodeSettings(
                name: 'exampleName',
              ),
            },
          ),
        ),
      );
      sut = AssetFileGenerator(settings: settings);
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

  static const String _basePath = 'assets/images/';

  static const String check = '${_basePath}check.png';

  static const String exampleName = '${_basePath}exampleName.png';

  AssetImage get checkImage => AssetImage(check);
  
  AssetImage get exampleNameImage => AssetImage(exampleName);
}

extension AssetsBuildContextX on BuildContext {
  Assets get assets => Assets();
}

''';
