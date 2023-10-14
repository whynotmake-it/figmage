import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'variable_mode_value_dto.g.dart';

@JsonSerializable()
@CopyWith()
class VariableModeValueDto extends Equatable {
  VariableModeValueDto({
    required this.type,
    required this.id,
  });

  factory VariableModeValueDto.fromJson(Map<String, dynamic> json) =>
      _$VariableModeValueDtoFromJson(json);

  final String type;
  final String id;

  @override
  List<Object?> get props => [type, id];

  Map<String, dynamic> toJson() => _$VariableModeValueDtoToJson(this);
}
