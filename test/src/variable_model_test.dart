// import 'dart:convert';
// import 'dart:io';
// import 'package:figmage/src/domain/models/models.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:test/test.dart';
//
// //helper function to load json
// (T, Map<String, dynamic>) parseJsonFromFile<T>(
//   String relativePath,
//   T Function(Map<String, dynamic>) fromJson,
// ) {
//   final currentDirectory = Directory.current.path;
//   final filePath = '$currentDirectory/test/src/mock_data/$relativePath';
//
//   final jsonString = File(filePath).readAsStringSync();
//   final jsonMap = json.decode(jsonString);
//
//   return (fromJson(jsonMap), jsonMap);
// }
//
// void main() {
//   group(
//     'Variable',
//     () {
//       group('fromJson', () {
//         test('works for valid json', () {
//           final (variable, _) = parseJsonFromFile(
//             'variable_example.json',
//             (json) => Variable.fromJson(json),
//           );
//           expect(variable.id, "VariableID:28:11");
//           expect(variable.name, "primary");
//           expect(variable.key, "d9cc111c73223a643eab988cd3c25ff3ba859564");
//           expect(variable.variableCollectionId, "VariableCollectionId:28:10");
//         });
//         test('Throws for invalid json', () {
//           final jsonString =
//               '{"someKey": "value", "someOtherKey": "someOtherValue", "resolvedType":"COLOR"}';
//           expect(
//             () => Variable.fromJson(json.decode(jsonString)),
//             throwsA(TypeMatcher<TypeError>()),
//           );
//         });
//       });
//       // group('toJson', () {
//       //   test('works for valid object', () {
//       //     final variable = Variable(
//       //       id: "VariableID:33:8",
//       //       name: "box-background-active",
//       //       remote: false,
//       //       key: "db60e2b2141198dff74e59f329863257348ec9d6",
//       //       variableCollectionId: "VariableCollectionId:33:7",
//       //       resolvedType: "COLOR",
//       //       description: "",
//       //       hiddenFromPublishing: false,
//       //       scopes: ["ALL_SCOPES"],
//       //       codeSyntax: {
//       //         "WEB": "box-background-active",
//       //         "ANDROID": "box-background-active",
//       //         "iOS": "box-background-active",
//       //       },
//       //       valuesByMode: {
//       //         "33:0": VariableValue.variableAlias(
//       //           VariableAlias(type: "VARIABLE_ALIAS", id: "VariableID:28:14"),
//       //         ),
//       //       },
//       //     );
//       //
//       //     final jsonMap = variable.toJson();
//       //
//       //     expect(jsonMap, {
//       //       "id": "VariableID:33:8",
//       //       "name": "box-background-active",
//       //       "remote": false,
//       //       "key": "db60e2b2141198dff74e59f329863257348ec9d6",
//       //       "variableCollectionId": "VariableCollectionId:33:7",
//       //       "resolvedType": "COLOR",
//       //       "description": "",
//       //       "hiddenFromPublishing": false,
//       //       "scopes": ["ALL_SCOPES"],
//       //       "codeSyntax": {
//       //         "WEB": "box-background-active",
//       //         "ANDROID": "box-background-active",
//       //         "iOS": "box-background-active",
//       //       },
//       //       "valuesByMode": {
//       //         "33:0": {
//       //           "type": "VARIABLE_ALIAS",
//       //           "id": "VariableID:28:14",
//       //         },
//       //       },
//       //     });
//       //   });
//       // });
//     },
//   );
// }
