import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';

/// A superclass for all design tokens (styles and variables).
abstract interface class DesignToken<T> {
  /// The name of this token, usually the last segment in the full name.
  String get name;

  /// The full name of the token, including all collections.
  String get fullName;

  /// The values of the token by mode.
  Map<String, AliasOr<T>> get valuesByMode;
}
