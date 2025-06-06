// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tokens_by_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokensByType {
  Iterable<DesignToken<int>> get colorTokens;
  Iterable<DesignToken<Typography>> get typographyTokens;
  Iterable<DesignToken<double>> get numberTokens;
  Iterable<DesignToken<String>> get stringTokens;
  Iterable<DesignToken<bool>> get boolTokens;

  /// Create a copy of TokensByType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokensByTypeCopyWith<TokensByType> get copyWith =>
      _$TokensByTypeCopyWithImpl<TokensByType>(
          this as TokensByType, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokensByType &&
            const DeepCollectionEquality()
                .equals(other.colorTokens, colorTokens) &&
            const DeepCollectionEquality()
                .equals(other.typographyTokens, typographyTokens) &&
            const DeepCollectionEquality()
                .equals(other.numberTokens, numberTokens) &&
            const DeepCollectionEquality()
                .equals(other.stringTokens, stringTokens) &&
            const DeepCollectionEquality()
                .equals(other.boolTokens, boolTokens));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(colorTokens),
      const DeepCollectionEquality().hash(typographyTokens),
      const DeepCollectionEquality().hash(numberTokens),
      const DeepCollectionEquality().hash(stringTokens),
      const DeepCollectionEquality().hash(boolTokens));

  @override
  String toString() {
    return 'TokensByType(colorTokens: $colorTokens, typographyTokens: $typographyTokens, numberTokens: $numberTokens, stringTokens: $stringTokens, boolTokens: $boolTokens)';
  }
}

/// @nodoc
abstract mixin class $TokensByTypeCopyWith<$Res> {
  factory $TokensByTypeCopyWith(
          TokensByType value, $Res Function(TokensByType) _then) =
      _$TokensByTypeCopyWithImpl;
  @useResult
  $Res call(
      {Iterable<DesignToken<int>> colorTokens,
      Iterable<DesignToken<Typography>> typographyTokens,
      Iterable<DesignToken<double>> numberTokens,
      Iterable<DesignToken<String>> stringTokens,
      Iterable<DesignToken<bool>> boolTokens});
}

/// @nodoc
class _$TokensByTypeCopyWithImpl<$Res> implements $TokensByTypeCopyWith<$Res> {
  _$TokensByTypeCopyWithImpl(this._self, this._then);

  final TokensByType _self;
  final $Res Function(TokensByType) _then;

  /// Create a copy of TokensByType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colorTokens = null,
    Object? typographyTokens = null,
    Object? numberTokens = null,
    Object? stringTokens = null,
    Object? boolTokens = null,
  }) {
    return _then(_self.copyWith(
      colorTokens: null == colorTokens
          ? _self.colorTokens
          : colorTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<int>>,
      typographyTokens: null == typographyTokens
          ? _self.typographyTokens
          : typographyTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<Typography>>,
      numberTokens: null == numberTokens
          ? _self.numberTokens
          : numberTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<double>>,
      stringTokens: null == stringTokens
          ? _self.stringTokens
          : stringTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<String>>,
      boolTokens: null == boolTokens
          ? _self.boolTokens
          : boolTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<bool>>,
    ));
  }
}

/// @nodoc

class _TokensByType extends TokensByType {
  const _TokensByType(
      {this.colorTokens = const [],
      this.typographyTokens = const [],
      this.numberTokens = const [],
      this.stringTokens = const [],
      this.boolTokens = const []})
      : super._();

  @override
  @JsonKey()
  final Iterable<DesignToken<int>> colorTokens;
  @override
  @JsonKey()
  final Iterable<DesignToken<Typography>> typographyTokens;
  @override
  @JsonKey()
  final Iterable<DesignToken<double>> numberTokens;
  @override
  @JsonKey()
  final Iterable<DesignToken<String>> stringTokens;
  @override
  @JsonKey()
  final Iterable<DesignToken<bool>> boolTokens;

  /// Create a copy of TokensByType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TokensByTypeCopyWith<_TokensByType> get copyWith =>
      __$TokensByTypeCopyWithImpl<_TokensByType>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TokensByType &&
            const DeepCollectionEquality()
                .equals(other.colorTokens, colorTokens) &&
            const DeepCollectionEquality()
                .equals(other.typographyTokens, typographyTokens) &&
            const DeepCollectionEquality()
                .equals(other.numberTokens, numberTokens) &&
            const DeepCollectionEquality()
                .equals(other.stringTokens, stringTokens) &&
            const DeepCollectionEquality()
                .equals(other.boolTokens, boolTokens));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(colorTokens),
      const DeepCollectionEquality().hash(typographyTokens),
      const DeepCollectionEquality().hash(numberTokens),
      const DeepCollectionEquality().hash(stringTokens),
      const DeepCollectionEquality().hash(boolTokens));

  @override
  String toString() {
    return 'TokensByType(colorTokens: $colorTokens, typographyTokens: $typographyTokens, numberTokens: $numberTokens, stringTokens: $stringTokens, boolTokens: $boolTokens)';
  }
}

/// @nodoc
abstract mixin class _$TokensByTypeCopyWith<$Res>
    implements $TokensByTypeCopyWith<$Res> {
  factory _$TokensByTypeCopyWith(
          _TokensByType value, $Res Function(_TokensByType) _then) =
      __$TokensByTypeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Iterable<DesignToken<int>> colorTokens,
      Iterable<DesignToken<Typography>> typographyTokens,
      Iterable<DesignToken<double>> numberTokens,
      Iterable<DesignToken<String>> stringTokens,
      Iterable<DesignToken<bool>> boolTokens});
}

/// @nodoc
class __$TokensByTypeCopyWithImpl<$Res>
    implements _$TokensByTypeCopyWith<$Res> {
  __$TokensByTypeCopyWithImpl(this._self, this._then);

  final _TokensByType _self;
  final $Res Function(_TokensByType) _then;

  /// Create a copy of TokensByType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? colorTokens = null,
    Object? typographyTokens = null,
    Object? numberTokens = null,
    Object? stringTokens = null,
    Object? boolTokens = null,
  }) {
    return _then(_TokensByType(
      colorTokens: null == colorTokens
          ? _self.colorTokens
          : colorTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<int>>,
      typographyTokens: null == typographyTokens
          ? _self.typographyTokens
          : typographyTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<Typography>>,
      numberTokens: null == numberTokens
          ? _self.numberTokens
          : numberTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<double>>,
      stringTokens: null == stringTokens
          ? _self.stringTokens
          : stringTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<String>>,
      boolTokens: null == boolTokens
          ? _self.boolTokens
          : boolTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<bool>>,
    ));
  }
}

// dart format on
