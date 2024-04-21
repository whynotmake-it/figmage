import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
import 'package:figmage/src/domain/util/token_filter_x.dart';

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
    @Default([]) Iterable<DesignToken<Typography>> typographyTokens,
    @Default([]) Iterable<DesignToken<double>> numberTokens,
    @Default([]) Iterable<DesignToken<String>> stringTokens,
    @Default([]) Iterable<DesignToken<bool>> boolTokens,
  }) = _TokensByType;

  const TokensByType._();

  /// A map of name and [DesignToken] iterable containing all tokens.
  Map<String, Iterable<DesignToken>> asMap() => {
        'colorTokens': colorTokens,
        'typographyTokens': typographyTokens,
        'numberTokens': numberTokens,
        'stringTokens': stringTokens,
        'boolTokens': boolTokens,
      };

  /// Returns all token that are resolvable for all modes.
  TokensByType get resolvable => copyWith(
        colorTokens: colorTokens.getResolvableTokens(),
        typographyTokens: typographyTokens.getResolvableTokens(),
        numberTokens: numberTokens.getResolvableTokens(),
        stringTokens: stringTokens.getResolvableTokens(),
        boolTokens: boolTokens.getResolvableTokens(),
      );

  /// Returns all token that are unresolvable for at least 1 mode.
  TokensByType get unresolvable => copyWith(
        colorTokens: colorTokens.getUnresolvedTokens(),
        typographyTokens: typographyTokens.getUnresolvedTokens(),
        numberTokens: numberTokens.getUnresolvedTokens(),
        stringTokens: stringTokens.getUnresolvedTokens(),
        boolTokens: boolTokens.getUnresolvedTokens(),
      );
}
