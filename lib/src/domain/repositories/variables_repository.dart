import 'package:figmage/src/data/repositories/figma_variables_repository.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:riverpod/riverpod.dart';

/// A map of variable values organized by collection, mode, and variable name.
typedef VariableValuesByIdByModeByCollection<T>
    = Map<String, Map<String, Map<String, T>>>;

/// A provider for a [VariablesRepository] that fetches variables from Figma.
final variablesRepositoryProvider =
    Provider<VariablesRepository>((ref) => FigmaVariablesRepository());

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
  Future<List<Variable<dynamic>>> getVariables({
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
      createValueModeMap<T, V extends Variable<dynamic>>({
    required List<Variable<dynamic>> variables,
    bool useNames = true,
  });
}

/// {@template variables_exception}
/// Superclass for all styles repository exceptions.
/// {@endtemplate}
sealed class VariablesException implements Exception {
  /// {@macro variables_exception}
  const VariablesException();

  /// The message of the exception.
  String get message;
}

/// {@template unauthorized_variables_exception}
/// Exception thrown when the user is not authorized to access the styles.
/// {@endtemplate}
class UnauthorizedVariablesException extends VariablesException {
  /// {@macro unauthorized_variables_exception}
  const UnauthorizedVariablesException(String? message)
      : message = message ??
            'Unauthorized. Make sure you have a valid access token '
                'that can access the file and that you are a Figma Enterprise. '
                'team member';

  @override
  final String message;
}

/// {@template unknown_variables_exception}
/// An exception that is thrown during variables fetching, that can't be
/// classified as any other exception.
/// {@endtemplate}
class UnknownVariablesException extends VariablesException {
  /// {@macro unknown_variables_exception}
  const UnknownVariablesException(String? message)
      : message =
            message ?? 'Unknown error happened during variables fetching.';

  @override
  final String message;
}
