import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:figmage/src/data/generators/file_generators/color_file_generator.dart';
import 'package:figmage/src/domain/models/tokens_by_file_type/tokens_by_type.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:test/test.dart';

const modes = {
  "d": 'Dark',
  "l": 'Light',
};
const variableTokens = TokensByType(
  colorTokens: [
    ColorVariable(
      id: "b",
      name: "background",
      remote: true,
      key: "_",
      variableCollectionId: "c1",
      variableCollectionName: "MyCollection",
      resolvedType: kResolvedTypeColor,
      description: "",
      hiddenFromPublishing: false,
      scopes: [],
      codeSyntax: {},
      collectionModeNamesById: modes,
      valuesByModeId: {
        "d": AliasData(data: 0xFF665555),
        "l": AliasData(data: 0xFFFFF4F4),
      },
    ),
    ColorVariable(
      id: "p",
      name: "primary",
      remote: true,
      key: "_",
      variableCollectionId: "c1",
      variableCollectionName: "MyCollection",
      resolvedType: kResolvedTypeColor,
      description: "",
      hiddenFromPublishing: false,
      scopes: [],
      codeSyntax: {},
      collectionModeNamesById: modes,
      valuesByModeId: {
        "d": AliasData(data: 0xFFEF86A6),
        "l": AliasData(data: 0xFF7D4052),
      },
    ),
  ],
  numberTokens: [
    FloatVariable(
      id: "n",
      name: "MyNumber",
      remote: true,
      key: "_",
      variableCollectionId: "c1",
      variableCollectionName: "MyCollection",
      resolvedType: kResolvedTypeColor,
      description: "",
      hiddenFromPublishing: false,
      scopes: [],
      codeSyntax: {},
      collectionModeNamesById: modes,
      valuesByModeId: {
        "d": AliasData(data: 42),
        "l": AliasData(data: 42),
      },
    ),
  ],
);
void main(List<String> args) {
  group('README', () {
    late DartEmitter emitter;
    late DartFormatter formatter;
    late LibraryBuilder lib;
    setUp(() {
      emitter = DartEmitter();
      formatter = DartFormatter();
      lib = LibraryBuilder();
    });

    test('colors file', () async {
      final generator = ColorFileGenerator(tokens: variableTokens.colorTokens);

      lib.body.addAll(generator.generate());

      final result = formatter.format(lib.build().accept(emitter).toString());
      // ignore: avoid_print
      print(
        "```dart"
        "\n$result"
        "\n```",
      );
      expect(result, isNotEmpty);
    });
  });
}
