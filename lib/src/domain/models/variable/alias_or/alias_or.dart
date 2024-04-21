import 'package:freezed_annotation/freezed_annotation.dart';

part 'alias_or.freezed.dart';

/// A class used for parsing the value of a Figma variable.
///
/// The [AliasOr] class represents a union type with two possible constructors
///
/// Usage:
/// ```dart
/// final aliasOr = AliasOr.data(data: 42); // Create an AliasOr with data.
/// final alias = AliasOr.alias(id: 'someId', aliasOrValue: aliasOr); // Create an AliasOr with an alias reference.
///
/// final resolvedValue = aliasOr.resolveValue; // Resolve the value.
/// ```
///
/// [AliasOr] is part of a sealed union type, which means it can have only the
/// specified constructors.
@Freezed()
sealed class AliasOr<T> with _$AliasOr<T> {
  const AliasOr._();

  ///[AliasData]: Contains a data value of type [T].
  const factory AliasOr.data({
    required T data,
  }) = AliasData;

  ///[Alias]: Contains an alias reference to another [AliasOr<T>] value.
  const factory AliasOr.alias({
    required String id,
    required AliasOr<T> aliasOrValue,
  }) = Alias;

  ///[Alias]: Contains an alias that is not part of the response.
  const factory AliasOr.unresolved({
    required String id,
  }) = AliasUnresolved;

  /// Returns the resolved value of the [AliasOr] instance.
  T? get resolveValue => map(
        alias: (alias) => alias.aliasOrValue.resolveValue,
        data: (aliasData) => aliasData.data,
        unresolved: (aliasUnresolved) => null,
      );
}
