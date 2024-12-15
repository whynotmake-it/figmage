import 'dart:io';
import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/repositories/assets_repository.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

/// {@template figma_assets_repository}
/// A repository that fetches assets from Figma and saves them to disk.
/// Supports downloading assets at multiple scale factors
/// (between 0.01 and 4.0).
/// Assets are saved with scale indicators in their filenames (e.g. @2x.png).
/// {@endtemplate}
class FigmaAssetsRepository implements AssetsRepository {
  @override
  Future<Map<String, List<String?>>> fetchAndSaveAssets({
    required String fileId,
    required String token,
    required Map<String, AssetNodeSettings> nodeSettings,
    required Directory outputDir,
  }) async {
    final client = FigmaClient(token);
    final assetPaths = <String, List<String?>>{};

    try {
      for (final scale in _uniqueScales(nodeSettings)) {
        final nodeIds = [
          for (final entry in nodeSettings.entries)
            if (entry.value.scales.contains(scale)) entry.key,
        ];

        if (nodeIds.isEmpty) continue;

        final result = await client.getImages(
          fileId,
          nodeIds,
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

        // Merge the results, adding new scales
        images.forEach((key, value) {
          assetPaths.putIfAbsent(key, () => []).add(value);
        });
      }
    } on FigmaException catch (e) {
      _handleFigmaException(e);
    }

    return assetPaths;
  }

  Future<File?> _downloadImage({
  required String url,
  required String fileName,
  required Directory outputDir,
}) async {
  try {
    final filePath = path.join(outputDir.path, fileName);
    final file = File(filePath);

    // Ensure the parent directory exists
    await file.parent.create(recursive: true);

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      // Download failed
      return null;
    }

    await file.writeAsBytes(response.bodyBytes);
    return file;
  } catch (_) {
    // If anything goes wrong, return null
    return null;
  }
}

Future<Map<String, String?>> _downloadImages({
  required Map<String, String?> images,
  required Map<String, AssetNodeSettings> nodeSettings,
  required double scale,
  required Directory outputDir,
}) async {
  final assetEntries = await Future.wait(
    images.entries.map((entry) async {
      final key = entry.key;
      final url = entry.value;
      final config = nodeSettings[key];

      if (url == null || config == null) {
        return MapEntry(key, null);
      }

      final scaleSuffix = scale == 1 ? '' : '@${scale}x';
      final fileName = '${config.name}$scaleSuffix.png';

      final file = await _downloadImage(
        url: url,
        fileName: fileName,
        outputDir: outputDir,
      );

      return MapEntry(key, file?.uri.pathSegments.last);
    }),
  );

  return Map.fromEntries(assetEntries);
}


  Never _handleFigmaException(FigmaException e) {
    throw switch (e) {
      FigmaException(code: 400) => InvalidParameterAssetsException(e.message),
      FigmaException(code: 403) => UnauthorizedAssetsException(e.message),
      FigmaException(code: 404) => FileNotFoundAssetsException(e.message),
      FigmaException(code: 500) => RenderingAssetsException(e.message),
      _ => UnknownAssetsException(e.message),
    };
  }
}

Set<num> _uniqueScales(
  Map<String, AssetNodeSettings> nodeSettings,
) {
  // Scale must be a number between 0.01 and 4, the image scaling factor.
  return nodeSettings.values
      .expand((setting) => setting.scales.where((s) => s >= 0.01 && s <= 4))
      .toSet();
}
