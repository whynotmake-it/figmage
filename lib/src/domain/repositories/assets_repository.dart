import 'dart:io';

import 'package:figmage/src/data/repositories/figma_assets_repository.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:riverpod/riverpod.dart';

/// A provider for an [AssetsRepository] that fetches assets from Figma.
final assetsRepositoryProvider =
    Provider<AssetsRepository>((ref) => FigmaAssetsRepository());

/// {@template assets_repository}
/// A repository for fetching and saving assets from Figma.
/// {@endtemplate}
abstract interface class AssetsRepository {
  /// Fetches and saves assets for a Figma file specified by [fileId].
  ///
  /// Parameters:
  /// - [fileId]: The unique identifier of the Figma file
  /// - [token]: The access token for authentication
  /// - [nodeIds]: Map of node IDs to their configurations
  /// - [outputDir]: Directory to save the assets to
  ///
  /// Returns a map of successfully downloaded assets and their paths.
  Future<Map<String, String>> fetchAndSaveAssets({
    required String fileId,
    required String token,
    required Map<String, AssetNodeSettings> nodeSettings,
    required Directory outputDir,
  });
}

/// {@template assets_exception}
/// Base class for all asset repository exceptions.
/// {@endtemplate}
sealed class AssetsException implements Exception {
  /// {@macro assets_exception}
  const AssetsException();

  /// The message of the exception.
  String get message;
}

/// {@template unauthorized_assets_exception}
/// Exception thrown when the user is not authorized to access the assets.
/// {@endtemplate}
class UnauthorizedAssetsException extends AssetsException {
  /// {@macro unauthorized_assets_exception}
  const UnauthorizedAssetsException([String? message])
      : message = message ??
            'Unauthorized. Make sure you have a valid access token '
                'that can access the file.';

  @override
  final String message;
}

/// {@template unknown_assets_exception}
/// An exception that is thrown during asset fetching that can't be
/// classified as any other exception.
/// {@endtemplate}
class UnknownAssetsException extends AssetsException {
  /// {@macro unknown_assets_exception}
  const UnknownAssetsException(String? message)
      : message = message ?? 'Unknown error happened during asset fetching.';

  @override
  final String message;
}
