// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tokens_by_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TokensByType {
  Iterable<DesignToken<int>> get colorTokens =>
      throw _privateConstructorUsedError;
  Iterable<DesignToken<TextStyle>> get typographyTokens =>
      throw _privateConstructorUsedError;
  Iterable<DesignToken<double>> get numberTokens =>
      throw _privateConstructorUsedError;
  Iterable<DesignToken<String>> get stringTokens =>
      throw _privateConstructorUsedError;
  Iterable<DesignToken<bool>> get boolTokens =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TokensByTypeCopyWith<TokensByType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokensByTypeCopyWith<$Res> {
  factory $TokensByTypeCopyWith(
          TokensByType value, $Res Function(TokensByType) then) =
      _$TokensByTypeCopyWithImpl<$Res, TokensByType>;
  @useResult
  $Res call(
      {Iterable<DesignToken<int>> colorTokens,
      Iterable<DesignToken<TextStyle>> typographyTokens,
      Iterable<DesignToken<double>> numberTokens,
      Iterable<DesignToken<String>> stringTokens,
      Iterable<DesignToken<bool>> boolTokens});
}

/// @nodoc
class _$TokensByTypeCopyWithImpl<$Res, $Val extends TokensByType>
    implements $TokensByTypeCopyWith<$Res> {
  _$TokensByTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colorTokens = null,
    Object? typographyTokens = null,
    Object? numberTokens = null,
    Object? stringTokens = null,
    Object? boolTokens = null,
  }) {
    return _then(_value.copyWith(
      colorTokens: null == colorTokens
          ? _value.colorTokens
          : colorTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<int>>,
      typographyTokens: null == typographyTokens
          ? _value.typographyTokens
          : typographyTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<TextStyle>>,
      numberTokens: null == numberTokens
          ? _value.numberTokens
          : numberTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<double>>,
      stringTokens: null == stringTokens
          ? _value.stringTokens
          : stringTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<String>>,
      boolTokens: null == boolTokens
          ? _value.boolTokens
          : boolTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<bool>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokensByTypeImplCopyWith<$Res>
    implements $TokensByTypeCopyWith<$Res> {
  factory _$$TokensByTypeImplCopyWith(
          _$TokensByTypeImpl value, $Res Function(_$TokensByTypeImpl) then) =
      __$$TokensByTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Iterable<DesignToken<int>> colorTokens,
      Iterable<DesignToken<TextStyle>> typographyTokens,
      Iterable<DesignToken<double>> numberTokens,
      Iterable<DesignToken<String>> stringTokens,
      Iterable<DesignToken<bool>> boolTokens});
}

/// @nodoc
class __$$TokensByTypeImplCopyWithImpl<$Res>
    extends _$TokensByTypeCopyWithImpl<$Res, _$TokensByTypeImpl>
    implements _$$TokensByTypeImplCopyWith<$Res> {
  __$$TokensByTypeImplCopyWithImpl(
      _$TokensByTypeImpl _value, $Res Function(_$TokensByTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colorTokens = null,
    Object? typographyTokens = null,
    Object? numberTokens = null,
    Object? stringTokens = null,
    Object? boolTokens = null,
  }) {
    return _then(_$TokensByTypeImpl(
      colorTokens: null == colorTokens
          ? _value.colorTokens
          : colorTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<int>>,
      typographyTokens: null == typographyTokens
          ? _value.typographyTokens
          : typographyTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<TextStyle>>,
      numberTokens: null == numberTokens
          ? _value.numberTokens
          : numberTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<double>>,
      stringTokens: null == stringTokens
          ? _value.stringTokens
          : stringTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<String>>,
      boolTokens: null == boolTokens
          ? _value.boolTokens
          : boolTokens // ignore: cast_nullable_to_non_nullable
              as Iterable<DesignToken<bool>>,
    ));
  }
}

/// @nodoc

class _$TokensByTypeImpl extends _TokensByType {
  const _$TokensByTypeImpl(
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
  final Iterable<DesignToken<TextStyle>> typographyTokens;
  @override
  @JsonKey()
  final Iterable<DesignToken<double>> numberTokens;
  @override
  @JsonKey()
  final Iterable<DesignToken<String>> stringTokens;
  @override
  @JsonKey()
  final Iterable<DesignToken<bool>> boolTokens;

  @override
  String toString() {
    return 'TokensByType(colorTokens: $colorTokens, typographyTokens: $typographyTokens, numberTokens: $numberTokens, stringTokens: $stringTokens, boolTokens: $boolTokens)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokensByTypeImpl &&
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokensByTypeImplCopyWith<_$TokensByTypeImpl> get copyWith =>
      __$$TokensByTypeImplCopyWithImpl<_$TokensByTypeImpl>(this, _$identity);
}

abstract class _TokensByType extends TokensByType {
  const factory _TokensByType(
      {final Iterable<DesignToken<int>> colorTokens,
      final Iterable<DesignToken<TextStyle>> typographyTokens,
      final Iterable<DesignToken<double>> numberTokens,
      final Iterable<DesignToken<String>> stringTokens,
      final Iterable<DesignToken<bool>> boolTokens}) = _$TokensByTypeImpl;
  const _TokensByType._() : super._();

  @override
  Iterable<DesignToken<int>> get colorTokens;
  @override
  Iterable<DesignToken<TextStyle>> get typographyTokens;
  @override
  Iterable<DesignToken<double>> get numberTokens;
  @override
  Iterable<DesignToken<String>> get stringTokens;
  @override
  Iterable<DesignToken<bool>> get boolTokens;
  @override
  @JsonKey(ignore: true)
  _$$TokensByTypeImplCopyWith<_$TokensByTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
