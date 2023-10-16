import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';

/// Returns [AliasOrData] for the given [aliasOrAlias] recursively.
///
/// The [aliasOrAlias] parameter represents the variable alias to resolve recursively.
/// The [variables] parameter is a [Map<String, Variable>]
/// object containing the variables to search in.
///
/// Throws [ArgumentError] if an alias points to a variable that cannot be found
/// in the [variables] map.
///
/// Throws [TypeError] if an alias points to a variable containing
/// a different [VariableValue] than [T].
///
/// If an alias points to a variable which has multiple modes,
/// the value of the first mode is used, in accordance with Figma's behavior.
AliasOr<T> getAliasTreeRecursive<T>({
  required AliasOr<T> aliasOr,
  required Map<String, Variable> variables,
}) {
  if (aliasOr is AliasData) {
    return aliasOr;
  } else if (aliasOr is Alias<T>) {
    final current = variables[aliasOr.id];
    if (current == null) {
      throw ArgumentError(
        'Could not find variable with the id: ${aliasOr.id} in variables',
      );
    }
    final firstModeValue = current.valuesByMode.entries.first.value;

    if (firstModeValue is AliasData<T>) {
      return aliasOr.copyWith(aliasOrValue: firstModeValue);
    }
    if (firstModeValue is Alias<T>) {
      return getAliasTreeRecursive(
        aliasOr: firstModeValue,
        variables: variables,
      );
    }
  }
  throw TypeError();
}
