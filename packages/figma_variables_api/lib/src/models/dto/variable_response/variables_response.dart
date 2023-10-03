import 'package:equatable/equatable.dart';
import 'package:figma_variables_api/src/models/dto/variables_meta/variables_meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'variables_response.g.dart';

/// A response object containing [VariablesMeta] along with metadata.
@JsonSerializable(explicitToJson: true)
@CopyWith()
class VariablesResponse extends Equatable {
  VariablesResponse({
    required this.status,
    required this.error,
    required this.meta,
  });

  factory VariablesResponse.fromJson(Map<String, dynamic> json) =>
      _$VariablesResponseFromJson(json);

  /// Status code.
  final int status;

  /// Indicates if there was an error.
  final bool error;

  /// Metadata about variables.
  final VariablesMeta meta;

  @override
  List<Object?> get props => [status, error, meta];

  Map<String, dynamic> toJson() => _$VariablesResponseToJson(this);
}
