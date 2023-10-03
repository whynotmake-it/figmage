/// Original Source:
/// https://github.com/arnemolland/figma

/// A wrapper that wraps all available query values for the Figma API.
class FigmaQuery {
  /// Comma separated list of nodes that you care about in the document.
  /// If specified, only a subset of the document will be returned corresponding
  /// to the nodes listed, their children, and everything between the root node
  /// and the listed nodes.
  final List<String>? ids;

  /// A number between 0.01 and 4, the image scaling factor.
  final double? scale;

  /// A string enum for the image output format, can be jpg, png, svg, or pdf.
  final String? format;

  /// A specific version ID to get. Omitting this will get the current version
  /// of the file.
  final String? version;

  /// Positive integer representing how deep into the document tree to traverse.
  /// For example, setting this to 1 returns only Pages, setting it to 2 returns
  /// Pages and all top level objects on each page. Not setting this parameter
  /// returns all nodes.
  final int? depth;

  /// Set to "paths" to export vector data.
  final String? geometry;

  /// Whether to include id attributes for all SVG elements. Default: false.
  final bool? svgIncludeId;

  /// Whether to simplify inside/outside strokes and use stroke attribute if
  /// possible instead of <mask>. Default: true.
  final bool? svgSimplifyStroke;

  /// Use the full dimensions of the node regardless of whether or not it is
  /// cropped or the space around it is empty. Use this to export text nodes
  /// without cropping. Default: false.
  final bool? useAbsoluteBounds;

  /// Number of items in a paged list of results. Defaults to 30.
  final int? pageSize;

  /// A map that indicates the starting/ending point from which objects are
  /// returned. The cursor value is an internally tracked integer that doesn't
  /// correspond to any IDs.
  final Map<String, int>? cursor;

  /// A comma separated list of plugin IDs and/or the string "shared". Any data
  /// present in the document written by those plugins will be included in the
  /// result in the `pluginData` and `sharedPluginData` properties.
  final String? pluginData;

  const FigmaQuery({
    this.ids,
    this.scale,
    this.format,
    this.version,
    this.depth,
    this.geometry,
    this.svgIncludeId,
    this.svgSimplifyStroke,
    this.useAbsoluteBounds,
    this.pageSize,
    this.cursor,
    this.pluginData,
  });

  Map<String, String?> get params {
    var map = {
      'ids': ids?.join(','),
      'scale': scale?.toString(),
      'format': format,
      'version': version,
      'depth': depth?.toString(),
      'geometry': geometry,
      'svg_include_id': svgIncludeId?.toString(),
      'svg_simplify_stroke': svgSimplifyStroke?.toString(),
      'use_absolute_bounds': useAbsoluteBounds?.toString(),
      'page_size': pageSize?.toString(),
      'cursor': cursor?.toString(),
      'plugin_data': pluginData,
    };

    map.removeWhere((k, v) => v == null);

    return map;
  }
}
