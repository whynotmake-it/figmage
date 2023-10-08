import 'package:freezed_annotation/freezed_annotation.dart';

part 'variable_alias.freezed.dart';

part 'variable_alias.g.dart';

@freezed
class VariableAlias with _$VariableAlias {
  const factory VariableAlias({
    required String type,
    required String id,
  }) = _VariableAlias;

  factory VariableAlias.fromJson(Map<String, dynamic> json) =>
      _$VariableAliasFromJson(json);
}
