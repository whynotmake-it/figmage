import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'client_test.mocks.dart';

Future<VariablesResponseDto> fetchLocaleVariables(
  FigmaClient client,
  String fileId,
) async {
  final response = await client.getLocalVariables(fileId);
  if (response.status == 200) {
    return response;
  } else {
    throw Exception('Failed to load local variables');
  }
}

@GenerateMocks([FigmaClient])
void main() {
  group('FigmaClient', () {
    test('returns an VariablesResponse if the http call completes successfully',
        () async {
      final client = MockFigmaClient();
      when(client.getLocalVariables('fileId')).thenAnswer(
        (_) async => VariablesResponseDto(
          status: 200,
          error: false,
          meta: VariablesMetaDto(variables: {}, variableCollections: {}),
        ),
      );

      expect(
        await fetchLocaleVariables(client, 'fileId'),
        isA<VariablesResponseDto>(),
      );
    });

    test('fetchLocaleVariables throws a FigmaError when the HTTP call fails',
        () async {
      final client = MockFigmaClient();
      when(client.getLocalVariables('fileIdNotExisting')).thenThrow(
        FigmaException(
          code: 404,
          message: 'Not found',
        ),
      );
      expect(
        () async {
          await fetchLocaleVariables(client, 'fileIdNotExisting');
        },
        throwsA(isA<FigmaException>()),
      );
    });
  });
}
