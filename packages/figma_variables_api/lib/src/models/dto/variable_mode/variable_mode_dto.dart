import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'variable_mode_dto.g.dart';

@JsonSerializable()
@CopyWith()
class VariableModeDto extends Equatable {
  VariableModeDto({
    required this.modeId,
    required this.name,
  });

  factory VariableModeDto.fromJson(Map<String, dynamic> json) =>
      _$VariableModeDtoFromJson(json);

  final String modeId;
  final String name;

  @override
  List<Object?> get props => [modeId, name];

  Map<String, dynamic> toJson() => _$VariableModeDtoToJson(this);
}
