import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:figma/figma.dart';
import 'package:json_annotation/json_annotation.dart';

part 'styles_response.g.dart';

/// A response object containing a list of styles.
@JsonSerializable()
@CopyWith()
class StylesResponse extends Equatable {
  StylesResponse({this.status, this.error, this.meta});

  factory StylesResponse.fromJson(Map<String, dynamic> json) =>
      _$StylesResponseFromJson(json);

  /// Status code.
  final int? status;

  /// If the operation ended in error.
  final bool? error;

  /// [Style] list + metadata.
  final StylesResponseMeta? meta;

  @override
  List<Object?> get props => [status, error, meta];

  Map<String, dynamic> toJson() => _$StylesResponseToJson(this);
}

@JsonSerializable()
@CopyWith()
class StylesResponseMeta extends Equatable {
  const StylesResponseMeta({required this.styles});

  factory StylesResponseMeta.fromJson(Map<String, dynamic> json) =>
      _$StylesResponseMetaFromJson(json);

  final List<Style> styles;

  @override
  List<Object?> get props => [styles];

  Map<String, dynamic> toJson() => _$StylesResponseMetaToJson(this);
}
