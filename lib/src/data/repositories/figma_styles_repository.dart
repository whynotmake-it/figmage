import 'package:figma_variables_api/figma_variables_api.dart';
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
    required bool fromLibrary,
  }) async {
    final client = FigmaClient(token);
    final styles = switch (fromLibrary) {
      true => await _getPublishedStyles(client, fileId),
      false => await _getUnpublishedStyles(client, fileId),
    };

    if (styles.isEmpty) {
      return [];
    }

    final NodesResponse nodesResponse;
    try {
      nodesResponse = await client.getFileNodes(
        fileId,
        FigmaQuery(
          ids: styles.map((e) => e.nodeId).nonNulls.toList(),
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

  Future<List<Style>> _getPublishedStyles(
    FigmaClient client,
    String fileId,
  ) async {
    final StylesResponse stylesResponse;
    try {
      stylesResponse = await client.getFileStyles(fileId);
    } on FigmaException catch (e) {
      _throwError(e);
    }

    return stylesResponse.meta?.styles ?? [];
  }

  Future<List<Style>> _getUnpublishedStyles(
    FigmaClient client,
    String fileId,
  ) async {
    final FileStylesResponse response;
    try {
      response = await client.getLocalFileStyles(fileId);
    } on FigmaException catch (e) {
      _throwError(e);
    }
    final styles = [
      if (response.styles case final styles?)
        for (final MapEntry(:key, :value) in styles.entries)
          Style(
            nodeId: key,
            key: value.key,
            name: value.name,
            type: value.type,
            description: value.description,
          ),
    ];

    return styles;
  }

  DesignStyle<dynamic>? _transformNode(Node node) {
    return switch (node) {
      Text(
        :final id,
        :final name?,
        :final style?,
      ) =>
        TextDesignStyle(id: id, fullName: name, value: style.toDomain()),
      Rectangle(
        :final id,
        :final name?,
        fills: [Paint(:final color?), ...],
      ) =>
        ColorDesignStyle(id: id, fullName: name, value: color.toValue()),
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
