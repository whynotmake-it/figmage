import 'package:freezed_annotation/freezed_annotation.dart';

part 'alias_or.freezed.dart';

/// A class used for parsing the value of a Figma variable.
///
/// The [AliasOr] class represents a union type with two possible constructors:
/// 1. [AliasData]: Contains a data value of type [T].
/// 2. [Alias]: Contains an alias reference to another [AliasOr<T>] value.
///
/// Usage:
/// ```dart
/// final aliasOr = AliasOr.data(data: 42); // Create an AliasOr with data.
/// final alias = AliasOr.alias(id: 'someId', aliasOrValue: aliasOr); // Create an AliasOr with an alias reference.
///
/// final resolvedValue = aliasOr.resolveValue; // Resolve the value.
/// ```
///
/// [AliasOr] is part of a sealed union type, which means it can have only the specified constructors.
@Freezed()
sealed class AliasOr<T> with _$AliasOr<T> {
  const AliasOr._();

  const factory AliasOr.data({
    required T data,
  }) = AliasData;

  const factory AliasOr.alias({
    required String id,
    required AliasOr<T> aliasOrValue,
  }) = Alias;

  T get resolveValue => map(
        alias: (alias) => alias.aliasOrValue.resolveValue,
        data: (aliasData) => aliasData.data,
      );
}
