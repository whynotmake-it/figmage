import 'package:freezed_annotation/freezed_annotation.dart';

part 'alias_or.freezed.dart';

@Freezed()
abstract class AliasOr<T> with _$AliasOr<T> {
  const AliasOr._();

  const factory AliasOr.data({
    required T data,
  }) = AliasData;

  const factory AliasOr.alias({
    required String type,
    required String id,
    required AliasOr<T> aliasOrValue,
  }) = Alias;

  T get resolveValue => map(
        alias: (value) => value.resolveValue,
        data: (value) => value.data,
      );
}
