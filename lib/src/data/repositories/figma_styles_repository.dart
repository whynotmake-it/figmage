import 'package:collection/collection.dart';
import 'package:figma/figma.dart' as figma;
import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:figmage/src/domain/repositories/styles_repository.dart';

/// {@template figma_styles_repository}
/// This repository fetches styles from the Figma API.
/// {@endtemplate}
class FigmaStylesRepository implements StylesRepository {
  @override
  // TODO(timcreatedit): implement getStyles
  Future<List<DesignStyle<dynamic>>> getStyles({
    required String fileId,
    required String token,
  }) async {
    final client = figma.FigmaClient(token);
    final figma.StylesResponse stylesResponse;
    try {
      stylesResponse = await client.getFileStyles(fileId);
    } on figma.FigmaException catch (e) {
      _throwError(e);
    }

    final styles = stylesResponse.meta?.styles ?? [];

    if (styles.isEmpty) {
      return [];
    }

    final figma.NodesResponse nodesResponse;
    try {
      nodesResponse = await client.getFileNodes(
        fileId,
        figma.FigmaQuery(
          ids: styles.map((e) => e.nodeId).whereNotNull().toList(),
        ),
      );
    } on figma.FigmaException catch (e) {
      _throwError(e);
    }
    final styleNodes = nodesResponse.nodes?.values.map((e) => e.document) ?? [];

    return [
      for (final node in styleNodes)
        if (node != null)
          if (_transformNode(node) case final style?) style
    ];
  }

  DesignStyle<dynamic>? _transformNode(figma.Node node) {
    return switch (node) {
      figma.Text(
        :final id,
        :final name?,
        :final style?,
      ) =>
        TextStyle(id: id, name: name, value: style),
      figma.Rectangle(
        :final id,
        :final name?,
        fills: [figma.Paint(:final color?), ...],
      ) =>
        ColorStyle(id: id, name: name, value: color),
      // TODO(tim): support all types
      _ => null,
    } as DesignStyle<dynamic>?;
  }

  Never _throwError(figma.FigmaException e) {
    throw switch (e) {
      figma.FigmaException(code: 403) => const UnauthorizedStylesException(),
      _ => throw UnknownStylesException(e.message),
    };
  }
}
