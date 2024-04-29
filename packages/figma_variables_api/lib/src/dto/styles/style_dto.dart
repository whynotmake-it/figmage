import 'package:equatable/equatable.dart';
import 'package:figma_variables_api/src/dto/styles/style_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'style_dto.g.dart';

/// {@template style_dto}
/// A set of properties that can be applied to nodes and published.
/// Styles for a property can be created in the corresponding property's panel
/// while editing a file.
/// {@endtemplate}
@JsonSerializable()
@CopyWith()
class StyleDto extends Equatable {
  /// {@macro style_dto}
  const StyleDto({
    this.nodeId,
    this.key,
    this.name,
    this.description,
    this.type,
  });

  factory StyleDto.fromJson(Map<String, dynamic> json) =>
      _$StyleDtoFromJson(json);

  /// The node id of this style.
  @JsonKey(name: 'node_id')
  final String? nodeId;

  /// The key of the style.
  final String? key;

  /// The name of the style.
  final String? name;

  /// The description of the style.
  final String? description;

  /// The type of style as string enum.
  @JsonKey(name: 'style_type')
  final StyleType? type;

  @override
  List<Object?> get props => [
        nodeId,
        key,
        name,
        description,
        type,
      ];

  Map<String, dynamic> toJson() => _$StyleDtoToJson(this);
}
