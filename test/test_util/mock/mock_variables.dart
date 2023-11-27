import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';

final mockBoolVariable = Variable.boolean(
  id: "bool_id",
  name: "boolName",
  remote: false,
  key: "key",
  variableCollectionId: "variableCollectionId",
  variableCollectionName: "collection1",
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
);

final mockVariables = [
  mockBoolVariable,
  Variable.color(
    id: "color_id",
    name: "colorName",
    remote: false,
    key: "key",
    variableCollectionId: "variableCollectionId",
    variableCollectionName: "collection1",
    resolvedType: "COLOR",
    description: "description",
    hiddenFromPublishing: false,
    scopes: [],
    codeSyntax: {},
    collectionModeNames: {},
    valuesByMode: {
      "light": const AliasOr.data(data: 0xFF000000),
      "dark": const AliasOr.data(data: 0xFFFFFFFF),
    },
  ),
  Variable.float(
    id: "float_id",
    name: "floatName",
    remote: false,
    key: "key",
    variableCollectionId: "variableCollectionId",
    variableCollectionName: "collection2",
    resolvedType: "FLOAT",
    description: "description",
    hiddenFromPublishing: false,
    scopes: [],
    codeSyntax: {},
    collectionModeNames: {},
    valuesByMode: {
      "light": const AliasOr.data(data: 1),
      "dark": const AliasOr.data(data: 0),
    },
  ),
  Variable.string(
    id: "string_id",
    name: "stringName",
    remote: false,
    key: "key",
    variableCollectionId: "variableCollectionId",
    variableCollectionName: "collection2",
    resolvedType: "STRING",
    description: "description",
    hiddenFromPublishing: false,
    scopes: [],
    codeSyntax: {},
    collectionModeNames: {},
    valuesByMode: {
      "light": const AliasOr.data(data: "light"),
      "dark": const AliasOr.data(data: "dark"),
    },
  ),
];
