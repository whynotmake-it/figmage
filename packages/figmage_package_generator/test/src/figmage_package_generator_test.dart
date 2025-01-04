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
          description: "A test",
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
          description: "A test",
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
          description: "A test",
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
          description: "A test",
        );

        final content = verify(
          () => generatorTarget.createFile(
            any(that: equals("pubspec.yaml")),
            captureAny(),
          ),
        ).captured.first as List<int>;

        final decoded = utf8.decode(content);

        expect(decoded, contains("google_fonts: ^6.2.1"));
      });

      test('pubspec doesnt contain google_fonts dependency if unwanted',
          () async {
        await sut.generate(
          projectName: "figmage_example",
          dir: testDirectory,
          description: "A test",
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
          description: "A test",
        );

        verify(
          () => generatorTarget.createFile(
            any(that: equals("README.md")),
            any(that: isNotEmpty),
          ),
        ).called(1);
      });

      group("with all file types", () {
        late Iterable<File> files;
        setUp(() async {
          files = await sut.generate(
            projectName: "figmage_example",
            dir: testDirectory,
            description: "A test",
          );
        });
        test('generates all extra type files by default', () async {
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
        test('all generated type files are in export', () {
          final content = verify(
            () => generatorTarget.createFile(
              any(that: contains("figmage_example.dart")),
              captureAny(),
            ),
          ).captured.first as List<int>;
          final decoded = utf8.decode(content);

          expect(
            decoded,
            equals(_expectedFullLibraryFile),
          );
        });

        test('generated type files are generated empty', () async {
          for (final type in TokenFileType.values) {
            verify(
              () => generatorTarget.createFile(
                any(that: contains(type.filename)),
                any(that: isEmpty),
              ),
            );
          }
        });
      });

      group('with no file types', () {
        late Iterable<File> files;
        setUp(() async {
          files = await sut.generate(
            projectName: "figmage_example",
            dir: testDirectory,
            description: "A test",
            generateColors: false,
            generateTypography: false,
            generateNumbers: false,
            generateSpacers: false,
            generatePaddings: false,
            generateRadii: false,
            generateStrings: false,
            generateBools: false,
            generateAssets: false,
          );
        });

        test('generates none of the files', () async {
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
              reason:
                  "Expected not to find ${type.filename} in generated files",
            );
          }
        });

        test('none of the generated files are in export', () {
          final content = verify(
            () => generatorTarget.createFile(
              any(that: contains("figmage_example.dart")),
              captureAny(),
            ),
          ).captured.first as List<int>;
          final decoded = utf8.decode(content);

          expect(
            decoded,
            equals(_expectedEmptyLibraryFile),
          );
        });
      });

      group('with mixed (#38)', () {
        // ignore: unused_local_variable
        late Iterable<File> files;
        setUp(() async {
          files = await sut.generate(
            projectName: "figmage_example",
            dir: testDirectory,
            description: "A test",
            generateNumbers: false,
            generateSpacers: false,
            generatePaddings: false,
            generateRadii: false,
            generateStrings: false,
            generateBools: false,
          );
        });

        test('generates only the files that are not disabled', () async {
          verify(
            () => generatorTarget.createFile(
              any(that: contains("lib/src/colors.dart")),
              any(that: isEmpty),
            ),
          ).called(1);
          verify(
            () => generatorTarget.createFile(
              any(that: contains("lib/src/typography.dart")),
              any(that: isEmpty),
            ),
          ).called(1);
          verifyNever(
            () => generatorTarget.createFile(
              any(that: contains("lib/src/numbers.dart")),
              any(),
            ),
          );
          verifyNever(
            () => generatorTarget.createFile(
              any(that: contains("lib/src/bools.dart")),
              any(),
            ),
          );
          verifyNever(
            () => generatorTarget.createFile(
              any(that: contains("lib/src/numbers.dart")),
              any(),
            ),
          );
        });

        test('only the generated files are in export', () {
          final content = verify(
            () => generatorTarget.createFile(
              any(that: contains("figmage_example.dart")),
              captureAny(),
            ),
          ).captured.first as List<int>;
          final decoded = utf8.decode(content);

          expect(
            decoded,
            equals(_expectedMixedLibraryFile),
          );
        });
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
            description: "A test",
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

const _expectedFullLibraryFile = '''
/// A test
library figmage_example;

export 'src/bools.dart';
export 'src/colors.dart';
export 'src/numbers.dart';
export 'src/paddings.dart';
export 'src/radii.dart';
export 'src/spacers.dart';
export 'src/strings.dart';
export 'src/typography.dart';
export 'src/assets.dart';
''';

const _expectedEmptyLibraryFile = '''
/// A test
library figmage_example;










''';

const _expectedMixedLibraryFile = '''
/// A test
library figmage_example;


export 'src/colors.dart';





export 'src/typography.dart';
export 'src/assets.dart';
''';
