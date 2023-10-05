import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variable.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith()
class Variable extends Equatable {
  Variable({
    required this.id,
    required this.name,
    required this.remote,
    required this.key,
    required this.variableCollectionId,
    required this.resolvedType,
    required this.description,
    required this.hiddenFromPublishing,
    required this.valuesByMode,
    required this.scopes,
    required this.codeSyntax,
  });

  factory Variable.fromJson(Map<String, dynamic> json) =>
      _$VariableFromJson(json);
  final String id;
  final String name;
  final bool remote;
  final String key;
  final String variableCollectionId;
  final String resolvedType;
  final String description;
  final bool hiddenFromPublishing;
  final Map<String, dynamic> valuesByMode;
  final List<String> scopes;
  final Map<String, String> codeSyntax;

  @override
  List<Object?> get props => [
        id,
        name,
        remote,
        key,
        variableCollectionId,
        resolvedType,
        description,
        hiddenFromPublishing,
        valuesByMode,
        scopes,
        codeSyntax,
      ];

  Map<String, dynamic> toJson() => _$VariableToJson(this);
}
