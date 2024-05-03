import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:figma_variables_api/src/dto/variable/variable_dto.dart';
import 'package:figma_variables_api/src/dto/variable_collection/variable_collection_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variables_meta_dto.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith()
class VariablesMetaDto extends Equatable {
  VariablesMetaDto({
    required this.variables,
    required this.variableCollections,
  });

  factory VariablesMetaDto.fromJson(Map<String, dynamic> json) =>
      _$VariablesMetaDtoFromJson(json);
  final Map<String, VariableDto> variables;
  final Map<String, VariableCollectionDto> variableCollections;

  @override
  List<Object?> get props => [variables, variableCollections];

  Map<String, dynamic> toJson() => _$VariablesMetaDtoToJson(this);
}
