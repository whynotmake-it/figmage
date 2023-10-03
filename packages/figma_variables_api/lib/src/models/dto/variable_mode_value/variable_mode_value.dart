import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'variable_mode_value.g.dart';

@JsonSerializable()
@CopyWith()
class VariableModeValue extends Equatable {
  VariableModeValue({
    required this.type,
    required this.id,
  });

  factory VariableModeValue.fromJson(Map<String, dynamic> json) =>
      _$VariableModeValueFromJson(json);

  final String type;
  final String id;

  @override
  List<Object?> get props => [type, id];

  Map<String, dynamic> toJson() => _$VariableModeValueToJson(this);
}
