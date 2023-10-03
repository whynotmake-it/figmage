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

      test('generates files', () async {
        final files = await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
        );
        expect(files, isNotEmpty);
      });

      test('generates folder with package name', () async {
        await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
        );
        final dir = Directory("${testDirectory.path}/figmage_example");
        expect(await dir.exists(), isTrue);
      });

      test('generates pubspec.yaml', () async {
        await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
        );
        final file = File("${testDirectory.path}/figmage_example/pubspec.yaml");
        expect(await file.exists(), isTrue);
      });

      test('generates README.md', () async {
        await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
        );
        final file = File("${testDirectory.path}/figmage_example/README.md");
        expect(await file.exists(), isTrue);
      });
    });
  });
}
