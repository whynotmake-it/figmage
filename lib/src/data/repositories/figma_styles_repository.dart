import 'package:collection/collection.dart';
import 'package:figma/figma.dart';
import 'package:figmage/src/data/util/converters/color_conversion_x.dart';
import 'package:figmage/src/data/util/converters/type_style_conversion_x.dart';
import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:figmage/src/domain/repositories/styles_repository.dart';

/// {@template figma_styles_repository}
/// This repository fetches styles from the Figma API.
/// {@endtemplate}
class FigmaStylesRepository implements StylesRepository {
  @override
  Future<List<DesignStyle<dynamic>>> getStyles({
    required String fileId,
    required String token,
  }) async {
    final client = FigmaClient(token);
    final StylesResponse stylesResponse;
    try {
      stylesResponse = await client.getFileStyles(fileId);
    } on FigmaException catch (e) {
      _throwError(e);
    }

    final styles = stylesResponse.meta?.styles ?? [];

    if (styles.isEmpty) {
      return [];
    }

    final NodesResponse nodesResponse;
    try {
      nodesResponse = await client.getFileNodes(
        fileId,
        FigmaQuery(
          ids: styles.map((e) => e.nodeId).whereNotNull().toList(),
        ),
      );
    } on FigmaException catch (e) {
      _throwError(e);
    }
    final styleNodes = nodesResponse.nodes?.values.map((e) => e.document) ?? [];

    return [
      for (final node in styleNodes)
        if (node != null)
          if (_transformNode(node) case final style?) style,
    ];
  }

  DesignStyle<dynamic>? _transformNode(Node node) {
    return switch (node) {
      Text(
        :final id,
        :final name?,
        :final style?,
      ) =>
        TextDesignStyle(id: id, name: name, value: style.toTextStyle()),
      Rectangle(
        :final id,
        :final name?,
        fills: [Paint(:final color?), ...],
      ) =>
        ColorDesignStyle(id: id, name: name, value: color.toValue()),
      _ => null,
    } as DesignStyle<dynamic>?;
  }

  Never _throwError(FigmaException e) {
    throw switch (e) {
      FigmaException(code: 403) => const UnauthorizedStylesException(),
      _ => throw UnknownStylesException(e.message),
    };
  }
}
