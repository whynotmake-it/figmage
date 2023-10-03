import 'package:figmage/src/domain/models/style.dart';
import 'package:figmage/src/domain/repositories/styles_repository.dart';

class FigmaStylesRepository implements StylesRepository {
  @override
  //TODO implement getStyles
  Future<List<Style>> getStyles({
    required String fileId,
    required String token,
  }) async =>
      [];
}
