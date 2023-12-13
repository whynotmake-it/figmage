import 'dart:io';

import 'package:figmage/src/data/repositories/dart_post_generation_repository.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockProgress extends Mock implements Progress {}

class _MockProcessRunner extends Mock {
  Future<ProcessResult> call(
    String command,
    List<String> args, {
    String? workingDirectory,
  });
}

void main() {
  group("DartPostGenerationRepository", () {
    late DartPostGenerationRepository sut;
    late _MockProcessRunner processRunner;
    late _MockProgress progress;
    setUp(() {
      processRunner = _MockProcessRunner();
      progress = _MockProgress();
      sut = DartPostGenerationRepository(
        processRunner: processRunner.call,
      );
      when(
        () => processRunner.call(
          any(),
          any(),
          workingDirectory: any(named: "workingDirectory"),
        ),
      ).thenAnswer((_) async => ProcessResult(0, 0, '', ''));
    });

    group('runMaintenanceTasks', () {
      test('returns files if no pubspec.yaml is found', () async {
        final files = [
          File('file1'),
          File('file2'),
        ];
        when(() => progress.fail(any())).thenReturn(null);
        final result = await sut.runMaintenanceTasks(files, progress: progress);
        verify(() => progress.fail("No pubspec.yaml found in generated files"))
            .called(1);
        expect(result, files);
      });

      test('runs pub get, format and fix on the directory', () async {
        final files = [
          File('dir/file1'),
          File('dir/file2'),
          File('dir/pubspec.yaml'),
        ];

        final result = await sut.runMaintenanceTasks(
          files,
          progress: progress,
        );

        verify(
          () => processRunner.call(
            'dart',
            ['pub', 'get'],
            workingDirectory: 'dir',
          ),
        ).called(1);

        verify(
          () => processRunner.call(
            'dart',
            ['format', '.'],
            workingDirectory: 'dir',
          ),
        ).called(1);

        verify(
          () => processRunner.call(
            'dart',
            ['fix', '--apply'],
            workingDirectory: 'dir',
          ),
        ).called(1);

        expect(result, files);
      });
    });
  });
}
