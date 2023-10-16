import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'color_value.g.dart';

@JsonSerializable()
@CopyWith()
class ColorValue extends Equatable {
  ColorValue({
    required this.r,
    required this.g,
    required this.b,
    required this.a,
  });

  factory ColorValue.fromJson(Map<String, dynamic> json) =>
      _$ColorValueFromJson(json);

  final double r;
  final double g;
  final double b;
  final double a;

  @override
  List<Object?> get props => [r, g, b, a];

  int get value {
    final int red = (r * 255).round();
    final int green = (g * 255).round();
    final int blue = (b * 255).round();
    final int alpha = (a * 255).round();
    return (alpha << 24) | (red << 16) | (green << 8) | blue;
  }
}
