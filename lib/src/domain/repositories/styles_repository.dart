import 'package:figmage/src/domain/models/models.dart';

abstract interface class StylesRepository {
  /// Get all styles from the figma file with [fileId] using the personal
  /// access [token].
  Future<List<Style>> getStyles({
    required String fileId,
    required String token,
  });
}
