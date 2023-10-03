import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'variable_mode.g.dart';

@JsonSerializable()
@CopyWith()
class VariableMode extends Equatable {
  VariableMode({
    required this.modeId,
    required this.name,
  });

  factory VariableMode.fromJson(Map<String, dynamic> json) =>
      _$VariableModeFromJson(json);

  final String modeId;
  final String name;

  @override
  List<Object?> get props => [modeId, name];

  Map<String, dynamic> toJson() => _$VariableModeToJson(this);
}
