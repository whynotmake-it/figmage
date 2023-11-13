// ignore_for_file: prefer_const_constructors, avoid_slow_async_io
import 'dart:io';

import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:test/test.dart';

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

      test('generated project is without analysis issues', () async {
        await sut.generate(
          projectName: "figmage_example",
          description: "A test ",
          dir: testDirectory,
        );

        await Process.run("dart", ["pub", "get"]);
        final result = await Process.run("dart", [
          "analyze",
          testDirectory.path,
          "--fatal-infos",
        ]);

        expect(result.exitCode, 0);
      });

      test('generates all extra type files by default', () async {
        final files = await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
        );
        expect(files.any((element) => element.name == "colors.dart"), isTrue);
        expect(
          files.any((element) => element.name == "typography.dart"),
          isTrue,
        );
        expect(files.any((element) => element.name == "spacers.dart"), isTrue);
        expect(files.any((element) => element.name == "paddings.dart"), isTrue);
        expect(files.any((element) => element.name == "radii.dart"), isTrue);
        expect(files.any((element) => element.name == "strings.dart"), isTrue);
        expect(files.any((element) => element.name == "bools.dart"), isTrue);
      });
      test('generates no extra type files if unwanted', () async {
        final files = await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
          generateColors: false,
          generateTypography: false,
          generateSpacers: false,
          generatePaddings: false,
          generateRadii: false,
          generateStrings: false,
          generateBools: false,
        );
        expect(files.any((element) => element.name == "colors.dart"), isFalse);
        expect(
          files.any((element) => element.name == "typography.dart"),
          isFalse,
        );
        expect(files.any((element) => element.name == "spacers.dart"), isFalse);
        expect(
          files.any((element) => element.name == "paddings.dart"),
          isFalse,
        );
        expect(files.any((element) => element.name == "radii.dart"), isFalse);
        expect(files.any((element) => element.name == "strings.dart"), isFalse);
        expect(files.any((element) => element.name == "bools.dart"), isFalse);
      });
    });
  });
}

extension on File {
  String get name => path.split("/").last;
}
