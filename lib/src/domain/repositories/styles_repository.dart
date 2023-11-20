import 'package:figmage/src/data/repositories/figma_styles_repository.dart';
import 'package:figmage/src/domain/models/style.dart';
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
  Future<List<Style>> getStyles({
    required String fileId,
    required String token,
  });
}
