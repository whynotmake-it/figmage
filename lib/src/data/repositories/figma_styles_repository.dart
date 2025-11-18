import 'package:figma/figma.dart';
import 'package:figmage/src/data/util/converters/color_conversion_x.dart';
import 'package:figmage/src/data/util/converters/type_style_conversion_x.dart';
import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:figmage/src/domain/repositories/styles_repository.dart';

typedef _StyleInfo = ({
  String? nodeId,
  String key,
  String name,
  StyleType type,
  String description,
});

/// {@template figma_styles_repository}
/// This repository fetches styles from the Figma API.
/// {@endtemplate}
class FigmaStylesRepository implements StylesRepository {
  @override
  Future<List<DesignStyle<dynamic>>> getStyles({
    required String fileId,
    required String token,
    required bool fromLibrary,
    void Function(String message)? onProgress,
  }) async {
    final primaryClient = FigmaClient(token);
    Object? http2Error;
    try {
      return await _loadStyles(
        client: primaryClient,
        fileId: fileId,
        fromLibrary: fromLibrary,
        onProgress: onProgress,
      );
    } on StylesException {
      rethrow;
    } on FigmaException catch (error) {
      if (!_isHttp2ConnectionIssue(error)) {
        rethrow;
      }
      http2Error = error;
    } catch (error) {
      if (!_isHttp2ConnectionIssue(error)) {
        rethrow;
      }
      http2Error = error;
    }

    onProgress?.call(
      'Primary HTTP/2 request failed '
      '($http2Error). Retrying over HTTP/1.1...',
    );
    final fallbackClient = FigmaClient(token, useHttp2: false);
    return _loadStyles(
      client: fallbackClient,
      fileId: fileId,
      fromLibrary: fromLibrary,
      onProgress: onProgress,
    );
  }

  Future<List<DesignStyle<dynamic>>> _loadStyles({
    required FigmaClient client,
    required String fileId,
    required bool fromLibrary,
    void Function(String message)? onProgress,
  }) async {
    onProgress?.call(
      fromLibrary
          ? 'Fetching published styles metadata...'
          : 'Fetching local styles metadata...',
    );
    final styles = switch (fromLibrary) {
      true => await _getPublishedStyles(
        client,
        fileId,
        onProgress: onProgress,
      ),
      false => await _getUnpublishedStyles(
        client,
        fileId,
        onProgress: onProgress,
      ),
    };
    onProgress?.call('Retrieved metadata for ${styles.length} styles.');

    if (styles.isEmpty) {
      return [];
    }

    final nodeIds = styles
        .map((style) => style.nodeId)
        .whereType<String>()
        .toList();
    if (nodeIds.isEmpty) {
      onProgress?.call(
        'No node IDs were associated with the retrieved styles. '
        'Skipping node hydration.',
      );
      return [];
    }

    onProgress?.call(
      'Discovered ${styles.length} style metadata entries; '
      '${nodeIds.length} include node references.',
    );
    onProgress?.call(
      'Fetching ${nodeIds.length} style nodes via /files/$fileId/nodes '
      '(HTTP${client.useHttp2 ? '2' : '1.1'})...',
    );
    final nodesResponse = await _fetchNodes(client, fileId, nodeIds);
    final styleNodes = nodesResponse.nodes.values
        .map((nodeMeta) => nodeMeta.document)
        .whereType<Node>()
        .toList();
    final missingNodes = nodeIds.length - styleNodes.length;
    onProgress?.call(
      'Hydrated ${styleNodes.length} node document(s); '
      '${missingNodes.clamp(0, nodeIds.length)} node id(s) missing.',
    );
    final stylesFromNodes = [
      for (final node in styleNodes)
        if (_transformNode(node) case final style?) style,
    ];
    final droppedNodes = styleNodes.length - stylesFromNodes.length;
    onProgress?.call(
      'Converted ${styleNodes.length} node document(s) into '
      '${stylesFromNodes.length} supported style(s); '
      '$droppedNodes unsupported node(s) skipped.',
    );
    return stylesFromNodes;
  }

  Future<List<_StyleInfo>> _getPublishedStyles(
    FigmaClient client,
    String fileId, {
    void Function(String message)? onProgress,
  }) async {
    onProgress?.call(
      'Requesting published styles via /files/$fileId/styles...',
    );
    final StylesResponse stylesResponse;
    try {
      stylesResponse = await client.getFileStyles(fileId);
    } on FigmaException catch (e) {
      if (e.code == 403) {
        _throwError(e);
      }
      rethrow;
    }

    final styles = stylesResponse.meta.styles;
    onProgress?.call(
      'Retrieved metadata for ${styles.length} published styles.',
    );

    return [
      for (final style in styles)
        (
          nodeId: style.nodeId,
          key: style.key,
          name: style.name,
          type: style.styleType,
          description: style.description,
        ),
    ];
  }

  Future<List<_StyleInfo>> _getUnpublishedStyles(
    FigmaClient client,
    String fileId, {
    void Function(String message)? onProgress,
  }) async {
    final uri = Uri.https(
      'api.figma.com',
      '/${client.apiVersion}/files/$fileId',
    );
    try {
      onProgress?.call(
        'Requesting /files/$fileId for local styles metadata...',
      );
      final json = await client.authenticatedGet(uri.toString());
      final stylesRaw = json['styles'];
      if (stylesRaw is! Map<String, dynamic>) {
        return const [];
      }
      onProgress?.call(
        'Extracted ${stylesRaw.length} styles from /files response.',
      );

      // TODO(figma-api): Swap this manual parsing once the official client
      // exposes local styles directly to avoid depending on raw JSON.
      final results = <_StyleInfo>[];
      for (final MapEntry(:key, :value) in stylesRaw.entries) {
        if (value is! Map<String, dynamic>) {
          continue;
        }

        final styleKey = value['key'] as String?;
        final name = value['name'] as String?;
        final styleType = _parseStyleType(value['styleType']);
        if (styleKey == null || name == null || styleType == null) {
          continue;
        }

        results.add(
          (
            nodeId: key,
            key: styleKey,
            name: name,
            type: styleType,
            description: value['description'] as String? ?? '',
          ),
        );
      }
      onProgress?.call(
        'Parsed ${results.length} local style metadata entries.',
      );
      return results;
    } on FigmaException catch (e) {
      if (e.code == 403) {
        _throwError(e);
      }
      rethrow;
    }
  }

  DesignStyle<dynamic>? _transformNode(Node node) {
    return switch (node) {
          TextNode(
            :final id,
            :final name,
            :final style,
          ) =>
            TextDesignStyle(id: id, fullName: name, value: style.toDomain()),
          RectangleNode(
            :final id,
            :final name,
            fills: [SolidPaint(:final color, :final opacity), ...],
          ) =>
            ColorDesignStyle(
              id: id,
              fullName: name,
              value: color.toValue(opacity: opacity),
            ),
          _ => null,
        }
        as DesignStyle<dynamic>?;
  }

  Future<NodesResponse> _fetchNodes(
    FigmaClient client,
    String fileId,
    List<String> nodeIds,
  ) async {
    final uri = Uri.https(
      'api.figma.com',
      '/${client.apiVersion}/files/$fileId/nodes',
      {'ids': nodeIds.join(',')},
    );
    try {
      final json = await client.authenticatedGet(uri.toString());
      return NodesResponse.fromJson(json);
    } on FigmaException catch (e) {
      if (e.code == 403) {
        _throwError(e);
      }
      rethrow;
    }
  }

  StyleType? _parseStyleType(Object? value) {
    if (value is! String) {
      return null;
    }
    for (final styleType in StyleType.values) {
      if (styleType.name == value.toLowerCase()) {
        return styleType;
      }
    }
    return null;
  }

  Never _throwError(FigmaException e) {
    throw switch (e) {
      FigmaException(code: 403) => const UnauthorizedStylesException(),
      _ => throw UnknownStylesException(e.message),
    };
  }

  bool _isHttp2ConnectionIssue(Object error) {
    final message = error.toString();
    return message.contains('HTTP/2 error') ||
        message.contains('Stream was terminated by peer');
  }
}
