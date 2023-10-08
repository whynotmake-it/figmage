import 'package:figmage/src/domain/models/models.dart';

abstract interface class VariablesRepository {
  /// Fetches variable values for a Figma file specified by [fileId]
  /// using the provided [token]. It filters the variables based on the [collectionsFilter],
  /// which is a list of collection names to include. If [collectionsFilter] is null,
  /// all collections are included.
  Future<Map<String, Map<String, T>>>
      getVariableValues<T extends VariableValue>({
    required String fileId,
    required String token,
    List<String>? collectionsFilter,
  });
}
