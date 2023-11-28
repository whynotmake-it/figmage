import 'package:figmage/src/domain/models/config/config.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';

/// An extension fo filter variables
extension VariableFilterX<T extends DesignToken<X>, X> on Iterable<T> {
  /// Filters the variables by the `settings.from` list
  Iterable<T> filterByFrom(GenerationSettings settings) => where(
        (variable) =>
            settings.from.isEmpty ||
            settings.from.any(variable.fullName.startsWith),
      );

  /// Turns the variables into a map of values by name by mode
  ///
  // TODO(tim): this is in the repo I know but I didn't get how it works
  Map<String, Map<String, dynamic>> get valuesByNameByMode {
    final allModes = expand((variable) => variable.valuesByMode.keys).toSet();
    return {
      for (final mode in allModes)
        mode: {
          for (final variable in this)
            if (variable.valuesByMode.containsKey(mode))
              variable.name: switch (variable.valuesByMode[mode]) {
                final AliasOr<dynamic> alias => alias.resolveValue,
                _ => throw TypeError(),
              },
        },
    };
  }
}
