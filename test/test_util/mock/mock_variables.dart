// Due to the analyer raising weird issues when using the const constructors,
// we have to ignore the prefer_const_constructors rule.
// ignore_for_file: prefer_const_constructors

import 'package:figmage/src/domain/models/tokens_by_file_type/tokens_by_type.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';

final mockColorVariableUnresolvable = ColorVariable(
  id: "color_id_unresolvable",
  name: "colorNameUnresolvable",
  remote: false,
  key: "key",
  variableCollectionId: "variableCollectionId",
  variableCollectionName: "collection1",
  resolvedType: "COLOR",
  description: "description",
  hiddenFromPublishing: false,
  scopes: [],
  codeSyntax: {},
  collectionModeNamesById: {
    "33:0": 'light',
    "34:0": 'dark',
  },
  valuesByModeId: {
    "33:0": AliasOr.data(data: 0xAAAAAA),
    "34:0": AliasOr.unresolved(
      id: 'not_existing_id',
    ),
  },
);

final mockColorVariable = ColorVariable(
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
  collectionModeNamesById: {
    "33:0": 'light',
    "34:0": 'dark',
  },
  valuesByModeId: {
    "33:0": AliasOr.data(data: 0xFF000000),
    "34:0": AliasOr.data(data: 0xFFFFFFFF),
  },
);

final mockFloatVariable = FloatVariable(
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
  collectionModeNamesById: {
    "33:0": 'light',
    "34:0": 'dark',
  },
  valuesByModeId: {
    "33:0": AliasOr.data(data: 1),
    "34:0": AliasOr.data(data: 0),
  },
);

final mockBoolVariable = BoolVariable(
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
  collectionModeNamesById: {
    "33:0": 'light',
    "34:0": 'dark',
  },
  valuesByModeId: {
    "33:0": AliasOr<bool>.data(data: true),
    "34:0": AliasOr<bool>.data(data: false),
  },
);

final mockStringVariable = StringVariable(
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
  collectionModeNamesById: {
    "33:0": 'light',
    "34:0": 'dark',
  },
  valuesByModeId: {
    "33:0": AliasOr.data(data: "light"),
    "34:0": AliasOr.data(data: "dark"),
  },
);

final mockVariables = <Variable<dynamic>>[
  mockColorVariableUnresolvable,
  mockColorVariable,
  mockBoolVariable,
  mockFloatVariable,
  mockStringVariable,
];

final mockTokensForType = TokensByType(
  colorTokens: [mockColorVariableUnresolvable, mockColorVariable],
  typographyTokens: [],
  stringTokens: [mockStringVariable],
  numberTokens: [mockFloatVariable],
  boolTokens: [mockBoolVariable],
);

final mockVariableEmptyCollection = BoolVariable(
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
  collectionModeNamesById: {
    "33:0": 'light',
    "34:0": 'dark',
  },
  valuesByModeId: {
    "33:0": AliasOr<bool>.data(data: true),
    "34:0": AliasOr<bool>.data(data: false),
  },
);
