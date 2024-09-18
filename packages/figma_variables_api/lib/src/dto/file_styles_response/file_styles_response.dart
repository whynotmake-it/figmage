import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:figma_variables_api/figma_variables_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file_styles_response.g.dart';

/// A reduced version of the file endpoint response, that only contains styles
/// and metadata and leaves out the document.
@JsonSerializable()
@CopyWith()
class FileStylesResponse extends Equatable {
  FileStylesResponse({
    this.name,
    this.role,
    this.lastModified,
    this.thumbnailUrl,
    this.version,
    this.schemaVersion,
    this.styles,
  });

  factory FileStylesResponse.fromJson(Map<String, dynamic> json) =>
      _$FileStylesResponseFromJson(json);

  /// Name of the file.
  final String? name;

  /// Role.
  final String? role;

  /// Last time file was modified.
  final DateTime? lastModified;

  /// URL to file thumbnail.
  final String? thumbnailUrl;

  /// File version.
  final String? version;

  /// The schema version of the file.
  final int? schemaVersion;

  /// Map of styles within the file, if any.
  final Map<String, Style>? styles;

  Map<String, dynamic> toJson() => _$FileStylesResponseToJson(this);

  @override
  List<Object?> get props => [
        name,
        role,
        lastModified,
        thumbnailUrl,
        version,
        schemaVersion,
        styles,
      ];
}
