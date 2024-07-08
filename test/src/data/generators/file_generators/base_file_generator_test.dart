import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/file_generators/base_file_generator.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../test_util/mock/mock_styles.dart';
import '../../../../test_util/mock/mock_variables.dart';

class _MockThemeClassGenerator extends Mock implements ThemeClassGenerator {}

class _Generator extends BaseFileGenerator<int> with Mock {
  _Generator({
    required super.tokens,
  }) : super(type: TokenFileType.color);
}

void main() {
  late _Generator sut;
  late List<_MockThemeClassGenerator> generators;

  _MockThemeClassGenerator getGenerator(int i) {
    final mock = _MockThemeClassGenerator();
    when(mock.generateClass).thenReturn(Class((c) => c.name = "Test$i"));
    when(mock.generateExtension)
        .thenReturn(Extension((c) => c.name = "TestX$i"));
    generators.add(mock);
    return mock;
  }

  setUp(() {
    sut = _Generator(
      tokens: [
        mockColorDesignStyle,
        mockColorVariable,
      ],
    );
    generators = [];

    when(
      () => sut.buildGeneratorForCollection(
        collectionName: any(named: 'collectionName'),
        collectionTokens: any(named: 'collectionTokens'),
      ),
    ).thenAnswer((_) => getGenerator(generators.length));
  });

  group('generate()', () {
    test('builds all generators', () async {
      sut.generate();
      verify(
        () => sut.buildGeneratorForCollection(
          collectionName: any(
            named: "collectionName",
            that: equals(mockColorDesignStyle.collectionName),
          ),
          collectionTokens: any(
            named: "collectionTokens",
            that: equals([mockColorDesignStyle]),
          ),
        ),
      );

      verify(
        () => sut.buildGeneratorForCollection(
          collectionName: any(
            named: "collectionName",
            that: equals(mockColorVariable.collectionName),
          ),
          collectionTokens: any(
            named: "collectionTokens",
            that: equals([mockColorVariable]),
          ),
        ),
      );

      expect(generators, hasLength(2));
    });
    test('call all generator generation methods', () {
      final result = sut.generate();

      for (final gen in generators) {
        verify(gen.generateClass);
        verify(gen.generateExtension);
        verifyNoMoreInteractions(gen);
      }

      expect(result, isNotEmpty);
    });

    test('contains all generator results', () {
      final result = sut.generate();

      expect(
        result,
        containsAllInOrder([
          isA<Class>().having((p0) => p0.name, "name", "Test0"),
          isA<Extension>().having((p0) => p0.name, "name", "TestX0"),
          isA<Class>().having((p0) => p0.name, "name", "Test1"),
          isA<Extension>().having((p0) => p0.name, "name", "TestX1"),
        ]),
      );
    });
  });
}
