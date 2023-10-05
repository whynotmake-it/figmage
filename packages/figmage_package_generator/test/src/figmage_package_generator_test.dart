// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:test/test.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';

void main() {
  group('FigmagePackageGenerator', () {
    test('can be instantiated', () {
      expect(FigmagePackageGenerator(), isNotNull);
    });

    late FigmagePackageGenerator sut;

    setUp(() async {
      sut = FigmagePackageGenerator();
    });

    group("generate", () {
      late Directory testDirectory;

      setUp(() async {
        testDirectory = Directory("${Directory.current.path}/test_generated");
        if (await testDirectory.exists() == false) {
          await testDirectory.create();
        }
      });

      tearDown(() async {
        await testDirectory.delete(recursive: true);
      });

      test('generates directory with files', () async {
        final files = await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
        );
        expect(
          files,
          isNotEmpty,
          reason: "No files were generated",
        );

        final dir = Directory("${testDirectory.path}/figmage_example");
        expect(
          await dir.exists(),
          isTrue,
          reason: "Directory was not created",
        );

        final pubspec =
            File("${testDirectory.path}/figmage_example/pubspec.yaml");
        expect(
          await pubspec.exists(),
          isTrue,
          reason: "pubspec.yaml was not created",
        );

        final readme = File("${testDirectory.path}/figmage_example/README.md");
        expect(
          await readme.exists(),
          isTrue,
          reason: "README.md was not created",
        );
      });
    });
  });
}
