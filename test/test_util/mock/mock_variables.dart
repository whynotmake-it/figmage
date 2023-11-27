import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';

final mockVariables = [
  Variable.boolean(
    id: "bool_id",
    name: "boolName",
    remote: false,
    key: "key",
    variableCollectionId: "variableCollectionId",
    variableCollectionName: "variableCollectionName",
    resolvedType: "BOOLEAN",
    description: "description",
    hiddenFromPublishing: false,
    scopes: [],
    codeSyntax: {},
    collectionModeNames: {},
    valuesByMode: {
      "light": const AliasOr.data(data: true),
      "dark": const AliasOr.data(data: false),
    },
  ),
];
