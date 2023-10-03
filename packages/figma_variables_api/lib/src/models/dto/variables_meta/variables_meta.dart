import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:figma_variables_api/src/models/dto/variable/variable.dart';
import 'package:figma_variables_api/src/models/dto/variable_collection/variable_collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variables_meta.g.dart';

@JsonSerializable()
@CopyWith()
class VariablesMeta extends Equatable {
  VariablesMeta({
    required this.variables,
    required this.variableCollections,
  });

  factory VariablesMeta.fromJson(Map<String, dynamic> json) =>
      _$VariablesMetaFromJson(json);
  final Map<String, Variable> variables;
  final Map<String, VariableCollection> variableCollections;

  @override
  List<Object?> get props => [variables, variableCollections];

  Map<String, dynamic> toJson() => _$VariablesMetaToJson(this);
}
