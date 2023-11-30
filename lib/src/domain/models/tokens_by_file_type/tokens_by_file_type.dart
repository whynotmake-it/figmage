import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/text_style/text_style.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tokens_by_file_type.freezed.dart';

/// {@template tokens_by_file_type}
/// A collection of tokens by file type.
/// {@endtemplate}
@freezed
sealed class TokensByFileType with _$TokensByFileType {
  /// {@macro tokens_by_file_type}
  const factory TokensByFileType({
    @Default([]) Iterable<DesignToken<int>> colorTokens,
    @Default([]) Iterable<DesignToken<TextStyle>> typographyTokens,
    @Default([]) Iterable<DesignToken<double>> numberTokens,
    @Default([]) Iterable<DesignToken<String>> stringTokens,
    @Default([]) Iterable<DesignToken<bool>> boolTokens,
  }) = _TokensByFileType;

  const TokensByFileType._();
}
