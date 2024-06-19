import 'package:equatable/equatable.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
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
    required this.fullName,
    required this.value,
  });

  /// The id of this DesignStyle.
  final String id;

  @override
  String get name => fullName.startsWith('$collectionName/')
      ? fullName.substring(collectionName.length + 1)
      : fullName;

  @override
  final String fullName;

  @override
  String get collectionName =>
      fullName.contains('/') ? fullName.split('/').first : '';

  /// For styles (unlike Variables) [collectionName] and [collectionId] are the
  /// same.
  @override
  String get collectionId => collectionName;

  /// The value of this DesignStyle.
  final T value;

  @override
  Map<String, AliasOr<T>> get valuesByModeId => {
        "": AliasOr<T>.data(data: value),
      };

  @override
  Map<String, AliasOr<T>> get valuesByModeName => {
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
class ColorDesignStyle extends DesignStyle<int> {
  /// {@macro color_style}
  const ColorDesignStyle({
    required super.id,
    required super.fullName,
    required super.value,
  });
}

/// {@template text_style}
/// A style for typography.
/// {@endtemplate}
class TextDesignStyle extends DesignStyle<Typography> {
  /// {@macro text_style}
  const TextDesignStyle({
    required super.id,
    required super.fullName,
    required super.value,
  });
}
