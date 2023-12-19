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

  /// Turns the variables into a map of values by name by mode
  ///
  // TODO(tim): this is in the repo I know but I didn't get how it works
  Map<String, Map<String, X>> get valuesByNameByMode {
    final sorted = sortedBy((element) => element.name);
    final allModes = expand((variable) => variable.valuesByMode.keys)
        .toSet()
        .sortedBy((mode) => mode);
    return {
      for (final mode in allModes)
        mode: {
          for (final variable in sorted)
            if (variable.valuesByMode[mode] case final alias?)
              variable.name: alias.resolveValue,
        },
    };
  }
}
