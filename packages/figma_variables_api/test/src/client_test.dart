import 'dart:io';

import 'package:test/test.dart';
import 'package:figma_variables_api/figma_variables_api.dart';

void main() {
  group('FigmaClient', () {
    final String? figmaToken = Platform.environment['FIGMA_TOKEN'];
    final String? fileId = Platform.environment['FIGMA_FILE_ID'];

    assert(
      figmaToken != null && fileId != null,
      'Please store the token and the ID in your path',
    );

    final figmaClient = FigmaClient(figmaToken!);

    test('Get Local Variables', () async {
      final variablesResponse = await figmaClient.getLocalVariables(
        fileId!,
      );
      expect(variablesResponse, isA<VariablesResponse>());
    });
  });
}
