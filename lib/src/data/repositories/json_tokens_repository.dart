import 'dart:convert';
import 'dart:io';

import 'package:figmage/src/data/util/converters/hex_color_conversion_x.dart';
import 'package:figmage/src/data/util/converters/type_style_conversion_x.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/json_token.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/repositories/json_tokens_repository.dart';
import 'package:path/path.dart' as p;

/// {@template file_json_tokens_repository}
/// Reads tokens from local JSON files.
/// {@endtemplate}
class FileJsonTokensRepository implements JsonTokensRepository {
  /// {@macro file_json_tokens_repository}
  const FileJsonTokensRepository();

  @override
  Future<List<DesignToken<dynamic>>> getTokens({
    required Iterable<String> paths,
    void Function(String message)? onDiagnostic,
  }) async {
    final pathList = paths.toList(growable: false);
    if (pathList.isEmpty) {
      return [];
    }
    if (pathList.length != 1) {
      throw ArgumentError.value(
        pathList,
        'paths',
        'JSON resolver mode requires exactly one resolver manifest path.',
      );
    }

    final resolverPath = p.normalize(pathList.single);
    final resolverFile = File(resolverPath);
    if (resolverFile.existsSync() == false) {
      throw FileSystemException('Resolver manifest not found.', resolverPath);
    }

    final resolverDocument = _readJsonObject(
      await resolverFile.readAsString(),
      resolverPath,
      topLevelError:
          'Resolver manifest must contain an object at the top level.',
    );
    final manifest = _parseResolverManifest(
      resolverDocument,
      manifestPath: resolverPath,
    );

    final resolverDir = p.dirname(resolverPath);
    final orderedSets = _resolveOrderedSetPaths(
      manifest: manifest,
      resolverDirectory: resolverDir,
    );

    final rawTokens = <_RawJsonToken>[];
    final documentsByPath = <String, Map>{};

    for (final setRef in orderedSets) {
      final setPath = setRef.setPath;
      final setFile = File(setPath);
      if (setFile.existsSync() == false) {
        throw FileSystemException(
          'Resolver referenced JSON token file not found.',
          setPath,
        );
      }
      final setDocument = _readJsonObject(
        await setFile.readAsString(),
        setPath,
        topLevelError:
            'JSON token file must contain an object at the top level.',
      );
      documentsByPath[setPath] = setDocument;
      _collectTokens(
        node: setDocument,
        setName: setRef.setName,
        pathSegments: const [],
        filePath: setPath,
        output: rawTokens,
      );
    }

    if (rawTokens.isEmpty) {
      return [];
    }

    final grouping = _detectModeGroups(rawTokens);
    final diagnostics = <String>[];

    final tokensByKey = <String, _RawJsonToken>{
      for (final token in rawTokens) token.cacheKey: token,
    };
    final tokensByCanonicalPath = <String, List<_RawJsonToken>>{};
    for (final token in rawTokens) {
      tokensByCanonicalPath
          .putIfAbsent(token.canonicalPathKey, () => <_RawJsonToken>[])
          .add(token);
    }

    final aliasCache = <String, AliasOr<dynamic>>{};
    final aliasVisitStack = <String>{};

    final tokens = _buildTokens(
      tokens: rawTokens,
      modeGroupsByCollectionAndType: grouping.modeGroupsByCollectionAndType,
      branchPrefixedBranchesByCollectionAndType:
          grouping.branchPrefixedBranchesByCollectionAndType,
      resolveColor: (token) => _resolveValue<int>(
        token: token,
        expectedType: 'color',
        parseLiteral: _parseColor,
        tokensByKey: tokensByKey,
        tokensByCanonicalPath: tokensByCanonicalPath,
        documentsByPath: documentsByPath,
        resolverDirectory: resolverDir,
        cache: aliasCache,
        visitStack: aliasVisitStack,
        diagnostics: diagnostics,
      ),
      resolveNumber: (token) => _resolveValue<double>(
        token: token,
        expectedType: 'number',
        parseLiteral: _parseNumber,
        tokensByKey: tokensByKey,
        tokensByCanonicalPath: tokensByCanonicalPath,
        documentsByPath: documentsByPath,
        resolverDirectory: resolverDir,
        cache: aliasCache,
        visitStack: aliasVisitStack,
        diagnostics: diagnostics,
      ),
      resolveBool: (token) => _resolveValue<bool>(
        token: token,
        expectedType: 'boolean',
        parseLiteral: _parseBool,
        tokensByKey: tokensByKey,
        tokensByCanonicalPath: tokensByCanonicalPath,
        documentsByPath: documentsByPath,
        resolverDirectory: resolverDir,
        cache: aliasCache,
        visitStack: aliasVisitStack,
        diagnostics: diagnostics,
      ),
      resolveText: (token) => _resolveValue<String>(
        token: token,
        expectedType: 'text',
        parseLiteral: _parseString,
        tokensByKey: tokensByKey,
        tokensByCanonicalPath: tokensByCanonicalPath,
        documentsByPath: documentsByPath,
        resolverDirectory: resolverDir,
        cache: aliasCache,
        visitStack: aliasVisitStack,
        diagnostics: diagnostics,
      ),
      resolveTypography: (token) => _resolveValue<Typography>(
        token: token,
        expectedType: 'typography',
        parseLiteral: (value, token) =>
            _parseTypography(value, token, diagnostics),
        tokensByKey: tokensByKey,
        tokensByCanonicalPath: tokensByCanonicalPath,
        documentsByPath: documentsByPath,
        resolverDirectory: resolverDir,
        cache: aliasCache,
        visitStack: aliasVisitStack,
        diagnostics: diagnostics,
      ),
    );

    for (final message in diagnostics.toSet()) {
      onDiagnostic?.call(message);
    }

    return tokens;
  }
}

class _ResolverManifest {
  const _ResolverManifest({
    required this.version,
    required this.setRefsByName,
    required this.resolutionOrder,
  });

  final String version;
  final Map<String, String> setRefsByName;
  final List<String> resolutionOrder;
}

class _RawJsonToken {
  const _RawJsonToken({
    required this.setName,
    required this.pathSegments,
    required this.type,
    required this.value,
    required this.filePath,
  });

  final String setName;
  final List<String> pathSegments;
  final String type;
  final Object? value;
  final String filePath;

  String get cacheKey => _tokenKey(filePath, pathSegments);
  String get canonicalPathKey => _canonicalTokenPathKey([
    setName,
    ...pathSegments,
  ]);
  String get modeGroupScope =>
      pathSegments.isEmpty ? setName : '$setName/${pathSegments.first}';
}

class _TokenAccumulator<T> {
  _TokenAccumulator({
    required this.collectionName,
    required this.collectionId,
    required this.name,
    required this.fullName,
  });

  final String collectionName;
  final String collectionId;
  final String name;
  final String fullName;
  final Map<String, AliasOr<T>> valuesByModeName = {};
}

class _AliasTarget {
  const _AliasTarget({
    required this.key,
    required this.id,
  });

  final String key;
  final String id;
}

Map _readJsonObject(
  String raw,
  String filePath, {
  required String topLevelError,
}) {
  final decoded = jsonDecode(raw);
  if (decoded is! Map) {
    throw FormatException(topLevelError, filePath);
  }
  return decoded;
}

_ResolverManifest _parseResolverManifest(
  Map<dynamic, dynamic> json, {
  required String manifestPath,
}) {
  final version = json['version'];
  if (version is! String || version.trim().isEmpty) {
    throw FormatException(
      'Resolver manifest must define a non-empty "version".',
      manifestPath,
    );
  }

  final sets = json['sets'];
  if (sets is! Map || sets.isEmpty) {
    throw FormatException(
      'Resolver manifest must define a non-empty "sets" object.',
      manifestPath,
    );
  }

  final setRefsByName = <String, String>{};
  for (final entry in sets.entries) {
    final setName = entry.key;
    final setValue = entry.value;
    if (setName is! String) {
      throw FormatException(
        'Resolver set names must be strings.',
        manifestPath,
      );
    }
    if (setValue is! Map || setValue[r'$ref'] is! String) {
      throw FormatException(
        'Resolver set "$setName" must define a string "\$ref".',
        manifestPath,
      );
    }
    final ref = (setValue[r'$ref'] as String).trim();
    if (ref.isEmpty) {
      throw FormatException(
        'Resolver set "$setName" has an empty "\$ref".',
        manifestPath,
      );
    }
    if (ref.contains('#')) {
      throw FormatException(
        r'Resolver set "$ref" must point to a file without a JSON pointer.',
        manifestPath,
      );
    }
    setRefsByName[setName] = ref;
  }

  final resolutionOrder = json['resolutionOrder'];
  if (resolutionOrder is! List || resolutionOrder.isEmpty) {
    throw FormatException(
      'Resolver manifest must define a non-empty "resolutionOrder" list.',
      manifestPath,
    );
  }

  final parsedOrder = <String>[];
  for (final item in resolutionOrder) {
    if (item is! String || item.trim().isEmpty) {
      throw FormatException(
        'Resolver "resolutionOrder" entries must be non-empty strings.',
        manifestPath,
      );
    }
    if (setRefsByName.containsKey(item) == false) {
      throw FormatException(
        'Resolver "resolutionOrder" references unknown set "$item".',
        manifestPath,
      );
    }
    parsedOrder.add(item);
  }

  return _ResolverManifest(
    version: version,
    setRefsByName: setRefsByName,
    resolutionOrder: parsedOrder,
  );
}

List<({String setName, String setPath})> _resolveOrderedSetPaths({
  required _ResolverManifest manifest,
  required String resolverDirectory,
}) {
  final result = <({String setName, String setPath})>[];
  final seen = <String>{};

  for (final setName in manifest.resolutionOrder) {
    final refPath = manifest.setRefsByName[setName]!;
    final resolvedPath = p.normalize(
      p.isAbsolute(refPath) ? refPath : p.join(resolverDirectory, refPath),
    );

    if (seen.contains(resolvedPath)) {
      throw FormatException(
        'Resolver contains ambiguous duplicate set file reference: '
        '$resolvedPath',
      );
    }
    seen.add(resolvedPath);
    result.add((setName: setName, setPath: resolvedPath));
  }

  return result;
}

void _collectTokens({
  required Object? node,
  required String setName,
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
        setName: setName,
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
      setName: setName,
      pathSegments: [...pathSegments, key],
      filePath: filePath,
      output: output,
    );
  }
}

({
  Map<String, Map<String, Map<String, ({String modeName})>>>
  modeGroupsByCollectionAndType,
  Map<String, Map<String, Set<String>>>
  branchPrefixedBranchesByCollectionAndType,
})
_detectModeGroups(
  List<_RawJsonToken> tokens,
) {
  final branchesByCollectionAndType =
      <String, Map<String, Map<String, Set<String>>>>{};
  for (final token in tokens) {
    if (token.pathSegments.length < 3) {
      continue;
    }
    final collection = token.modeGroupScope;
    final type = token.type;
    final branch = token.pathSegments[1];
    final name = token.pathSegments.sublist(2).join('/');
    final branchMapByType = branchesByCollectionAndType.putIfAbsent(
      collection,
      () => <String, Map<String, Set<String>>>{},
    );
    final branchMap = branchMapByType.putIfAbsent(
      type,
      () => <String, Set<String>>{},
    );
    branchMap.putIfAbsent(branch, () => <String>{}).add(name);
  }

  final modeGroupsByCollectionAndType =
      <String, Map<String, Map<String, ({String modeName})>>>{};
  final branchPrefixedBranchesByCollectionAndType =
      <String, Map<String, Set<String>>>{};
  for (final collectionEntry in branchesByCollectionAndType.entries) {
    final modeGroupsByType = <String, Map<String, ({String modeName})>>{};
    final branchPrefixedByType = <String, Set<String>>{};
    for (final typeEntry in collectionEntry.value.entries) {
      final branches = typeEntry.value;
      if (branches.length <= 1) {
        continue;
      }

      final signatures = branches.values.map(_signatureForNameSet).toSet();
      final sortedBranches = branches.keys.toList()..sort();
      if (signatures.length == 1) {
        final modeEntries = <String, ({String modeName})>{};
        for (final branch in sortedBranches) {
          modeEntries[branch] = (modeName: branch);
        }
        modeGroupsByType[typeEntry.key] = modeEntries;
      } else {
        branchPrefixedByType[typeEntry.key] = sortedBranches.toSet();
      }
    }
    if (modeGroupsByType.isNotEmpty) {
      modeGroupsByCollectionAndType[collectionEntry.key] = modeGroupsByType;
    }
    if (branchPrefixedByType.isNotEmpty) {
      branchPrefixedBranchesByCollectionAndType[collectionEntry.key] =
          branchPrefixedByType;
    }
  }
  return (
    modeGroupsByCollectionAndType: modeGroupsByCollectionAndType,
    branchPrefixedBranchesByCollectionAndType:
        branchPrefixedBranchesByCollectionAndType,
  );
}

String _signatureForNameSet(Set<String> names) {
  final sorted = names.toList()..sort();
  return sorted.join('\t');
}

List<DesignToken<dynamic>> _buildTokens({
  required List<_RawJsonToken> tokens,
  required Map<String, Map<String, Map<String, ({String modeName})>>>
  modeGroupsByCollectionAndType,
  required Map<String, Map<String, Set<String>>>
  branchPrefixedBranchesByCollectionAndType,
  required AliasOr<int> Function(_RawJsonToken token) resolveColor,
  required AliasOr<double> Function(_RawJsonToken token) resolveNumber,
  required AliasOr<bool> Function(_RawJsonToken token) resolveBool,
  required AliasOr<String> Function(_RawJsonToken token) resolveText,
  required AliasOr<Typography> Function(_RawJsonToken token) resolveTypography,
}) {
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
      modeGroupsByCollectionAndType[token.modeGroupScope]?[token.type] ??
          const <String, ({String modeName})>{},
      branchPrefixedBranchesByCollectionAndType[token.modeGroupScope]?[token
              .type] ??
          const <String>{},
    );

    for (final mapped in mappedEntries) {
      final scoped = _mapToSetScopedCollection(
        token: token,
        mapped: mapped,
      );
      switch (token.type) {
        case 'color':
          _addToken<int>(
            colorTokens,
            scoped,
            resolveColor(token),
          );
        case 'number':
          _addToken<double>(
            numberTokens,
            scoped,
            resolveNumber(token),
          );
        case 'boolean':
          _addToken<bool>(
            boolTokens,
            scoped,
            resolveBool(token),
          );
        case 'text':
          _addToken<String>(
            stringTokens,
            scoped,
            resolveText(token),
          );
        case 'typography':
          _addToken<Typography>(
            typographyTokens,
            scoped,
            resolveTypography(token),
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
    ...colorTokens.values
        .expand((list) => list)
        .map(
          (acc) => JsonToken<int>(
            name: acc.name,
            fullName: acc.fullName,
            collectionName: acc.collectionName,
            collectionId: acc.collectionId,
            valuesByModeName: acc.valuesByModeName,
          ),
        ),
    ...numberTokens.values
        .expand((list) => list)
        .map(
          (acc) => JsonToken<double>(
            name: acc.name,
            fullName: acc.fullName,
            collectionName: acc.collectionName,
            collectionId: acc.collectionId,
            valuesByModeName: acc.valuesByModeName,
          ),
        ),
    ...boolTokens.values
        .expand((list) => list)
        .map(
          (acc) => JsonToken<bool>(
            name: acc.name,
            fullName: acc.fullName,
            collectionName: acc.collectionName,
            collectionId: acc.collectionId,
            valuesByModeName: acc.valuesByModeName,
          ),
        ),
    ...stringTokens.values
        .expand((list) => list)
        .map(
          (acc) => JsonToken<String>(
            name: acc.name,
            fullName: acc.fullName,
            collectionName: acc.collectionName,
            collectionId: acc.collectionId,
            valuesByModeName: acc.valuesByModeName,
          ),
        ),
    ...typographyTokens.values
        .expand((list) => list)
        .map(
          (acc) => JsonToken<Typography>(
            name: acc.name,
            fullName: acc.fullName,
            collectionName: acc.collectionName,
            collectionId: acc.collectionId,
            valuesByModeName: acc.valuesByModeName,
          ),
        ),
  ];
}

AliasOr<T> _resolveValue<T>({
  required _RawJsonToken token,
  required String expectedType,
  required T Function(Object? value, _RawJsonToken token) parseLiteral,
  required Map<String, _RawJsonToken> tokensByKey,
  required Map<String, List<_RawJsonToken>> tokensByCanonicalPath,
  required Map<String, Map> documentsByPath,
  required String resolverDirectory,
  required Map<String, AliasOr<dynamic>> cache,
  required Set<String> visitStack,
  required List<String> diagnostics,
}) {
  final tokenKey = token.cacheKey;

  final cached = cache[tokenKey];
  if (cached != null) {
    return cached as AliasOr<T>;
  }

  if (visitStack.contains(tokenKey)) {
    diagnostics.add(
      'Cycle detected while resolving token ${_formatPath(token.pathSegments)} '
      'in ${token.filePath}.',
    );
    final unresolved = AliasOr<T>.unresolved(id: tokenKey);
    cache[tokenKey] = unresolved;
    return unresolved;
  }

  visitStack.add(tokenKey);

  final aliasTarget = _extractAliasTarget(
    token: token,
    tokensByKey: tokensByKey,
    tokensByCanonicalPath: tokensByCanonicalPath,
    resolverDirectory: resolverDirectory,
    documentsByPath: documentsByPath,
    diagnostics: diagnostics,
  );

  late final AliasOr<T> result;
  if (aliasTarget != null) {
    final targetToken = tokensByKey[aliasTarget.key];

    if (targetToken == null) {
      diagnostics.add(
        'Unresolved reference "${aliasTarget.id}" at '
        '${_formatPath(token.pathSegments)} in ${token.filePath}.',
      );
      result = AliasOr<T>.unresolved(id: aliasTarget.id);
    } else if (targetToken.type != expectedType) {
      diagnostics.add(
        'Type mismatch for reference "${aliasTarget.id}" at '
        '${_formatPath(token.pathSegments)} in ${token.filePath}: '
        'expected $expectedType, got ${targetToken.type}.',
      );
      result = AliasOr<T>.unresolved(id: aliasTarget.id);
    } else {
      final targetResolved = _resolveValue<T>(
        token: targetToken,
        expectedType: expectedType,
        parseLiteral: parseLiteral,
        tokensByKey: tokensByKey,
        tokensByCanonicalPath: tokensByCanonicalPath,
        documentsByPath: documentsByPath,
        resolverDirectory: resolverDirectory,
        cache: cache,
        visitStack: visitStack,
        diagnostics: diagnostics,
      );
      result = AliasOr<T>.alias(
        id: aliasTarget.id,
        aliasOrValue: targetResolved,
      );
    }
  } else {
    try {
      result = AliasOr<T>.data(
        data: parseLiteral(token.value, token),
      );
    } on FormatException {
      visitStack.remove(tokenKey);
      rethrow;
    } catch (_) {
      diagnostics.add(
        'Failed to parse literal value at ${_formatPath(token.pathSegments)} '
        'in ${token.filePath}.',
      );
      result = AliasOr<T>.unresolved(id: tokenKey);
    }
  }

  visitStack.remove(tokenKey);
  cache[tokenKey] = result;
  return result;
}

_AliasTarget? _extractAliasTarget({
  required _RawJsonToken token,
  required Map<String, _RawJsonToken> tokensByKey,
  required Map<String, List<_RawJsonToken>> tokensByCanonicalPath,
  required String resolverDirectory,
  required Map<String, Map> documentsByPath,
  required List<String> diagnostics,
}) {
  final value = token.value;

  if (value case final String raw) {
    final trimmed = raw.trim();
    if (_isCurlyAlias(trimmed) == false) {
      return null;
    }

    final inner = trimmed.substring(1, trimmed.length - 1).trim();
    final segments = inner
        .split('.')
        .map((segment) => segment.trim())
        .where((segment) => segment.isNotEmpty)
        .toList(growable: false);

    if (segments.isEmpty) {
      diagnostics.add(
        'Invalid empty alias reference at ${_formatPath(token.pathSegments)} '
        'in ${token.filePath}.',
      );
      return _AliasTarget(
        key: _invalidAliasTargetKey(token, 'empty_curly'),
        id: inner,
      );
    }

    final globalAliasPath = _canonicalTokenPathKey(segments);
    var matches =
        tokensByCanonicalPath[globalAliasPath] ?? const <_RawJsonToken>[];
    if (matches.isEmpty) {
      final localAliasPath = _canonicalTokenPathKey([
        token.setName,
        ...segments,
      ]);
      matches =
          tokensByCanonicalPath[localAliasPath] ?? const <_RawJsonToken>[];
    }
    final aliasId = '{${segments.join('.')}}';
    if (matches.isEmpty) {
      diagnostics.add(
        'Unresolved reference "$aliasId" at '
        '${_formatPath(token.pathSegments)} in ${token.filePath}.',
      );
      return _AliasTarget(
        key: _invalidAliasTargetKey(token, 'curly_missing'),
        id: aliasId,
      );
    }
    if (matches.length > 1) {
      final matchLocations =
          matches
              .map(
                (match) =>
                    '${_formatPath(match.pathSegments)} in ${match.filePath}',
              )
              .toList()
            ..sort();
      diagnostics.add(
        'Ambiguous reference "$aliasId" at '
        '${_formatPath(token.pathSegments)} in ${token.filePath}: '
        'matches ${matches.length} tokens (${matchLocations.join('; ')}).',
      );
      return _AliasTarget(
        key: _invalidAliasTargetKey(token, 'curly_ambiguous'),
        id: aliasId,
      );
    }

    return _AliasTarget(
      key: matches.single.cacheKey,
      id: aliasId,
    );
  }

  if (value case final Map map when map.containsKey(r'$ref')) {
    final ref = map[r'$ref'];
    if (ref is! String || ref.trim().isEmpty) {
      diagnostics.add(
        'Invalid \$ref at ${_formatPath(token.pathSegments)} in '
        '${token.filePath}: expected non-empty string.',
      );
      return _AliasTarget(
        key: _invalidAliasTargetKey(token, 'ref_invalid_type'),
        id: r'$ref',
      );
    }

    final parts = ref.split('#');
    if (parts.length != 2) {
      diagnostics.add(
        'Invalid \$ref "$ref" at ${_formatPath(token.pathSegments)} in '
        '${token.filePath}: expected "path#/json/pointer".',
      );
      return _AliasTarget(
        key: _invalidAliasTargetKey(token, 'ref_invalid_format'),
        id: ref,
      );
    }

    final filePart = parts[0].trim();
    final pointerPart = parts[1].trim();
    final targetFilePath = filePart.isEmpty
        ? token.filePath
        : p.normalize(
            p.isAbsolute(filePart)
                ? filePart
                : p.join(resolverDirectory, filePart),
          );
    final pointerSegments = _parseJsonPointer(pointerPart);
    if (pointerSegments == null) {
      diagnostics.add(
        'Invalid JSON pointer in \$ref "$ref" at '
        '${_formatPath(token.pathSegments)} in ${token.filePath}.',
      );
      return _AliasTarget(
        key: _invalidAliasTargetKey(token, 'ref_invalid_pointer'),
        id: ref,
      );
    }

    final targetDocument = documentsByPath[targetFilePath];
    if (targetDocument == null) {
      diagnostics.add(
        'Referenced file "$targetFilePath" is not part of the resolver sets '
        'for \$ref "$ref" at ${_formatPath(token.pathSegments)} in '
        '${token.filePath}.',
      );
      return _AliasTarget(
        key: _tokenKey(targetFilePath, pointerSegments),
        id: ref,
      );
    }

    final pointedNode = _readNodeAtPointer(targetDocument, pointerSegments);
    if (pointedNode == null) {
      diagnostics.add(
        'JSON pointer in \$ref "$ref" did not resolve at '
        '${_formatPath(token.pathSegments)} in ${token.filePath}.',
      );
      return _AliasTarget(
        key: _tokenKey(targetFilePath, pointerSegments),
        id: ref,
      );
    }

    final tokenSegments = _tokenSegmentsForRefTarget(
      pointerSegments: pointerSegments,
      pointedNode: pointedNode,
      rootDocument: targetDocument,
    );
    if (tokenSegments == null) {
      diagnostics.add(
        '\$ref "$ref" points to a non-token location '
        'at ${_formatPath(token.pathSegments)} in ${token.filePath}.',
      );
      return _AliasTarget(
        key: _tokenKey(targetFilePath, pointerSegments),
        id: ref,
      );
    }

    final targetKey = _tokenKey(targetFilePath, tokenSegments);
    if (tokensByKey.containsKey(targetKey) == false) {
      diagnostics.add(
        'Unresolved reference "$ref" at '
        '${_formatPath(token.pathSegments)} in ${token.filePath}.',
      );
      return _AliasTarget(
        key: targetKey,
        id: ref,
      );
    }

    return _AliasTarget(
      key: targetKey,
      id: ref,
    );
  }

  return null;
}

bool _isCurlyAlias(String value) =>
    value.startsWith('{') && value.endsWith('}') && value.length > 2;

List<String>? _parseJsonPointer(String pointer) {
  if (pointer.isEmpty) {
    return const [];
  }
  if (pointer.startsWith('/')) {
    final decodedSegments = <String>[];
    for (final segment in pointer.split('/').skip(1)) {
      final decodedSegment = _decodePointerSegment(segment);
      if (decodedSegment == null) {
        return null;
      }
      decodedSegments.add(decodedSegment);
    }
    return decodedSegments;
  }
  return null;
}

String? _decodePointerSegment(String segment) {
  final buffer = StringBuffer();
  var i = 0;
  while (i < segment.length) {
    final char = segment[i];
    if (char != '~') {
      buffer.write(char);
      i += 1;
      continue;
    }
    if (i + 1 >= segment.length) {
      return null;
    }
    final escaped = segment[i + 1];
    switch (escaped) {
      case '0':
        buffer.write('~');
      case '1':
        buffer.write('/');
      default:
        return null;
    }
    i += 2;
  }
  return buffer.toString();
}

Object? _readNodeAtPointer(Object? node, List<String> pointerSegments) {
  var current = node;
  for (final segment in pointerSegments) {
    if (current is Map) {
      if (current.containsKey(segment) == false) {
        return null;
      }
      current = current[segment];
      continue;
    }
    if (current is List) {
      final index = int.tryParse(segment);
      if (index == null || index < 0 || index >= current.length) {
        return null;
      }
      current = current[index];
      continue;
    }
    return null;
  }
  return current;
}

String _tokenKey(String filePath, List<String> pathSegments) {
  return '${p.normalize(filePath)}#${pathSegments.join('/')}';
}

String _invalidAliasTargetKey(_RawJsonToken token, String reason) {
  return '${token.cacheKey}::invalid::$reason';
}

String _canonicalTokenPathKey(List<String> pathSegments) {
  return pathSegments.join('/');
}

List<String>? _tokenSegmentsForRefTarget({
  required List<String> pointerSegments,
  required Object? pointedNode,
  required Map rootDocument,
}) {
  if (_isTokenObject(pointedNode)) {
    return pointerSegments;
  }

  if (pointerSegments.isNotEmpty && pointerSegments.last == r'$value') {
    final parentSegments = pointerSegments.sublist(
      0,
      pointerSegments.length - 1,
    );
    final parentNode = _readNodeAtPointer(rootDocument, parentSegments);
    if (_isTokenObject(parentNode)) {
      return parentSegments;
    }
  }

  return null;
}

bool _isTokenObject(Object? node) {
  return node is Map && node.containsKey(r'$value') && node[r'$type'] is String;
}

List<
  ({
    String collectionName,
    String mode,
    String name,
    String fullName,
    bool preserveCollectionScope,
  })
>
_mapPathsForToken(
  List<String> pathSegments,
  Map<String, ({String modeName})> modeEntries,
  Set<String> branchPrefixedBranches,
) {
  if (pathSegments.length == 1) {
    final name = pathSegments.first;
    return [
      (
        collectionName: '',
        mode: '',
        name: name,
        fullName: name,
        preserveCollectionScope: false,
      ),
    ];
  }

  if (pathSegments.length == 2) {
    final collectionName = pathSegments[0];
    final name = pathSegments[1];
    if (modeEntries.isNotEmpty) {
      final promotedCollectionName = '$collectionName/$name';
      return [
        (
          collectionName: promotedCollectionName,
          mode: '',
          name: name,
          fullName: '$collectionName/$name',
          preserveCollectionScope: false,
        ),
      ];
    }
    return [
      (
        collectionName: collectionName,
        mode: '',
        name: name,
        fullName: '$collectionName/$name',
        preserveCollectionScope: false,
      ),
    ];
  }

  final collection = pathSegments[0];
  final secondSegment = pathSegments[1];
  final name = pathSegments.sublist(2).join('/');

  final modeEntry = modeEntries[secondSegment];
  if (modeEntry != null) {
    return [
      (
        collectionName: collection,
        mode: modeEntry.modeName,
        name: name,
        fullName: '$collection/$name',
        preserveCollectionScope: true,
      ),
    ];
  }

  if (branchPrefixedBranches.contains(secondSegment)) {
    final branchPrefixedName = '$secondSegment/$name';
    return [
      (
        collectionName: collection,
        mode: '',
        name: branchPrefixedName,
        fullName: '$collection/$branchPrefixedName',
        preserveCollectionScope: true,
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
      preserveCollectionScope: true,
    ),
  ];
}

({
  String collectionName,
  String collectionId,
  String mode,
  String name,
  String fullName,
})
_mapToSetScopedCollection({
  required _RawJsonToken token,
  required ({
    String collectionName,
    String mode,
    String name,
    String fullName,
    bool preserveCollectionScope,
  })
  mapped,
}) {
  final useScopedCollection = mapped.preserveCollectionScope;
  final scopedCollectionName = useScopedCollection
      ? '${token.setName}/${mapped.collectionName}'
      : token.setName;
  final tokenName = useScopedCollection
      ? mapped.name
      : mapped.collectionName.isEmpty
      ? mapped.name
      : '${mapped.collectionName}/${mapped.name}';
  return (
    collectionName: scopedCollectionName,
    collectionId: scopedCollectionName,
    mode: mapped.mode,
    name: tokenName,
    fullName: '$scopedCollectionName/$tokenName',
  );
}

void _addToken<T>(
  Map<String, List<_TokenAccumulator<T>>> target,
  ({
    String collectionName,
    String collectionId,
    String mode,
    String name,
    String fullName,
  })
  mapped,
  AliasOr<T> value,
) {
  final key = '${mapped.collectionId}|${mapped.name}';
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
    collectionId: mapped.collectionId,
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
  final trimmed = value.trim();
  if (trimmed.startsWith('rgba(') && trimmed.endsWith(')')) {
    return _parseRgbaColor(trimmed, token);
  }
  return trimmed.toHexColorValue();
}

int _parseRgbaColor(String rgba, _RawJsonToken token) {
  final content = rgba.substring(5, rgba.length - 1);
  final parts = content.split(',').map((s) => s.trim()).toList();

  if (parts.length != 4) {
    throw FormatException(
      'rgba() color must have 4 components (r, g, b, a) at '
      '${_formatPath(token.pathSegments)}.',
      token.filePath,
    );
  }

  final r = int.tryParse(parts[0]);
  final g = int.tryParse(parts[1]);
  final b = int.tryParse(parts[2]);
  final a = double.tryParse(parts[3]);

  if (r == null || g == null || b == null || a == null) {
    throw FormatException(
      'Invalid rgba() color values at '
      '${_formatPath(token.pathSegments)}.',
      token.filePath,
    );
  }

  if (r < 0 || r > 255 || g < 0 || g > 255 || b < 0 || b > 255) {
    throw FormatException(
      'rgba() color RGB values must be 0-255 at '
      '${_formatPath(token.pathSegments)}.',
      token.filePath,
    );
  }

  if (a < 0 || a > 1) {
    throw FormatException(
      'rgba() color alpha value must be 0-1 at '
      '${_formatPath(token.pathSegments)}.',
      token.filePath,
    );
  }

  final alpha = (a * 255).round();
  return (alpha << 24) | (r << 16) | (g << 8) | b;
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

Typography _parseTypography(
  Object? value,
  _RawJsonToken token,
  List<String> diagnostics,
) {
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
  if (fontFamilyPostScriptName != null && fontFamilyPostScriptName is! String) {
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
  final rawFontWeight = fontWeightValue == null
      ? 400
      : _parseDouble(
          fontWeightValue,
          token,
          fieldName: 'fontWeight',
          allowValueWrapper: false,
        );
  final fontWeight = TypeStyleConversionX.convertFontWeight(
    rawFontWeight,
    onDiagnostic: diagnostics.add,
    diagnosticContext:
        '${_formatPath(token.pathSegments)} in '
        '${token.filePath}',
  );

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
