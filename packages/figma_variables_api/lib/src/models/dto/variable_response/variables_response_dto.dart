import 'package:equatable/equatable.dart';
import 'package:figma_variables_api/src/models/dto/variables_meta/variables_meta_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'variables_response_dto.g.dart';

/// A response object containing [VariablesMetaDto] along with metadata.
@JsonSerializable(explicitToJson: true)
@CopyWith()
class VariablesResponseDto extends Equatable {
  VariablesResponseDto({
    required this.status,
    required this.error,
    required this.meta,
  });

  factory VariablesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VariablesResponseDtoFromJson(json);

  /// Status code.
  final int status;

  /// Indicates if there was an error.
  final bool error;

  /// Metadata about variables.
  final VariablesMetaDto meta;

  @override
  List<Object?> get props => [status, error, meta];

  Map<String, dynamic> toJson() => _$VariablesResponseDtoToJson(this);
}
