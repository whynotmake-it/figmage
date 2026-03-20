import 'dart:convert';
import 'dart:io';

import 'package:figmage/src/data/repositories/json_tokens_repository.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:test/test.dart';

void main() {
  group('FileJsonTokensRepository', () {
    late Directory tempDir;
    late FileJsonTokensRepository sut;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp(
        'figmage_json_tokens_',
      );
      sut = const FileJsonTokensRepository();
    });

    tearDown(() async {
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('requires exactly one resolver manifest path', () async {
      final resolverA = await _writeResolver(
        tempDir,
        setRefs: {
          'global': './global.json',
        },
      );
      final resolverB = await _writeResolver(
        tempDir,
        name: 'resolver_b.json',
        setRefs: {
          'global': './global.json',
        },
      );

      await expectLater(
        () => sut.getTokens(paths: [resolverA.path, resolverB.path]),
        throwsA(isA<ArgumentError>()),
      );
    });

    test(
      'throws when resolver references unknown set in resolution order',
      () async {
        final resolverFile = File('${tempDir.path}/resolver.json');
        await resolverFile.writeAsString(
          jsonEncode({
            'version': '2025.10',
            'sets': {
              'global': {r'$ref': './global.json'},
            },
            'resolutionOrder': ['global', 'missing'],
          }),
        );

        await expectLater(
          () => sut.getTokens(paths: [resolverFile.path]),
          throwsA(isA<FormatException>()),
        );
      },
    );

    test('throws when resolver references missing set file', () async {
      final resolverFile = await _writeResolver(
        tempDir,
        setRefs: {
          'global': './missing.json',
        },
      );

      await expectLater(
        () => sut.getTokens(paths: [resolverFile.path]),
        throwsA(isA<FileSystemException>()),
      );
    });

    test('parses modes and collections through resolver manifest', () async {
      await _writeJsonFile(
        tempDir,
        'tokens.json',
        {
          'ds': {
            'light': {
              'colors': {
                'primary': {
                  r'$type': 'color',
                  r'$value': '#ffffff',
                },
              },
            },
            'dark': {
              'colors': {
                'primary': {
                  r'$type': 'color',
                  r'$value': '#000000',
                },
              },
            },
            'gap': {
              r'$type': 'number',
              r'$value': 12,
            },
          },
        },
      );
      final resolverFile = await _writeResolver(
        tempDir,
        setRefs: {
          'base': './tokens.json',
        },
      );

      final tokens = await sut.getTokens(paths: [resolverFile.path]);
      final colorTokens = tokens.whereType<DesignToken<int>>().toList();
      final numberTokens = tokens.whereType<DesignToken<double>>().toList();

      final primary = colorTokens.singleWhere(
        (token) => token.fullName.endsWith('ds/colors/primary'),
      );
      expect(primary.valuesByModeName.keys, containsAll(['light', 'dark']));

      final gap = numberTokens.singleWhere(
        (token) => token.fullName.endsWith('ds/gap'),
      );
      expect(gap.collectionName, 'base');
      expect(gap.valuesByModeName.keys, contains(''));
    });

    test('resolves same-file curly aliases', () async {
      await _writeJsonFile(
        tempDir,
        'aliases.json',
        {
          'Color Primitives': {
            'Value': {
              'stone': {
                '50': {
                  r'$type': 'color',
                  r'$value': '#fafafa',
                },
              },
            },
          },
          'Color Aliases': {
            'Pressed': {
              r'$type': 'color',
              r'$value': '{Color Primitives.Value.stone.50}',
            },
          },
        },
      );
      final resolverFile = await _writeResolver(
        tempDir,
        setRefs: {
          'aliases': './aliases.json',
        },
      );

      final tokens = await sut.getTokens(paths: [resolverFile.path]);
      final aliasToken = tokens.whereType<DesignToken<int>>().singleWhere(
        (token) => token.fullName.endsWith('Color Aliases/Pressed'),
      );

      expect(aliasToken.valuesByModeName['']!.resolveValue, 0xfffafafa);
      expect(aliasToken.valuesByModeName[''], isA<Alias<int>>());
    });

    test('resolves curly aliases across resolver files', () async {
      await _writeJsonFile(
        tempDir,
        'primitives.json',
        {
          'Value': {
            'stone': {
              '50': {
                r'$type': 'color',
                r'$value': '#fafafa',
              },
            },
          },
        },
      );
      await _writeJsonFile(
        tempDir,
        'aliases.json',
        {
          'Color Aliases': {
            'Pressed': {
              r'$type': 'color',
              r'$value': '{Color Primitives.Value.stone.50}',
            },
          },
        },
      );
      final resolverFile = await _writeResolver(
        tempDir,
        setRefs: {
          'Color Primitives': './primitives.json',
          'Color Aliases': './aliases.json',
        },
      );

      final diagnostics = <String>[];
      final tokens = await sut.getTokens(
        paths: [resolverFile.path],
        onDiagnostic: diagnostics.add,
      );

      final aliasToken = tokens.whereType<DesignToken<int>>().singleWhere(
        (token) => token.fullName.endsWith('Color Aliases/Pressed'),
      );

      expect(aliasToken.valuesByModeName['']!.resolveValue, 0xfffafafa);
      expect(aliasToken.valuesByModeName[''], isA<Alias<int>>());
      expect(diagnostics, isEmpty);
    });

    test(
      'marks missing curly aliases as unresolved and reports diagnostics',
      () async {
        await _writeJsonFile(
          tempDir,
          'aliases.json',
          {
            'Color Aliases': {
              'Pressed': {
                r'$type': 'color',
                r'$value': '{Color Primitives.Value.stone.50}',
              },
            },
          },
        );
        final resolverFile = await _writeResolver(
          tempDir,
          setRefs: {
            'aliases': './aliases.json',
          },
        );

        final diagnostics = <String>[];
        final tokens = await sut.getTokens(
          paths: [resolverFile.path],
          onDiagnostic: diagnostics.add,
        );

        final aliasToken = tokens.whereType<DesignToken<int>>().singleWhere(
          (token) => token.fullName.endsWith('Color Aliases/Pressed'),
        );

        expect(aliasToken.valuesByModeName['']!.resolveValue, isNull);
        expect(aliasToken.valuesByModeName[''], isA<AliasUnresolved<int>>());
        expect(diagnostics.join('\n'), contains('Unresolved reference'));
      },
    );

    test(
      'marks conflicting cross-set curly aliases as unresolved '
      'and reports diagnostics',
      () async {
        await _writeJsonFile(
          tempDir,
          'primitives_a.json',
          {
            'Color Primitives': {
              'Value': {
                'stone': {
                  '50': {
                    r'$type': 'color',
                    r'$value': '#fafafa',
                  },
                },
              },
            },
          },
        );
        await _writeJsonFile(
          tempDir,
          'primitives_b.json',
          {
            'Color Primitives': {
              'Value': {
                'stone': {
                  '50': {
                    r'$type': 'color',
                    r'$value': '#f0f0f0',
                  },
                },
              },
            },
          },
        );
        await _writeJsonFile(
          tempDir,
          'aliases.json',
          {
            'Color Aliases': {
              'Pressed': {
                r'$type': 'color',
                r'$value': '{Color Primitives.Value.stone.50}',
              },
            },
          },
        );
        final resolverFile = await _writeResolver(
          tempDir,
          setRefs: {
            'Color Primitives A': './primitives_a.json',
            'Color Primitives B': './primitives_b.json',
            'aliases': './aliases.json',
          },
        );

        final diagnostics = <String>[];
        final tokens = await sut.getTokens(
          paths: [resolverFile.path],
          onDiagnostic: diagnostics.add,
        );
        final aliasToken = tokens.whereType<DesignToken<int>>().singleWhere(
          (token) => token.fullName.endsWith('Color Aliases/Pressed'),
        );

        expect(aliasToken.valuesByModeName['']!.resolveValue, isNull);
        expect(aliasToken.valuesByModeName[''], isA<AliasUnresolved<int>>());
        expect(diagnostics.join('\n'), contains('Unresolved reference'));
      },
    );

    test(
      r'resolves cross-file references using $ref and JSON pointer',
      () async {
        await _writeJsonFile(
          tempDir,
          'primitives.json',
          {
            'Color Primitives': {
              'Value': {
                'stone': {
                  '50': {
                    r'$type': 'color',
                    r'$value': '#fafafa',
                  },
                },
              },
            },
          },
        );
        await _writeJsonFile(
          tempDir,
          'aliases.json',
          {
            'Color Aliases': {
              'Pressed': {
                r'$type': 'color',
                r'$value': {
                  r'$ref': './primitives.json#/Color Primitives/Value/stone/50',
                },
              },
            },
          },
        );
        final resolverFile = await _writeResolver(
          tempDir,
          setRefs: {
            'primitives': './primitives.json',
            'aliases': './aliases.json',
          },
        );

        final tokens = await sut.getTokens(paths: [resolverFile.path]);
        final aliasToken = tokens.whereType<DesignToken<int>>().singleWhere(
          (token) => token.fullName.endsWith('Color Aliases/Pressed'),
        );

        expect(aliasToken.valuesByModeName['']!.resolveValue, 0xfffafafa);
        expect(aliasToken.valuesByModeName[''], isA<Alias<int>>());
      },
    );

    test(
      r'maps $ref JSON pointers targeting token $value to the owning token',
      () async {
        await _writeJsonFile(
          tempDir,
          'primitives.json',
          {
            'Color Primitives': {
              'Value': {
                'stone': {
                  '50': {
                    r'$type': 'color',
                    r'$value': '#fafafa',
                  },
                },
              },
            },
          },
        );
        await _writeJsonFile(
          tempDir,
          'aliases.json',
          {
            'Color Aliases': {
              'Pressed': {
                r'$type': 'color',
                r'$value': {
                  r'$ref':
                      r'./primitives.json#/Color Primitives/Value/stone/50/$value',
                },
              },
            },
          },
        );
        final resolverFile = await _writeResolver(
          tempDir,
          setRefs: {
            'primitives': './primitives.json',
            'aliases': './aliases.json',
          },
        );

        final diagnostics = <String>[];
        final tokens = await sut.getTokens(
          paths: [resolverFile.path],
          onDiagnostic: diagnostics.add,
        );
        final aliasToken = tokens.whereType<DesignToken<int>>().singleWhere(
          (token) => token.fullName.endsWith('Color Aliases/Pressed'),
        );

        expect(aliasToken.valuesByModeName['']!.resolveValue, 0xfffafafa);
        expect(aliasToken.valuesByModeName[''], isA<Alias<int>>());
        expect(diagnostics, isEmpty);
      },
    );

    test(
      r'marks $ref to non-token pointer as unresolved and reports diagnostics',
      () async {
        await _writeJsonFile(
          tempDir,
          'primitives.json',
          {
            'Color Primitives': {
              'Value': {
                'stone': {
                  '50': {
                    r'$type': 'color',
                    r'$value': '#fafafa',
                  },
                },
              },
            },
          },
        );
        await _writeJsonFile(
          tempDir,
          'aliases.json',
          {
            'Color Aliases': {
              'Pressed': {
                r'$type': 'color',
                r'$value': {
                  r'$ref':
                      r'./primitives.json#/Color Primitives/Value/stone/50/$type',
                },
              },
            },
          },
        );
        final resolverFile = await _writeResolver(
          tempDir,
          setRefs: {
            'primitives': './primitives.json',
            'aliases': './aliases.json',
          },
        );

        final diagnostics = <String>[];
        final tokens = await sut.getTokens(
          paths: [resolverFile.path],
          onDiagnostic: diagnostics.add,
        );
        final token = tokens.whereType<DesignToken<int>>().singleWhere(
          (t) => t.fullName.endsWith('Color Aliases/Pressed'),
        );

        expect(token.valuesByModeName['']!.resolveValue, isNull);
        expect(token.valuesByModeName[''], isA<AliasUnresolved<int>>());
        expect(diagnostics.join('\n'), contains('non-token location'));
      },
    );

    test(r'marks malformed JSON pointers in $ref as unresolved', () async {
      await _writeJsonFile(
        tempDir,
        'primitives.json',
        {
          'Color Primitives': {
            'Value': {
              'stone': {
                '50': {
                  r'$type': 'color',
                  r'$value': '#fafafa',
                },
              },
            },
          },
        },
      );
      await _writeJsonFile(
        tempDir,
        'aliases.json',
        {
          'Color Aliases': {
            'Pressed': {
              r'$type': 'color',
              r'$value': {
                r'$ref': './primitives.json#/Color~2Primitives/Value/stone/50',
              },
            },
          },
        },
      );
      final resolverFile = await _writeResolver(
        tempDir,
        setRefs: {
          'primitives': './primitives.json',
          'aliases': './aliases.json',
        },
      );

      final diagnostics = <String>[];
      final tokens = await sut.getTokens(
        paths: [resolverFile.path],
        onDiagnostic: diagnostics.add,
      );
      final token = tokens.whereType<DesignToken<int>>().singleWhere(
        (t) => t.fullName.endsWith('Color Aliases/Pressed'),
      );

      expect(token.valuesByModeName['']!.resolveValue, isNull);
      expect(token.valuesByModeName[''], isA<AliasUnresolved<int>>());
      expect(diagnostics.join('\n'), contains('Invalid JSON pointer'));
    });

    test('keeps unresolved on type mismatch and reports diagnostics', () async {
      await _writeJsonFile(
        tempDir,
        'numbers.json',
        {
          'Spacing': {
            'sm': {
              r'$type': 'number',
              r'$value': 4,
            },
          },
        },
      );
      await _writeJsonFile(
        tempDir,
        'colors.json',
        {
          'Colors': {
            'primary': {
              r'$type': 'color',
              r'$value': {
                r'$ref': './numbers.json#/Spacing/sm',
              },
            },
          },
        },
      );
      final resolverFile = await _writeResolver(
        tempDir,
        setRefs: {
          'numbers': './numbers.json',
          'colors': './colors.json',
        },
      );

      final diagnostics = <String>[];
      final tokens = await sut.getTokens(
        paths: [resolverFile.path],
        onDiagnostic: diagnostics.add,
      );
      final token = tokens.whereType<DesignToken<int>>().singleWhere(
        (t) => t.fullName.endsWith('Colors/primary'),
      );

      expect(token.valuesByModeName['']!.resolveValue, isNull);
      expect(diagnostics.join('\n'), contains('Type mismatch'));
    });

    test('marks cyclic aliases unresolved and reports diagnostics', () async {
      await _writeJsonFile(
        tempDir,
        'cycle.json',
        {
          'A': {
            r'$type': 'color',
            r'$value': '{B}',
          },
          'B': {
            r'$type': 'color',
            r'$value': '{A}',
          },
        },
      );
      final resolverFile = await _writeResolver(
        tempDir,
        setRefs: {
          'cycle': './cycle.json',
        },
      );

      final diagnostics = <String>[];
      final tokens = await sut.getTokens(
        paths: [resolverFile.path],
        onDiagnostic: diagnostics.add,
      );
      final tokenA = tokens.whereType<DesignToken<int>>().singleWhere(
        (t) => t.fullName.endsWith('A'),
      );

      expect(tokenA.valuesByModeName['']!.resolveValue, isNull);
      expect(diagnostics.join('\n'), contains('Cycle detected'));
    });

    test(
      'marks cross-file cyclic aliases unresolved and reports diagnostics',
      () async {
        await _writeJsonFile(
          tempDir,
          'a.json',
          {
            'A': {
              r'$type': 'color',
              r'$value': {
                r'$ref': './b.json#/B',
              },
            },
          },
        );
        await _writeJsonFile(
          tempDir,
          'b.json',
          {
            'B': {
              r'$type': 'color',
              r'$value': {
                r'$ref': './a.json#/A',
              },
            },
          },
        );
        final resolverFile = await _writeResolver(
          tempDir,
          setRefs: {
            'a': './a.json',
            'b': './b.json',
          },
        );

        final diagnostics = <String>[];
        final tokens = await sut.getTokens(
          paths: [resolverFile.path],
          onDiagnostic: diagnostics.add,
        );
        final tokenA = tokens.whereType<DesignToken<int>>().singleWhere(
          (t) => t.fullName.endsWith('A'),
        );

        expect(tokenA.valuesByModeName['']!.resolveValue, isNull);
        expect(diagnostics.join('\n'), contains('Cycle detected'));
      },
    );

    test('parses typography values and defaults', () async {
      await _writeJsonFile(
        tempDir,
        'typography.json',
        {
          'ds': {
            'light': {
              'text': {
                r'$type': 'typography',
                r'$value': {
                  'fontFamily': 'Inter',
                  'fontSize': 16,
                  'textDecoration': 'underline',
                },
              },
            },
            'dark': {
              'text': {
                r'$type': 'typography',
                r'$value': {
                  'fontFamily': 'Inter',
                  'fontSize': 12,
                  'fontWeight': 700,
                  'letterSpacing': {'value': 0.5},
                  'lineHeight': {'value': 24, 'unit': 'px'},
                },
              },
            },
          },
        },
      );
      final resolverFile = await _writeResolver(
        tempDir,
        setRefs: {
          'typography': './typography.json',
        },
      );

      final tokens = await sut.getTokens(paths: [resolverFile.path]);
      final typographyToken = tokens
          .whereType<DesignToken<Typography>>()
          .singleWhere((token) => token.fullName.endsWith('ds/text'));

      final light = typographyToken.valuesByModeName['light']!.resolveValue!;
      expect(light.fontFamily, 'Inter');
      expect(light.fontSize, 16);
      expect(light.fontWeight, 400);
      expect(light.letterSpacing, 1.0);
      expect(light.height, 1.0);
      expect(light.decoration, TextDecoration.underline);

      final dark = typographyToken.valuesByModeName['dark']!.resolveValue!;
      expect(dark.fontWeight, 700);
      expect(dark.letterSpacing, 0.5);
      expect(dark.height, 2);
    });

    test(
      'disables modes and keeps mixed-schema branches in one collection',
      () async {
        await _writeJsonFile(
          tempDir,
          'theme.json',
          {
            'colors': {
              'light': {
                'surface': {r'$type': 'color', r'$value': '#ffffff'},
                'text': {r'$type': 'color', r'$value': '#111111'},
              },
              'dark': {
                'surface': {r'$type': 'color', r'$value': '#000000'},
                'text': {r'$type': 'color', r'$value': '#f0f0f0'},
              },
              'compact': {
                'badge': {r'$type': 'color', r'$value': '#ff0000'},
              },
            },
          },
        );
        final resolverFile = await _writeResolver(
          tempDir,
          setRefs: {
            'theme': './theme.json',
          },
        );

        final tokens = await sut.getTokens(paths: [resolverFile.path]);
        final colorTokens = tokens.whereType<DesignToken<int>>().toList();
        final collectionNames = colorTokens
            .map((token) => token.collectionName)
            .toSet();
        final names = colorTokens.map((token) => token.name).toSet();
        final modeKeys = colorTokens
            .expand((token) => token.valuesByModeName.keys)
            .toSet();

        expect(collectionNames, {'theme/colors'});
        expect(names, {'light/surface', 'light/text', 'dark/surface', 'dark/text', 'compact/badge'});
        expect(modeKeys, {''});
      },
    );
  });
}

Future<File> _writeResolver(
  Directory dir, {
  required Map<String, String> setRefs,
  String name = 'resolver.json',
}) async {
  final file = File('${dir.path}/$name');
  await file.writeAsString(
    jsonEncode({
      'version': '2025.10',
      'sets': {
        for (final entry in setRefs.entries) entry.key: {r'$ref': entry.value},
      },
      'resolutionOrder': setRefs.keys.toList(),
    }),
  );
  return file;
}

Future<File> _writeJsonFile(
  Directory dir,
  String name,
  Map<String, Object?> content,
) async {
  final file = File('${dir.path}/$name');
  await file.writeAsString(jsonEncode(content));
  return file;
}
