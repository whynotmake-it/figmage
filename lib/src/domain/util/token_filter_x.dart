import 'package:collection/collection.dart';
import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/design_token.dart';

/// An extension fo filter variables
extension TokenFilterX<X> on Iterable<DesignToken<X>> {
  /// Filters the variables by the `settings.from` list
  Iterable<DesignToken<X>> filterByFrom(GenerationSettings settings) => where(
        (variable) =>
            settings.from.isEmpty ||
            settings.from.any(variable.fullName.startsWith),
      );

  /// Sorts tokens by their name property.
  List<DesignToken<X>> sortTokensByName() {
    return sortedBy((token) => token.name);
  }

  /// Extracts all unique mode names from tokens and sorts them.
  Set<String> getAllUniqueSortedModes() {
    return expand((token) => token.valuesByModeName.keys)
        .sortedBy((mode) => mode)
        .toSet();
  }

  /// Extracts all tokens that have at least 1 mode that can't be resolved.
  Iterable<DesignToken<X>> getUnresolvedTokens() {
    return [
      ...where(
        (token) => token.valuesByModeName.values
            .any((alias) => alias.resolveValue == null),
      ),
    ];
  }

  /// Extracts all tokens that are fully resolvable.
  Iterable<DesignToken<X>> getResolvableTokens() {
    return [
      ...where(
        (token) => token.valuesByModeName.values
            .every((alias) => alias.resolveValue != null),
      ),
    ];
  }

  /// Turns the variables into a map of values by name by mode, with
  /// unresolvable values being null.
  ///
  /// All inner maps will have the same keys.
  Map<String, Map<String, X?>> get valuesByNameByMode {
    final sorted = sortTokensByName();
    final allModes = getAllUniqueSortedModes();
    return {
      for (final mode in allModes)
        mode: {
          for (final token in sorted)
            if (token.valuesByModeName[mode] case final alias?)
              token.name: alias.resolveValue,
        },
    };
  }
}
