import 'package:equatable/equatable.dart';
import 'package:figma/figma.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:meta/meta.dart';

/// {@template design_style}
/// A superlass for all design styles
/// {@endtemplate}
@immutable
sealed class DesignStyle<T> with EquatableMixin implements DesignToken<T> {
  /// {@macro design_style}
  const DesignStyle({
    required this.id,
    required this.name,
    required this.value,
  });

  /// The id of this DesignStyle.
  final String id;

  @override
  final String name;

  @override
  String get fullName => name;

  /// The value of this DesignStyle.
  final T value;

  @override
  Map<String, AliasOr<T>> get valuesByMode => {
        "": AliasOr<T>.data(data: value),
      };

  @override
  List<Object?> get props => [id, name, value];

  @override
  bool? get stringify => true;
}

/// {@template color_style}
/// A style for colors.
/// {@endtemplate}
class ColorStyle extends DesignStyle<int> {
  /// {@macro color_style}
  const ColorStyle({
    required super.id,
    required super.name,
    required super.value,
  });
}

/// {@template text_style}
/// A style for typography.
/// {@endtemplate}
class TextStyle extends DesignStyle<TypeStyle> {
  /// {@macro text_style}
  const TextStyle({
    required super.id,
    required super.name,
    required super.value,
  });

  /// Returns the line height the way Flutter expects it.
  double? get flutterLineHeight {
    if (value.lineHeightPx == null || value.fontSize == null) {
      return null;
    }
    final lh = value.lineHeightPx! / value.fontSize!;
    return lh;
  }

  /// Makes sure the font weight is a valid Flutter font weight.
  int? get flutterFontWeight {
    if (value.fontWeight case final weight?) {
      final corrected = (weight ~/ 100) * 100;
      return corrected.clamp(100, 900);
    }
    return null;
  }
}
