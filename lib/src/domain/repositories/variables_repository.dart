import 'package:figmage/src/domain/models/models.dart';

abstract interface class VariablesRepository {
  /// Fetches variable values for a Figma file specified by [fileId].
  ///
  /// Parameters:
  /// - [fileId]: The unique identifier of the Figma file to fetch variable data from.
  /// - [token]: The access token for authentication and authorization.
  ///
  /// Returns a list of [Variable] instances representing the variable values in the Figma file.
  Future<List<Variable>> getVariables({
    required String fileId,
    required String token,
  });
}
