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
  /// - [nodeSettings]: Map of node IDs to their configurations
  /// - [outputDir]: Directory to save the assets to
  ///
  /// Returns a map of downloaded assets and their paths per scale.
  /// The path is null if the image could not be downloaded.
  Future<Map<String, List<String?>>> fetchAndSaveAssets({
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

/// {@template invalid_parameter_assets_exception}
/// Exception thrown when the request has invalid parameters.
/// {@endtemplate}
class InvalidParameterAssetsException extends AssetsException {
  /// {@macro invalid_parameter_assets_exception}
  const InvalidParameterAssetsException([String? message])
      : message = message ?? 'Invalid parameter in the request.';

  @override
  final String message;
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

/// {@template file_not_found_assets_exception}
/// Exception thrown when the specified file was not found.
/// {@endtemplate}
class FileNotFoundAssetsException extends AssetsException {
  /// {@macro file_not_found_assets_exception}
  const FileNotFoundAssetsException([String? message])
      : message = message ?? 'The specified file was not found.';

  @override
  final String message;
}

/// {@template rendering_assets_exception}
/// Exception thrown when an unexpected rendering error occurs.
/// {@endtemplate}
class RenderingAssetsException extends AssetsException {
  /// {@macro rendering_assets_exception}
  const RenderingAssetsException([String? message])
      : message = message ?? 'Unexpected rendering error occurred.';

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
