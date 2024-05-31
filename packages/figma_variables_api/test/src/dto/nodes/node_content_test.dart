import 'package:figma/figma.dart';
import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:test/test.dart';

void main() {
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

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        final nodeContent = NodeContent(
          name: 'name',
          role: 'role',
          lastModified: DateTime.parse('2021-08-06T00:00:00Z'),
          thumbnailUrl: 'thumbnailUrl',
          version: 'version',
          document: null,
          components: <String, Component>{},
          componentSets: <String, ComponentSet>{},
          schemaVersion: 1,
          styles: <String, Style>{},
        );

        final result = nodeContent.toJson();
        expect(result, isA<Map<String, dynamic>>());
        expect(result["name"], nodeContent.name);
        expect(result["role"], nodeContent.role);
        expect(
          result["lastModified"],
          nodeContent.lastModified?.toIso8601String(),
        );
        expect(result["thumbnailUrl"], nodeContent.thumbnailUrl);
        expect(result["version"], nodeContent.version);
        expect(result["document"], nodeContent.document);
        expect(result["components"], nodeContent.components);
        expect(result["componentSets"], nodeContent.componentSets);
        expect(result["schemaVersion"], nodeContent.schemaVersion);
        expect(result["styles"], nodeContent.styles);
      });
    });

    group('equality', () {
      test('should be equal if all properties are equal', () {
        final nodeContent1 = NodeContent(
          name: 'name',
          role: 'role',
          lastModified: DateTime.parse('2021-08-06T00:00:00Z'),
          thumbnailUrl: 'thumbnailUrl',
          version: 'version',
          document: null,
          components: <String, Component>{},
          componentSets: <String, ComponentSet>{},
          schemaVersion: 1,
          styles: <String, Style>{},
        );

        final nodeContent2 = NodeContent(
          name: 'name',
          role: 'role',
          lastModified: DateTime.parse('2021-08-06T00:00:00Z'),
          thumbnailUrl: 'thumbnailUrl',
          version: 'version',
          document: null,
          components: <String, Component>{},
          componentSets: <String, ComponentSet>{},
          schemaVersion: 1,
          styles: <String, Style>{},
        );

        expect(nodeContent1, nodeContent2);
      });

      test('should not be equal if any property is different', () {
        final nodeContent1 = NodeContent(
          name: 'otherName',
          role: 'role',
          lastModified: DateTime.parse('2021-08-06T00:00:00Z'),
          thumbnailUrl: 'thumbnailUrl',
          version: 'version',
          document: null,
          components: <String, Component>{},
          componentSets: <String, ComponentSet>{},
          schemaVersion: 1,
          styles: <String, Style>{},
        );

        final nodeContent2 = NodeContent(
          name: 'name',
          role: 'role',
          lastModified: DateTime.parse('2021-08-06T00:00:00Z'),
          thumbnailUrl: 'thumbnailUrl',
          version: 'version',
          document: null,
          components: <String, Component>{},
          componentSets: <String, ComponentSet>{},
          schemaVersion: 1,
          styles: <String, Style>{},
        );

        expect(nodeContent1, isNot(nodeContent2));
      });
    });
  });
}
