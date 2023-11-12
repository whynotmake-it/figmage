import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variable_mode_value_dto.g.dart';

sealed class VariableModeValueDto {
  VariableModeValueDto();

  factory VariableModeValueDto.fromJson(dynamic json) {
    if (json is bool) {
      return VariableModeBooleanDto(value: json);
    } else if (json is num) {
      return VariableModeNumberDto(value: json.toDouble());
    } else if (json is String) {
      return VariableModeStringDto(value: json);
    } else if (json is Map<String, dynamic>) {
      if (json.containsKey('r') &&
          json.containsKey('g') &&
          json.containsKey('b') &&
          json.containsKey('a')) {
        return VariableModeColorDto.fromJson(json);
      } else if (json.containsKey('type') && json['type'] == 'VARIABLE_ALIAS') {
        return VariableModeAliasDto.fromJson(json);
      }
    }
    throw Exception('Unsupported value type');
  }

  dynamic toJson();
}

@JsonSerializable()
class VariableModeBooleanDto extends VariableModeValueDto with EquatableMixin {
  VariableModeBooleanDto({required this.value});

  final bool value;

  @override
  bool toJson() => value;

  @override
  List<Object?> get props => [value];
}

@JsonSerializable()
class VariableModeNumberDto extends VariableModeValueDto with EquatableMixin {
  VariableModeNumberDto({required this.value});

  final double value;

  @override
  double toJson() => value;

  @override
  List<Object?> get props => [value];
}

@JsonSerializable()
class VariableModeStringDto extends VariableModeValueDto with EquatableMixin {
  VariableModeStringDto({required this.value});

  final String value;

  @override
  String toJson() => value;

  @override
  List<Object?> get props => [value];
}

@JsonSerializable(explicitToJson: true)
class VariableModeColorDto extends VariableModeValueDto with EquatableMixin {
  VariableModeColorDto({
    required this.r,
    required this.g,
    required this.b,
    required this.a,
  });

  factory VariableModeColorDto.fromJson(Map<String, dynamic> json) =>
      _$VariableModeColorDtoFromJson(json);

  final double r;

  final double g;

  final double b;

  final double a;

  int get value {
    final int red = (r * 255).round();
    final int green = (g * 255).round();
    final int blue = (b * 255).round();
    final int alpha = (a * 255).round();
    return (alpha << 24) | (red << 16) | (green << 8) | blue;
  }

  @override
  Map<String, dynamic> toJson() => _$VariableModeColorDtoToJson(this);

  @override
  List<Object?> get props => [value];
}

@JsonSerializable(explicitToJson: true)
class VariableModeAliasDto extends VariableModeValueDto with EquatableMixin {
  VariableModeAliasDto({required this.type, required this.id});

  factory VariableModeAliasDto.fromJson(Map<String, dynamic> json) =>
      _$VariableModeAliasDtoFromJson(json);

  final String type;

  final String id;

  @override
  Map<String, dynamic> toJson() => _$VariableModeAliasDtoToJson(this);

  @override
  List<Object?> get props => [type, id];
}
