import 'package:figma/figma.dart';
import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {});

  group('NodeContent', () {
    group('fromJson', () {
      test('should return a valid model', () {
        final Map<String, dynamic> jsonMap = {
          'name': 'name',
          'role': 'role',
          'lastModified': '2021-08-06T00:00:00Z',
          'thumbnailUrl': 'thumbnailUrl',
          'version': 'version',
          'document': null,
          'components': <String, dynamic>{},
          'componentSets': <String, dynamic>{},
          'schemaVersion': 1,
          'styles': <String, dynamic>{},
        };

        final result = NodeContent.fromJson(jsonMap);
        expect(result, isA<NodeContent>());
      });

      test('converts node to actual type', () async {
        final Map<String, dynamic> jsonMap = {
          'name': 'name',
          'role': 'role',
          'lastModified': '2021-08-06T00:00:00Z',
          'thumbnailUrl': 'thumbnailUrl',
          'version': 'version',
          'document': {
            'id': 'id',
            'name': 'name',
            'visible': true,
            'type': 'SLICE',
          },
          'components': <String, dynamic>{},
          'componentSets': <String, dynamic>{},
          'schemaVersion': 1,
          'styles': <String, dynamic>{},
        };

        final result = NodeContent.fromJson(jsonMap);
        expect(result.document, isA<Slice>());
      });
    });
  });
}
