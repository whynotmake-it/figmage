import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:figma_variables_api/src/models/dto/variable_mode/variable_mode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variable_collection.g.dart';

@JsonSerializable()
@CopyWith()
class VariableCollection extends Equatable {
  VariableCollection({
    required this.defaultModeId,
    required this.id,
    required this.name,
    required this.remote,
    required this.modes,
    required this.key,
    required this.hiddenFromPublishing,
    required this.variableIds,
  });

  factory VariableCollection.fromJson(Map<String, dynamic> json) =>
      _$VariableCollectionFromJson(json);
  final String defaultModeId;
  final String id;
  final String name;
  final bool remote;
  final List<VariableMode> modes;
  final String key;
  final bool hiddenFromPublishing;
  final List<String> variableIds;

  @override
  List<Object?> get props => [
        defaultModeId,
        id,
        name,
        remote,
        modes,
        key,
        hiddenFromPublishing,
        variableIds,
      ];

  Map<String, dynamic> toJson() => _$VariableCollectionToJson(this);
}
