import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/text_style/text_style.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tokens_by_type.freezed.dart';

/// {@template tokens_by_type}
/// A collection of tokens sorted by their respective types.
///
/// Used to allow for typesafe access of tokens when generating.
/// {@endtemplate}
@freezed
sealed class TokensByType with _$TokensByType {
  /// {@macro tokens_by_type}
  const factory TokensByType({
    @Default([]) Iterable<DesignToken<int>> colorTokens,
    @Default([]) Iterable<DesignToken<TextStyle>> typographyTokens,
    @Default([]) Iterable<DesignToken<double>> numberTokens,
    @Default([]) Iterable<DesignToken<String>> stringTokens,
    @Default([]) Iterable<DesignToken<bool>> boolTokens,
  }) = _TokensByType;

  const TokensByType._();
}
