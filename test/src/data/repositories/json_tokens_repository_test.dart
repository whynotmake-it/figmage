import 'dart:convert';
import 'dart:io';

import 'package:figmage/src/data/repositories/json_tokens_repository.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
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

    test('parses modes and collections correctly', () async {
      final file = await _writeJsonFile(
        tempDir,
        'tokens.json',
        {
          "ds": {
            "light": {
              "colors": {
                "primary": {
                  r"$type": "color",
                  r"$value": "#ffffff",
                },
              },
              "spacing": {
                "sm": {
                  r"$type": "number",
                  r"$value": 4,
                },
              },
            },
            "dark": {
              "colors": {
                "primary": {
                  r"$type": "color",
                  r"$value": "#000000",
                },
              },
              "spacing": {
                "sm": {
                  r"$type": "number",
                  r"$value": 8,
                },
              },
            },
            "brand": {
              "brandColor": {
                r"$type": "color",
                r"$value": "#123456",
              },
            },
          },
          "topColor": {
            r"$type": "color",
            r"$value": "#010203",
          },
          "ds2": {
            "spacing": {
              r"$type": "number",
              r"$value": 2,
            },
          },
        },
      );

      final tokens = await sut.getTokens(paths: [file.path]);
      final colorTokens = tokens.whereType<DesignToken<int>>().toList();
      final numberTokens = tokens.whereType<DesignToken<double>>().toList();

      final primary = colorTokens.firstWhere(
        (token) => token.fullName == 'ds/colors/primary',
      );
      expect(primary.collectionName, 'ds');
      expect(primary.name, 'colors/primary');
      expect(primary.valuesByModeName.keys, containsAll(['light', 'dark']));

      final spacing = numberTokens.firstWhere(
        (token) => token.fullName == 'ds/spacing/sm',
      );
      expect(spacing.valuesByModeName.keys, containsAll(['light', 'dark']));

      final brand = colorTokens.firstWhere(
        (token) => token.fullName == 'ds/brand/brandColor',
      );
      expect(brand.collectionName, 'ds/brand');
      expect(brand.valuesByModeName.keys, contains(''));

      final top = colorTokens.firstWhere(
        (token) => token.fullName == 'topColor',
      );
      expect(top.collectionName, '');
      expect(top.name, 'topColor');

      final ds2Spacing = numberTokens.firstWhere(
        (token) => token.fullName == 'ds2/spacing',
      );
      expect(ds2Spacing.collectionName, 'ds2');
      expect(ds2Spacing.valuesByModeName.keys, contains(''));
    });

    test('parses typography values and defaults', () async {
      final file = await _writeJsonFile(
        tempDir,
        'typography.json',
        {
          "ds": {
            "light": {
              "text": {
                r"$type": "typography",
                r"$value": {
                  "fontFamily": "Inter",
                  "fontSize": 16,
                },
              },
            },
            "dark": {
              "text": {
                r"$type": "typography",
                r"$value": {
                  "fontFamily": "Inter",
                  "fontSize": 18,
                  "fontWeight": 700,
                  "letterSpacing": {"value": 0.5},
                  "lineHeight": 1.2,
                },
              },
            },
          },
        },
      );

      final tokens = await sut.getTokens(paths: [file.path]);
      final typographyToken = tokens
          .whereType<DesignToken<Typography>>()
          .singleWhere((token) => token.fullName == 'ds/text');

      final light = typographyToken.valuesByModeName['light']!.resolveValue!;
      expect(light.fontFamily, 'Inter');
      expect(light.fontSize, 16);
      expect(light.fontWeight, 400);
      expect(light.letterSpacing, 1.0);
      expect(light.height, 1.0);

      final dark = typographyToken.valuesByModeName['dark']!.resolveValue!;
      expect(dark.fontWeight, 700);
      expect(dark.letterSpacing, 0.5);
      expect(dark.height, 1.2);
    });

    test('throws when type is missing', () async {
      final file = await _writeJsonFile(
        tempDir,
        'invalid.json',
        {
          "ds": {
            "light": {
              "color": {
                r"$value": "#ffffff",
              },
            },
          },
        },
      );

      expect(
        () => sut.getTokens(paths: [file.path]),
        throwsA(isA<FormatException>()),
      );
    });

    test('throws on unsupported token type', () async {
      final file = await _writeJsonFile(
        tempDir,
        'unsupported.json',
        {
          "ds": {
            "light": {
              "border": {
                r"$type": "border",
                r"$value": 1,
              },
            },
          },
        },
      );

      expect(
        () => sut.getTokens(paths: [file.path]),
        throwsA(isA<FormatException>()),
      );
    });
  });
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
