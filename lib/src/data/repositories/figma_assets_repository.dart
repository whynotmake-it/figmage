import 'dart:io';
import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/repositories/assets_repository.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

/// {@template figma_assets_repository}
/// A repository that fetches assets from Figma and saves them to disk.
/// {@endtemplate}
class FigmaAssetsRepository implements AssetsRepository {
  @override
  Future<Map<String, String>> fetchAndSaveAssets({
    required String fileId,
    required String token,
    required Map<String, AssetNodeSettings> nodeSettings,
    required Directory outputDir,
  }) async {
    final client = FigmaClient(token);
    final assetPaths = <String, String>{};

    try {
      for (final scale in _uniqueScales(nodeSettings)) {
        final result = await client.getImages(
          fileId,
          [
            for (final entry in nodeSettings.entries)
              if (entry.value.scales.contains(scale)) entry.key,
          ],
          scale: scale,
        );

        if (result.err != null) {
          throw UnknownAssetsException(result.err);
        }

        final images = await _downloadImages(
          images: result.images,
          nodeSettings: nodeSettings,
          scale: scale.toDouble(),
          outputDir: outputDir,
        );

        assetPaths.addAll(images);
      }
    } on FigmaException catch (e) {
      _handleFigmaException(e);
    }

    return assetPaths;
  }

  Future<Map<String, String>> _downloadImages({
    required Map<String, String?> images,
    required Map<String, AssetNodeSettings> nodeSettings,
    required double scale,
    required Directory outputDir,
  }) async {
    final assetEntries = await Future.wait(
      images.entries
          .where(
        (entry) => entry.value != null && nodeSettings.containsKey(entry.key),
      )
          .map((entry) async {
        final key = entry.key;
        final url = entry.value!;
        final config = nodeSettings[key]!;

        final scaleSuffix = scale == 1 ? '' : '@${scale}x';
        final fileName = '${config.name}$scaleSuffix.png';
        final filePath = path.join(outputDir.path, fileName);
        final file = File(filePath);

        final response = await http.get(Uri.parse(url));
        if (response.statusCode != 200) return null;

        await file.writeAsBytes(response.bodyBytes);
        return MapEntry(key, fileName);
      }),
    );

    return Map.fromEntries(
      assetEntries.whereType<MapEntry<String, String>>(),
    );
  }

  Never _handleFigmaException(FigmaException e) {
    throw switch (e) {
      FigmaException(code: 403) => const UnauthorizedAssetsException(),
      _ => UnknownAssetsException(e.message),
    };
  }
}

Set<num> _uniqueScales(
  Map<String, AssetNodeSettings> nodeSettings,
) {
  return nodeSettings.values.expand((setting) => setting.scales).toSet();
}
