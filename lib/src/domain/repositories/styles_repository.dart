import 'package:figmage/src/data/repositories/figma_styles_repository.dart';
import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:riverpod/riverpod.dart';

/// A provider for a [StylesRepository] that fetches styles from Figma.
final stylesRepositoryProvider =
    Provider<StylesRepository>((ref) => FigmaStylesRepository());

/// {@template styles_repository}
/// This repository is responsible for fetching styles.
/// {@endtemplate}
abstract interface class StylesRepository {
  /// Get all styles from the figma file with [fileId] using the personal
  /// access [token].
  Future<List<DesignStyle<dynamic>>> getStyles({
    required String fileId,
    required String token,
  });
}

/// {@template styles_exception}
/// Superclass for all styles repository exceptions.
/// {@endtemplate}
sealed class StylesException implements Exception {
  /// {@macro styles_exception}
  const StylesException();

  /// The message of the exception.
  String get message;
}

/// {@template unauthorized_styles_exception}
/// Exception thrown when the user is not authorized to access the styles.
/// {@endtemplate}
class UnauthorizedStylesException extends StylesException {
  /// {@macro unauthorized_styles_exception}
  const UnauthorizedStylesException();

  @override
  String get message => 'Unauthorized. Make sure you have a valid access token '
      'that can access the file.';
}

/// {@template unknown_styles_exception}
/// An exception that is thrown during variables fetching, that can't be
/// classified as any other exception.
/// {@endtemplate}
class UnknownStylesException extends StylesException {
  /// {@macro unknown_styles_exception}
  const UnknownStylesException(String? message)
      : message = message ?? 'Unknown error happened during styles fetching.';

  @override
  final String message;
}
