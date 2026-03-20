import 'package:equatable/equatable.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';

/// {@template json_token}
/// A design token parsed from JSON input.
/// {@endtemplate}
class JsonToken<T> with EquatableMixin implements DesignToken<T> {
  /// {@macro json_token}
  const JsonToken({
    required this.name,
    required this.fullName,
    required this.collectionName,
    required this.collectionId,
    required this.valuesByModeName,
  });

  @override
  final String name;

  @override
  final String fullName;

  @override
  final String collectionName;

  @override
  final String collectionId;

  @override
  final Map<String, AliasOr<T>> valuesByModeName;

  @override
  Map<String, AliasOr<T>> get valuesByModeId => valuesByModeName;

  @override
  List<Object?> get props => [
        name,
        fullName,
        collectionName,
        collectionId,
        valuesByModeName,
      ];
}
