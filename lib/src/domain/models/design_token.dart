import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';

/// A superclass for all design tokens (styles and variables).
abstract interface class DesignToken<T> {
  /// The name of this token, usually the last segment in the full name.
  String get name;

  /// The full name of the token, including all collections.
  String get fullName;

  /// If the token originated from a Variable the collection of that Variable,
  /// if the token is based upon a Style the top level group name of that style.
  String get collectionName;

  /// If the token originated from a Variable the collectionId of that Variable,
  /// if the token is based upon a Style the top level groupId of that style.
  String get collectionId;

  /// The values of the token by mode id.
  Map<String, AliasOr<T>> get valuesByModeId;

  /// The values of the token by mode name.
  Map<String, AliasOr<T>> get valuesByModeName;
}
