import 'dart:convert';
import 'dart:io';

import 'package:figmage/src/data/util/converters/hex_color_conversion_x.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/json_token.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/repositories/json_tokens_repository.dart';

/// {@template file_json_tokens_repository}
/// Reads tokens from local JSON files.
/// {@endtemplate}
class FileJsonTokensRepository implements JsonTokensRepository {
  /// {@macro file_json_tokens_repository}
  const FileJsonTokensRepository();

  @override
  Future<List<DesignToken<dynamic>>> getTokens({
    required Iterable<String> paths,
  }) async {
    final rawTokens = <_RawJsonToken>[];
    for (final path in paths) {
      final file = File(path);
      if (file.existsSync() == false) {
        throw FileSystemException('JSON token file not found.', path);
      }
      final content = await file.readAsString();
      final decoded = jsonDecode(content);
      if (decoded is! Map) {
        throw FormatException(
          'JSON token file must contain an object at the top level.',
          path,
        );
      }
      _collectTokens(
        node: decoded,
        pathSegments: const [],
        filePath: path,
        output: rawTokens,
      );
    }

    if (rawTokens.isEmpty) {
      return [];
    }

    final modeBranchesByCollection = _detectModeBranches(rawTokens);
    return _buildTokens(rawTokens, modeBranchesByCollection);
  }
}

class _RawJsonToken {
  const _RawJsonToken({
    required this.pathSegments,
    required this.type,
    required this.value,
    required this.filePath,
  });

  final List<String> pathSegments;
  final String type;
  final Object? value;
  final String filePath;
}

class _TokenAccumulator<T> {
  _TokenAccumulator({
    required this.collectionName,
    required this.name,
    required this.fullName,
  });

  final String collectionName;
  final String name;
  final String fullName;
  final Map<String, AliasOr<T>> valuesByModeName = {};
}

void _collectTokens({
  required Object? node,
  required List<String> pathSegments,
  required String filePath,
  required List<_RawJsonToken> output,
}) {
  if (node is! Map) {
    throw FormatException(
      'Expected an object at ${_formatPath(pathSegments)}.',
      filePath,
    );
  }

  if (node.containsKey(r'$value')) {
    final typeValue = node[r'$type'];
    if (typeValue is! String || typeValue.trim().isEmpty) {
      throw FormatException(
        'Missing or invalid \$type at ${_formatPath(pathSegments)}.',
        filePath,
      );
    }
    output.add(
      _RawJsonToken(
        pathSegments: pathSegments,
        type: typeValue,
        value: node[r'$value'],
        filePath: filePath,
      ),
    );
    return;
  }

  for (final entry in node.entries) {
    final key = entry.key;
    if (key is! String) {
      throw FormatException('Token keys must be strings.', filePath);
    }
    _collectTokens(
      node: entry.value,
      pathSegments: [...pathSegments, key],
      filePath: filePath,
      output: output,
    );
  }
}

Map<String, Set<String>> _detectModeBranches(
  List<_RawJsonToken> tokens,
) {
  // Build per-collection candidate mode branches.
  // Each branch stores the set of relative token names beneath it.
  // Collection -> Branch -> Set<token-names>
  final branchesByCollection = <String, Map<String, Set<String>>>{};
  for (final token in tokens) {
    if (token.pathSegments.length < 3) {
      continue;
    }
    final collection = token.pathSegments[0];
    final branch = token.pathSegments[1];
    final name = token.pathSegments.sublist(2).join('/');
    // branchMap collects branch -> token-name-set for this collection.
    final branchMap = branchesByCollection.putIfAbsent(
      collection,
      () => <String, Set<String>>{},
    );
    branchMap.putIfAbsent(branch, () => <String>{}).add(name);
  }

  final modeBranchesByCollection = <String, Set<String>>{};
  for (final collectionEntry in branchesByCollection.entries) {
    final modeBranches = <String>{};
    final branches = collectionEntry.value;
    for (final branchEntry in branches.entries) {
      final branchName = branchEntry.key;
      final names = branchEntry.value;
      // A branch is a "mode" only if a sibling branch has the same name set.
      final hasMatchingSibling = branches.entries.any(
        (sibling) =>
            sibling.key != branchName &&
            _setsEqual(names, sibling.value),
      );
      if (hasMatchingSibling) {
        modeBranches.add(branchName);
      }
    }
    if (modeBranches.isNotEmpty) {
      modeBranchesByCollection[collectionEntry.key] = modeBranches;
    }
  }
  return modeBranchesByCollection;
}

bool _setsEqual(Set<String> left, Set<String> right) {
  if (left.length != right.length) {
    return false;
  }
  return left.containsAll(right);
}

List<DesignToken<dynamic>> _buildTokens(
  List<_RawJsonToken> tokens,
  Map<String, Set<String>> modeBranchesByCollection,
) {
  // If duplicates exist for the same (collection,name,mode), we create
  // additional tokens so downstream name de-duplication can suffix them.
  final colorTokens = <String, List<_TokenAccumulator<int>>>{};
  final numberTokens = <String, List<_TokenAccumulator<double>>>{};
  final boolTokens = <String, List<_TokenAccumulator<bool>>>{};
  final stringTokens = <String, List<_TokenAccumulator<String>>>{};
  final typographyTokens = <String, List<_TokenAccumulator<Typography>>>{};

  for (final token in tokens) {
    final pathSegments = token.pathSegments;
    if (pathSegments.isEmpty) {
      throw FormatException(
        'Token path must contain at least one segment.',
        token.filePath,
      );
    }

    final mappedEntries = _mapPathsForToken(
      pathSegments,
      modeBranchesByCollection[pathSegments[0]] ?? const {},
    );

    for (final mapped in mappedEntries) {
      switch (token.type) {
        case 'color':
          final value = _parseColor(token.value, token);
          _addToken<int>(
            colorTokens,
            mapped,
            AliasOr<int>.data(data: value),
          );
        case 'number':
          final value = _parseNumber(token.value, token);
          _addToken<double>(
            numberTokens,
            mapped,
            AliasOr<double>.data(data: value),
          );
        case 'boolean':
          final value = _parseBool(token.value, token);
          _addToken<bool>(
            boolTokens,
            mapped,
            AliasOr<bool>.data(data: value),
          );
        case 'text':
          final value = _parseString(token.value, token);
          _addToken<String>(
            stringTokens,
            mapped,
            AliasOr<String>.data(data: value),
          );
        case 'typography':
          final value = _parseTypography(token.value, token);
          _addToken<Typography>(
            typographyTokens,
            mapped,
            AliasOr<Typography>.data(data: value),
          );
        default:
          throw FormatException(
            'Unsupported token type "${token.type}" at '
            '${_formatPath(token.pathSegments)}.',
            token.filePath,
          );
      }
    }
  }

  return [
    ...colorTokens.values.expand((list) => list).map(
      (acc) => JsonToken<int>(
        name: acc.name,
        fullName: acc.fullName,
        collectionName: acc.collectionName,
        collectionId: acc.collectionName,
        valuesByModeName: acc.valuesByModeName,
      ),
    ),
    ...numberTokens.values.expand((list) => list).map(
      (acc) => JsonToken<double>(
        name: acc.name,
        fullName: acc.fullName,
        collectionName: acc.collectionName,
        collectionId: acc.collectionName,
        valuesByModeName: acc.valuesByModeName,
      ),
    ),
    ...boolTokens.values.expand((list) => list).map(
      (acc) => JsonToken<bool>(
        name: acc.name,
        fullName: acc.fullName,
        collectionName: acc.collectionName,
        collectionId: acc.collectionName,
        valuesByModeName: acc.valuesByModeName,
      ),
    ),
    ...stringTokens.values.expand((list) => list).map(
      (acc) => JsonToken<String>(
        name: acc.name,
        fullName: acc.fullName,
        collectionName: acc.collectionName,
        collectionId: acc.collectionName,
        valuesByModeName: acc.valuesByModeName,
      ),
    ),
    ...typographyTokens.values.expand((list) => list).map(
      (acc) => JsonToken<Typography>(
        name: acc.name,
        fullName: acc.fullName,
        collectionName: acc.collectionName,
        collectionId: acc.collectionName,
        valuesByModeName: acc.valuesByModeName,
      ),
    ),
  ];
}

List<({String collectionName, String mode, String name, String fullName})>
    _mapPathsForToken(
  List<String> pathSegments,
  Set<String> modeBranches,
) {
  if (pathSegments.length == 1) {
    final name = pathSegments.first;
    return [
      (
        collectionName: '',
        mode: '',
        name: name,
        fullName: name,
      ),
    ];
  }

  if (pathSegments.length == 2) {
    final collectionName = pathSegments[0];
    final name = pathSegments[1];
    if (modeBranches.isNotEmpty) {
      final sortedModes = modeBranches.toList()..sort();
      return [
        for (final mode in sortedModes)
          (
            collectionName: collectionName,
            mode: mode,
            name: name,
            fullName: '$collectionName/$name',
          ),
      ];
    }
    return [
      (
        collectionName: collectionName,
        mode: '',
        name: name,
        fullName: '$collectionName/$name',
      ),
    ];
  }

  final collection = pathSegments[0];
  final secondSegment = pathSegments[1];
  final name = pathSegments.sublist(2).join('/');

  if (modeBranches.contains(secondSegment)) {
    return [
      (
        collectionName: collection,
        mode: secondSegment,
        name: name,
        fullName: '$collection/$name',
      ),
    ];
  }

  final collectionName = '$collection/$secondSegment';
  return [
    (
      collectionName: collectionName,
      mode: '',
      name: name,
      fullName: '$collectionName/$name',
    ),
  ];
}

void _addToken<T>(
  Map<String, List<_TokenAccumulator<T>>> target,
  ({String collectionName, String mode, String name, String fullName}) mapped,
  AliasOr<T> value,
) {
  final key = '${mapped.collectionName}|${mapped.name}';
  final accumulators = target.putIfAbsent(key, () => []);
  _TokenAccumulator<T>? accumulator;
  for (final existing in accumulators) {
    if (existing.valuesByModeName.containsKey(mapped.mode) == false) {
      accumulator = existing;
      break;
    }
  }

  accumulator ??= _TokenAccumulator<T>(
    collectionName: mapped.collectionName,
    name: mapped.name,
    fullName: mapped.fullName,
  );

  if (accumulators.contains(accumulator) == false) {
    accumulators.add(accumulator);
  }
  accumulator.valuesByModeName[mapped.mode] = value;
}

int _parseColor(Object? value, _RawJsonToken token) {
  if (value is! String) {
    throw FormatException(
      'Color tokens require a hex string at '
      '${_formatPath(token.pathSegments)}.',
      token.filePath,
    );
  }
  return value.toHexColorValue();
}

double _parseNumber(Object? value, _RawJsonToken token) {
  final parsed = _parseDouble(
    value,
    token,
    fieldName: 'number',
    allowValueWrapper: false,
  );
  return parsed;
}

bool _parseBool(Object? value, _RawJsonToken token) {
  if (value is bool) {
    return value;
  }
  if (value is String) {
    final normalized = value.toLowerCase().trim();
    if (normalized == 'true') {
      return true;
    }
    if (normalized == 'false') {
      return false;
    }
  }
  throw FormatException(
    'Boolean tokens require true/false at '
    '${_formatPath(token.pathSegments)}.',
    token.filePath,
  );
}

String _parseString(Object? value, _RawJsonToken token) {
  if (value is String) {
    return value;
  }
  throw FormatException(
    'Text tokens require a string at ${_formatPath(token.pathSegments)}.',
    token.filePath,
  );
}

Typography _parseTypography(Object? value, _RawJsonToken token) {
  if (value is! Map) {
    throw FormatException(
      'Typography tokens require an object at '
      '${_formatPath(token.pathSegments)}.',
      token.filePath,
    );
  }
  final map = Map<String, dynamic>.from(value);
  final fontFamily = map['fontFamily'];
  if (fontFamily is! String || fontFamily.isEmpty) {
    throw FormatException(
      'Typography tokens require fontFamily at '
      '${_formatPath(token.pathSegments)}.',
      token.filePath,
    );
  }
  final fontFamilyPostScriptName = map['fontFamilyPostScriptName'];
  if (fontFamilyPostScriptName != null &&
      fontFamilyPostScriptName is! String) {
    throw FormatException(
      'fontFamilyPostScriptName must be a string at '
      '${_formatPath(token.pathSegments)}.',
      token.filePath,
    );
  }

  final fontSize = _parseDouble(
    map['fontSize'],
    token,
    fieldName: 'fontSize',
    allowValueWrapper: true,
  );

  final fontWeightValue = map['fontWeight'];
  final fontWeight = fontWeightValue == null
      ? 400
      : _parseDouble(
          fontWeightValue,
          token,
          fieldName: 'fontWeight',
          allowValueWrapper: false,
        ).round();

  final decoration = _parseDecoration(
    map['textDecoration'] ?? map['decoration'],
    token,
  );
  final fontStyle = _parseFontStyle(map['fontStyle'], token);

  final letterSpacing = map.containsKey('letterSpacing')
      ? _parseDouble(
          map['letterSpacing'],
          token,
          fieldName: 'letterSpacing',
          allowValueWrapper: true,
        )
      : 1.0;

  final wordSpacing = map.containsKey('wordSpacing')
      ? _parseDouble(
          map['wordSpacing'],
          token,
          fieldName: 'wordSpacing',
          allowValueWrapper: true,
        )
      : 1.0;

  final lineHeightValue = map.containsKey('lineHeight')
      ? map['lineHeight']
      : map['height'];
  final lineHeight = lineHeightValue == null
      ? 1.0
      : _parseLineHeight(
          lineHeightValue,
          token,
          fontSize: fontSize,
        );

  return Typography(
    fontFamily: fontFamily,
    fontFamilyPostScriptName: fontFamilyPostScriptName as String?,
    fontSize: fontSize,
    fontWeight: fontWeight,
    decoration: decoration,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    height: lineHeight,
  );
}

double _parseDouble(
  Object? value,
  _RawJsonToken token, {
  required String fieldName,
  required bool allowValueWrapper,
}) {
  final raw = switch (value) {
    Map() when allowValueWrapper => value['value'],
    _ => value,
  };
  if (raw is num) {
    return raw.toDouble();
  }
  if (raw is String) {
    final parsed = double.tryParse(raw);
    if (parsed != null) {
      return parsed;
    }
  }
  throw FormatException(
    'Expected $fieldName to be numeric at '
    '${_formatPath(token.pathSegments)}.',
    token.filePath,
  );
}

double _parseLineHeight(
  Object? value,
  _RawJsonToken token, {
  required double fontSize,
}) {
  if (value is Map) {
    final parsed = _parseDouble(
      value['value'],
      token,
      fieldName: 'lineHeight',
      allowValueWrapper: false,
    );
    return parsed / fontSize;
  }
  return _parseDouble(
    value,
    token,
    fieldName: 'lineHeight',
    allowValueWrapper: true,
  );
}

TextDecoration _parseDecoration(Object? value, _RawJsonToken token) {
  if (value == null) {
    return TextDecoration.none;
  }
  if (value is String) {
    return switch (value) {
      'none' => TextDecoration.none,
      'lineThrough' => TextDecoration.lineThrough,
      'underline' => TextDecoration.underline,
      'overline' => TextDecoration.overline,
      _ => throw FormatException(
          'Unknown decoration "$value" at '
          '${_formatPath(token.pathSegments)}.',
          token.filePath,
        ),
    };
  }
  throw FormatException(
    'Decoration must be a string at ${_formatPath(token.pathSegments)}.',
    token.filePath,
  );
}

FontStyle _parseFontStyle(Object? value, _RawJsonToken token) {
  if (value == null) {
    return FontStyle.normal;
  }
  if (value is String) {
    return switch (value) {
      'normal' => FontStyle.normal,
      'italic' => FontStyle.italic,
      _ => throw FormatException(
          'Unknown fontStyle "$value" at '
          '${_formatPath(token.pathSegments)}.',
          token.filePath,
        ),
    };
  }
  throw FormatException(
    'FontStyle must be a string at ${_formatPath(token.pathSegments)}.',
    token.filePath,
  );
}

String _formatPath(List<String> pathSegments) {
  if (pathSegments.isEmpty) {
    return '(root)';
  }
  return pathSegments.join('.');
}
