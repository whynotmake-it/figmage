import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';

const mockBoolVariable = BoolVariable(
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
    "light": AliasOr<bool>.data(data: true),
    "dark": AliasOr<bool>.data(data: false),
  },
);

final mockVariables = <Variable<dynamic>>[
  mockBoolVariable,
  const ColorVariable(
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
      "light": AliasOr.data(data: 0xFF000000),
      "dark": AliasOr.data(data: 0xFFFFFFFF),
    },
  ),
  const FloatVariable(
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
      "light": AliasOr.data(data: 1),
      "dark": AliasOr.data(data: 0),
    },
  ),
  const StringVariable(
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
      "light": AliasOr.data(data: "light"),
      "dark": AliasOr.data(data: "dark"),
    },
  ),
];

const mockVariableEmptyCollection = BoolVariable(
  id: "bool_id",
  name: "boolName",
  remote: false,
  key: "key",
  variableCollectionId: "variableCollectionId",
  variableCollectionName: "",
  resolvedType: "BOOLEAN",
  description: "description",
  hiddenFromPublishing: false,
  scopes: [],
  codeSyntax: {},
  collectionModeNames: {},
  valuesByMode: {
    "light": AliasOr<bool>.data(data: true),
    "dark": AliasOr<bool>.data(data: false),
  },
);
