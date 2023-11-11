import 'package:figmage/src/domain/models/style.dart';

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
