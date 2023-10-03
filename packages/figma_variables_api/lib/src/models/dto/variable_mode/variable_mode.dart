import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variable_mode.g.dart';

@JsonSerializable()
@CopyWith()
class VariableMode {
  VariableMode({
    required this.modeId,
    required this.name,
  });

  factory VariableMode.fromJson(Map<String, dynamic> json) =>
      _$VariableModeFromJson(json);
  @JsonKey(name: 'modeId')
  final String modeId;
  final String name;

  Map<String, dynamic> toJson() => _$VariableModeToJson(this);
}
