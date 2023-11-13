import 'package:figmage/src/domain/models/variable/variable.dart';

/// A map of variable values organized by collection, mode, and variable name.
typedef VariableValuesByIdByModeByCollection<T>
    = Map<String, Map<String, Map<String, T>>>;

/// {@template variables_repository}
/// A repository for fetching variable values from a Figma file.
/// {@endtemplate}
abstract interface class VariablesRepository {
  /// Fetches variable values for a Figma file specified by [fileId].
  ///
  /// Parameters:
  /// - [fileId]: The unique identifier of the Figma file to fetch variable data
  ///  from.
  /// - [token]: The access token for authentication and authorization.
  ///
  /// Returns a list of [Variable] instances representing the variable values in
  /// the Figma file.
  Future<List<Variable>> getVariables({
    required String fileId,
    required String token,
  });

  /// Creates a map of Figma variable values organized by collection, mode, and
  /// variable name.
  ///
  /// This function takes a list of [Variable] instances and arranges their
  /// values in a hierarchical map structure. The resulting map is organized by
  /// collection, mode, and variable name. The type of value is specified by the
  /// generic type parameter [T],
  /// and it is constrained to the subtype of [Variable] represented by [V].
  ///
  /// Parameters:
  /// - [variables]: A list of [Variable] instances to extract values from.
  /// - [useNames]: A boolean flag indicating whether to use variable names
  /// (true) or variable IDs (false) for map keys. Default is true.
  ///
  /// Generic Type Parameters:
  /// - [T]: The data type of the variable values to be included in the map.
  /// - [V]: A subtype of [Variable] representing the specific variable type for
  /// value extraction.
  ///
  /// Example:
  /// ```dart
  /// final variables = variables; // List of Variable instances;
  ///
  /// final valueMap = createValueModeMap<double, FloatVariable>(
  ///   variables: variables,
  ///   useNames: true,
  /// );
  /// ```
  VariableValuesByIdByModeByCollection<T>
      createValueModeMap<T, V extends Variable>({
    required List<Variable> variables,
    bool useNames = true,
  });
}
