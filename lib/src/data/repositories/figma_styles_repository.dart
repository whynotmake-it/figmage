import 'package:figmage/src/domain/models/style.dart';
import 'package:figmage/src/domain/repositories/styles_repository.dart';

/// {@template figma_styles_repository}
/// This repository fetches styles from the Figma API.
/// {@endtemplate}
class FigmaStylesRepository implements StylesRepository {
  @override
  // TODO(timcreatedit): implement getStyles
  Future<List<Style>> getStyles({
    required String fileId,
    required String token,
  }) async =>
      [];
}
