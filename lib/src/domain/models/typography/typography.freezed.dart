// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'typography.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Typography {
  String get fontFamily;
  String? get fontFamilyPostScriptName;
  double get fontSize;
  int get fontWeight;
  TextDecoration get decoration;
  FontStyle get fontStyle;
  double get letterSpacing;
  double get wordSpacing;
  double get height;

  /// Create a copy of Typography
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TypographyCopyWith<Typography> get copyWith =>
      _$TypographyCopyWithImpl<Typography>(this as Typography, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Typography &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(
                    other.fontFamilyPostScriptName, fontFamilyPostScriptName) ||
                other.fontFamilyPostScriptName == fontFamilyPostScriptName) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.fontWeight, fontWeight) ||
                other.fontWeight == fontWeight) &&
            (identical(other.decoration, decoration) ||
                other.decoration == decoration) &&
            (identical(other.fontStyle, fontStyle) ||
                other.fontStyle == fontStyle) &&
            (identical(other.letterSpacing, letterSpacing) ||
                other.letterSpacing == letterSpacing) &&
            (identical(other.wordSpacing, wordSpacing) ||
                other.wordSpacing == wordSpacing) &&
            (identical(other.height, height) || other.height == height));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fontFamily,
      fontFamilyPostScriptName,
      fontSize,
      fontWeight,
      decoration,
      fontStyle,
      letterSpacing,
      wordSpacing,
      height);

  @override
  String toString() {
    return 'Typography(fontFamily: $fontFamily, fontFamilyPostScriptName: $fontFamilyPostScriptName, fontSize: $fontSize, fontWeight: $fontWeight, decoration: $decoration, fontStyle: $fontStyle, letterSpacing: $letterSpacing, wordSpacing: $wordSpacing, height: $height)';
  }
}

/// @nodoc
abstract mixin class $TypographyCopyWith<$Res> {
  factory $TypographyCopyWith(
          Typography value, $Res Function(Typography) _then) =
      _$TypographyCopyWithImpl;
  @useResult
  $Res call(
      {String fontFamily,
      String? fontFamilyPostScriptName,
      double fontSize,
      int fontWeight,
      TextDecoration decoration,
      FontStyle fontStyle,
      double letterSpacing,
      double wordSpacing,
      double height});
}

/// @nodoc
class _$TypographyCopyWithImpl<$Res> implements $TypographyCopyWith<$Res> {
  _$TypographyCopyWithImpl(this._self, this._then);

  final Typography _self;
  final $Res Function(Typography) _then;

  /// Create a copy of Typography
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontFamily = null,
    Object? fontFamilyPostScriptName = freezed,
    Object? fontSize = null,
    Object? fontWeight = null,
    Object? decoration = null,
    Object? fontStyle = null,
    Object? letterSpacing = null,
    Object? wordSpacing = null,
    Object? height = null,
  }) {
    return _then(_self.copyWith(
      fontFamily: null == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      fontFamilyPostScriptName: freezed == fontFamilyPostScriptName
          ? _self.fontFamilyPostScriptName
          : fontFamilyPostScriptName // ignore: cast_nullable_to_non_nullable
              as String?,
      fontSize: null == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
      fontWeight: null == fontWeight
          ? _self.fontWeight
          : fontWeight // ignore: cast_nullable_to_non_nullable
              as int,
      decoration: null == decoration
          ? _self.decoration
          : decoration // ignore: cast_nullable_to_non_nullable
              as TextDecoration,
      fontStyle: null == fontStyle
          ? _self.fontStyle
          : fontStyle // ignore: cast_nullable_to_non_nullable
              as FontStyle,
      letterSpacing: null == letterSpacing
          ? _self.letterSpacing
          : letterSpacing // ignore: cast_nullable_to_non_nullable
              as double,
      wordSpacing: null == wordSpacing
          ? _self.wordSpacing
          : wordSpacing // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _Typography extends Typography {
  const _Typography(
      {required this.fontFamily,
      required this.fontFamilyPostScriptName,
      required this.fontSize,
      this.fontWeight = 400,
      this.decoration = TextDecoration.none,
      this.fontStyle = FontStyle.normal,
      this.letterSpacing = 1.0,
      this.wordSpacing = 1.0,
      this.height = 1.0})
      : super._();

  @override
  final String fontFamily;
  @override
  final String? fontFamilyPostScriptName;
  @override
  final double fontSize;
  @override
  @JsonKey()
  final int fontWeight;
  @override
  @JsonKey()
  final TextDecoration decoration;
  @override
  @JsonKey()
  final FontStyle fontStyle;
  @override
  @JsonKey()
  final double letterSpacing;
  @override
  @JsonKey()
  final double wordSpacing;
  @override
  @JsonKey()
  final double height;

  /// Create a copy of Typography
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TypographyCopyWith<_Typography> get copyWith =>
      __$TypographyCopyWithImpl<_Typography>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Typography &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(
                    other.fontFamilyPostScriptName, fontFamilyPostScriptName) ||
                other.fontFamilyPostScriptName == fontFamilyPostScriptName) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.fontWeight, fontWeight) ||
                other.fontWeight == fontWeight) &&
            (identical(other.decoration, decoration) ||
                other.decoration == decoration) &&
            (identical(other.fontStyle, fontStyle) ||
                other.fontStyle == fontStyle) &&
            (identical(other.letterSpacing, letterSpacing) ||
                other.letterSpacing == letterSpacing) &&
            (identical(other.wordSpacing, wordSpacing) ||
                other.wordSpacing == wordSpacing) &&
            (identical(other.height, height) || other.height == height));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fontFamily,
      fontFamilyPostScriptName,
      fontSize,
      fontWeight,
      decoration,
      fontStyle,
      letterSpacing,
      wordSpacing,
      height);

  @override
  String toString() {
    return 'Typography(fontFamily: $fontFamily, fontFamilyPostScriptName: $fontFamilyPostScriptName, fontSize: $fontSize, fontWeight: $fontWeight, decoration: $decoration, fontStyle: $fontStyle, letterSpacing: $letterSpacing, wordSpacing: $wordSpacing, height: $height)';
  }
}

/// @nodoc
abstract mixin class _$TypographyCopyWith<$Res>
    implements $TypographyCopyWith<$Res> {
  factory _$TypographyCopyWith(
          _Typography value, $Res Function(_Typography) _then) =
      __$TypographyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String fontFamily,
      String? fontFamilyPostScriptName,
      double fontSize,
      int fontWeight,
      TextDecoration decoration,
      FontStyle fontStyle,
      double letterSpacing,
      double wordSpacing,
      double height});
}

/// @nodoc
class __$TypographyCopyWithImpl<$Res> implements _$TypographyCopyWith<$Res> {
  __$TypographyCopyWithImpl(this._self, this._then);

  final _Typography _self;
  final $Res Function(_Typography) _then;

  /// Create a copy of Typography
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? fontFamily = null,
    Object? fontFamilyPostScriptName = freezed,
    Object? fontSize = null,
    Object? fontWeight = null,
    Object? decoration = null,
    Object? fontStyle = null,
    Object? letterSpacing = null,
    Object? wordSpacing = null,
    Object? height = null,
  }) {
    return _then(_Typography(
      fontFamily: null == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      fontFamilyPostScriptName: freezed == fontFamilyPostScriptName
          ? _self.fontFamilyPostScriptName
          : fontFamilyPostScriptName // ignore: cast_nullable_to_non_nullable
              as String?,
      fontSize: null == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
      fontWeight: null == fontWeight
          ? _self.fontWeight
          : fontWeight // ignore: cast_nullable_to_non_nullable
              as int,
      decoration: null == decoration
          ? _self.decoration
          : decoration // ignore: cast_nullable_to_non_nullable
              as TextDecoration,
      fontStyle: null == fontStyle
          ? _self.fontStyle
          : fontStyle // ignore: cast_nullable_to_non_nullable
              as FontStyle,
      letterSpacing: null == letterSpacing
          ? _self.letterSpacing
          : letterSpacing // ignore: cast_nullable_to_non_nullable
              as double,
      wordSpacing: null == wordSpacing
          ? _self.wordSpacing
          : wordSpacing // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
