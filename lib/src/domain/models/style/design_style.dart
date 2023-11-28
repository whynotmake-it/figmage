import 'package:equatable/equatable.dart';
import 'package:figma/figma.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:meta/meta.dart';

part 'text_style.dart';
part 'color_style.dart';

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
}
