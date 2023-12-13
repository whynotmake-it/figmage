// ignore_for_file: prefer_const_constructors, avoid_slow_async_io
import 'dart:convert';
import 'dart:io';

import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockGeneratorTarget extends Mock implements GeneratorTarget {}

class _MockDirectory extends Mock implements Directory {}

void main() {
  group('FigmagePackageGenerator', () {
    test('can be instantiated', () {
      expect(FigmagePackageGenerator(), isNotNull);
    });

    late _MockGeneratorTarget generatorTarget;

    late _MockDirectory testDirectory;

    late FigmagePackageGenerator sut;

    setUp(() async {
      generatorTarget = _MockGeneratorTarget();
      when(() => generatorTarget.createFile(any(), any())).thenAnswer(
        (invocation) => Future.value(
          GeneratedFile.created(
            path: invocation.positionalArguments[0] as String,
          ),
        ),
      );

      testDirectory = _MockDirectory();
      sut = FigmagePackageGenerator(
        generatorTargetFactory: (_) => generatorTarget,
      );
    });

    group("generate", () {
      test('generates files', () async {
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
      });
      test('generates pubspec.yaml', () async {
        await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
        );

        verify(
          () => generatorTarget.createFile(
            any(that: equals("pubspec.yaml")),
            any(),
          ),
        ).called(1);
      });

      test('pubspec contains project name and description', () async {
        await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
        );

        final content = verify(
          () => generatorTarget.createFile(
            any(that: equals("pubspec.yaml")),
            captureAny(),
          ),
        ).captured.first as List<int>;

        final decoded = utf8.decode(content);

        expect(decoded, contains("figmage_example"));
        expect(decoded, contains("A test"));
      });

      test('pubspec contains google fonts dependency by default', () async {
        await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
        );

        final content = verify(
          () => generatorTarget.createFile(
            any(that: equals("pubspec.yaml")),
            captureAny(),
          ),
        ).captured.first as List<int>;

        final decoded = utf8.decode(content);

        expect(decoded, contains("google_fonts: ^6.1.0"));
      });

      test('pubspec doesnt contain google_fonts dependency if unwanted',
          () async {
        await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
          useGoogleFonts: false,
        );

        final content = verify(
          () => generatorTarget.createFile(
            any(that: equals("pubspec.yaml")),
            captureAny(),
          ),
        ).captured.first as List<int>;

        final decoded = utf8.decode(content);

        expect(decoded, isNot(contains("google_fonts: ^6.1.0")));
      });

      test('generates non-empty README.md', () async {
        await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
        );

        verify(
          () => generatorTarget.createFile(
            any(that: equals("README.md")),
            any(that: isNotEmpty),
          ),
        ).called(1);
      });

      test('generates all extra type files by default', () async {
        final files = await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
        );
        for (final type in TokenFileType.values) {
          expect(
            files,
            contains(
              isA<File>().having(
                (f) => f.path,
                "path",
                contains("lib/src/${type.filename}"),
              ),
            ),
            reason: "Expected to find ${type.filename} in generated files",
          );
        }
      });

      test('generated type files are generated empty', () async {
        await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
        );
        for (final type in TokenFileType.values) {
          verify(
            () => generatorTarget.createFile(
              any(that: contains(type.filename)),
              any(that: isEmpty),
            ),
          );
        }
      });

      test('generates no extra type files if unwanted', () async {
        final files = await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test ",
          generateColors: false,
          generateTypography: false,
          generateNumbers: false,
          generateSpacers: false,
          generatePaddings: false,
          generateRadii: false,
          generateStrings: false,
          generateBools: false,
        );
        for (final type in TokenFileType.values) {
          expect(
            files,
            isNot(
              contains(
                isA<File>().having(
                  (f) => f.path,
                  "path",
                  contains(type.filename),
                ),
              ),
            ),
            reason: "Expected not to find ${type.filename} in generated files",
          );
        }
      });
      test('throws if package URI could not be resolved', () async {
        sut = FigmagePackageGenerator(
          generatorTargetFactory: (_) => _MockGeneratorTarget(),
          packageUriResolver: (_) => null,
        );
        await expectLater(
          () => sut.generate(
            projectName: "figmage_example",
            dir: testDirectory,
            description: "A test ",
          ),
          throwsA(
            isA<PackageUriException>()
                .having(
                  (p0) => p0.packageName,
                  "packageName",
                  "figmage_package_generator",
                )
                .having(
                  (p0) => p0.toString(),
                  "toString()",
                  contains("figmage_package_generator"),
                ),
          ),
        );
      });
    });
  });
}
