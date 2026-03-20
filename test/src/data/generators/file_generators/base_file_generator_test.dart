import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/file_generators/base_file_generator.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/json_token.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../test_util/mock/mock_styles.dart';
import '../../../../test_util/mock/mock_variables.dart';

class _MockThemeClassGenerator extends Mock implements ThemeClassGenerator {}

class _FakeThemeClassGenerator implements ThemeClassGenerator {
  @override
  bool get buildContextExtensionNullable => false;

  @override
  String get className => 'Fake';

  @override
  Class generateClass() => Class((c) => c.name = 'Fake');

  @override
  Extension generateExtension() => Extension((e) => e.name = 'FakeX');
}

class _Generator extends BaseFileGenerator<int> with Mock {
  _Generator({
    required super.tokens,
    required super.inheritanceSettings,
  }) : super(type: TokenFileType.color);
}

class _RecordingGenerator extends BaseFileGenerator<int> {
  _RecordingGenerator({
    required super.tokens,
    super.isMixedTokenCollection,
  }) : super(type: TokenFileType.color, inheritanceSettings: []);

  final calls = <String>[];
  final classNameByCollectionId = <String, String>{};

  @override
  ThemeClassGenerator buildGeneratorForCollection({
    required String collectionName,
    required Iterable<DesignToken<int>> collectionTokens,
    required Iterable<InterfaceSettings> interfaces,
  }) {
    calls.add(collectionName);
    classNameByCollectionId[collectionTokens.first.collectionId] =
        collectionName;
    return _FakeThemeClassGenerator();
  }
}

void main() {
  late _Generator sut;
  late List<_MockThemeClassGenerator> generators;

  _MockThemeClassGenerator getGenerator(int i) {
    final mock = _MockThemeClassGenerator();
    when(mock.generateClass).thenReturn(Class((c) => c.name = "Test$i"));
    when(
      mock.generateExtension,
    ).thenReturn(Extension((c) => c.name = "TestX$i"));
    generators.add(mock);
    return mock;
  }

  setUp(() {
    sut = _Generator(
      tokens: [
        mockColorDesignStyle,
        mockColorVariable,
      ],
      inheritanceSettings: [],
    );
    generators = [];

    when(
      () => sut.buildGeneratorForCollection(
        collectionName: any(named: 'collectionName'),
        collectionTokens: any(named: 'collectionTokens'),
        interfaces: any(named: 'interfaces'),
      ),
    ).thenAnswer((_) => getGenerator(generators.length));
  });

  group('generate()', () {
    test('builds all generators', () async {
      sut.generate();
      verify(
        () => sut.buildGeneratorForCollection(
          collectionName: any(named: "collectionName", that: equals('Colors')),
          collectionTokens: any(
            named: "collectionTokens",
            that: equals([mockColorDesignStyle]),
          ),
          interfaces: [],
        ),
      );

      verify(
        () => sut.buildGeneratorForCollection(
          collectionName: 'Collection1',
          collectionTokens: [mockColorVariable],
          interfaces: [],
        ),
      );

      expect(generators, hasLength(2));
    });
    test('call all generator generation methods', () {
      sut.generate();

      for (final gen in generators) {
        verify(gen.generateClass);
        verify(gen.generateExtension);
        verifyNoMoreInteractions(gen);
      }
    });

    test('contains all generator results', () {
      final result = sut.generate();

      expect(
        result,
        isA<Library>().having(
          (p0) => p0.body,
          'body',
          containsAllInOrder([
            isA<Class>().having((p0) => p0.name, "name", "Test0"),
            isA<Extension>().having((p0) => p0.name, "name", "TestX0"),
            isA<Class>().having((p0) => p0.name, "name", "Test1"),
            isA<Extension>().having((p0) => p0.name, "name", "TestX1"),
          ]),
        ),
        reason: 'generated library body contains 2 classes and 2 extensions',
      );
    });

    test('drops trailing Value in single-mode class naming', () {
      final generator = _RecordingGenerator(
        tokens: const [
          JsonToken<int>(
            name: 'stone/50',
            fullName: 'theme/Color Primitives/Value/stone/50',
            collectionName: 'Color Primitives/Value',
            collectionId: 'theme/Color Primitives/Value',
            valuesByModeName: {'': AliasOr<int>.data(data: 0xff000000)},
          ),
        ],
      );

      generator.generate();

      expect(generator.calls, ['ColorPrimitives']);
    });

    test('adds type prefix only for mixed-token source collections', () {
      final generator = _RecordingGenerator(
        isMixedTokenCollection: (collectionId) => collectionId == 'theme/light',
        tokens: const [
          JsonToken<int>(
            name: 'tokenA',
            fullName: 'theme/light/tokenA',
            collectionName: 'light',
            collectionId: 'theme/light',
            valuesByModeName: {'': AliasOr<int>.data(data: 0xff000000)},
          ),
          JsonToken<int>(
            name: 'tokenB',
            fullName: 'theme/brand/tokenB',
            collectionName: 'brand',
            collectionId: 'theme/brand',
            valuesByModeName: {'': AliasOr<int>.data(data: 0xffffffff)},
          ),
        ],
      );

      generator.generate();

      expect(generator.calls, contains('ColorsLight'));
      expect(generator.calls, contains('Brand'));
      expect(generator.calls, hasLength(2));
    });

    test('uses suffix numbering as deterministic collision fallback', () {
      final generator = _RecordingGenerator(
        tokens: const [
          JsonToken<int>(
            name: 'tokenA',
            fullName: 'theme/light/tokenA',
            collectionName: 'light',
            collectionId: 'theme/light',
            valuesByModeName: {'': AliasOr<int>.data(data: 0xff000000)},
          ),
          JsonToken<int>(
            name: 'tokenB',
            fullName: 'theme/light!/tokenB',
            collectionName: 'light!',
            collectionId: 'theme/light!',
            valuesByModeName: {'': AliasOr<int>.data(data: 0xffffffff)},
          ),
        ],
      );

      generator.generate();

      expect(generator.calls, ['Light', 'Light1']);
    });

    test('assigns collision suffixes independent of token input order', () {
      const tokenA = JsonToken<int>(
        name: 'tokenA',
        fullName: 'theme/light/tokenA',
        collectionName: 'light',
        collectionId: 'theme/light',
        valuesByModeName: {'': AliasOr<int>.data(data: 0xff000000)},
      );
      const tokenB = JsonToken<int>(
        name: 'tokenB',
        fullName: 'theme/light!/tokenB',
        collectionName: 'light!',
        collectionId: 'theme/light!',
        valuesByModeName: {'': AliasOr<int>.data(data: 0xffffffff)},
      );

      final forward = _RecordingGenerator(tokens: const [tokenA, tokenB]);
      final reversed = _RecordingGenerator(tokens: const [tokenB, tokenA]);

      forward.generate();
      reversed.generate();

      expect(
        forward.classNameByCollectionId,
        equals(reversed.classNameByCollectionId),
      );
    });
  });
}
