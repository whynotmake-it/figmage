// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Config {
  /// figma file ID.
  String get fileId => throw _privateConstructorUsedError;

  /// Include color generation.
  bool get generateColors => throw _privateConstructorUsedError;

  /// Include text style generation.
  bool get generateTextStyles => throw _privateConstructorUsedError;

  /// Include String generation
  bool get generateStrings => throw _privateConstructorUsedError;

  /// Include bool generation
  bool get generateBools => throw _privateConstructorUsedError;

  /// Include spacers generation
  bool get generateSpacers => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConfigCopyWith<Config> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) then) =
      _$ConfigCopyWithImpl<$Res, Config>;
  @useResult
  $Res call(
      {String fileId,
      bool generateColors,
      bool generateTextStyles,
      bool generateStrings,
      bool generateBools,
      bool generateSpacers});
}

/// @nodoc
class _$ConfigCopyWithImpl<$Res, $Val extends Config>
    implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileId = null,
    Object? generateColors = null,
    Object? generateTextStyles = null,
    Object? generateStrings = null,
    Object? generateBools = null,
    Object? generateSpacers = null,
  }) {
    return _then(_value.copyWith(
      fileId: null == fileId
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as String,
      generateColors: null == generateColors
          ? _value.generateColors
          : generateColors // ignore: cast_nullable_to_non_nullable
              as bool,
      generateTextStyles: null == generateTextStyles
          ? _value.generateTextStyles
          : generateTextStyles // ignore: cast_nullable_to_non_nullable
              as bool,
      generateStrings: null == generateStrings
          ? _value.generateStrings
          : generateStrings // ignore: cast_nullable_to_non_nullable
              as bool,
      generateBools: null == generateBools
          ? _value.generateBools
          : generateBools // ignore: cast_nullable_to_non_nullable
              as bool,
      generateSpacers: null == generateSpacers
          ? _value.generateSpacers
          : generateSpacers // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfigImplCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$$ConfigImplCopyWith(
          _$ConfigImpl value, $Res Function(_$ConfigImpl) then) =
      __$$ConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fileId,
      bool generateColors,
      bool generateTextStyles,
      bool generateStrings,
      bool generateBools,
      bool generateSpacers});
}

/// @nodoc
class __$$ConfigImplCopyWithImpl<$Res>
    extends _$ConfigCopyWithImpl<$Res, _$ConfigImpl>
    implements _$$ConfigImplCopyWith<$Res> {
  __$$ConfigImplCopyWithImpl(
      _$ConfigImpl _value, $Res Function(_$ConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileId = null,
    Object? generateColors = null,
    Object? generateTextStyles = null,
    Object? generateStrings = null,
    Object? generateBools = null,
    Object? generateSpacers = null,
  }) {
    return _then(_$ConfigImpl(
      fileId: null == fileId
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as String,
      generateColors: null == generateColors
          ? _value.generateColors
          : generateColors // ignore: cast_nullable_to_non_nullable
              as bool,
      generateTextStyles: null == generateTextStyles
          ? _value.generateTextStyles
          : generateTextStyles // ignore: cast_nullable_to_non_nullable
              as bool,
      generateStrings: null == generateStrings
          ? _value.generateStrings
          : generateStrings // ignore: cast_nullable_to_non_nullable
              as bool,
      generateBools: null == generateBools
          ? _value.generateBools
          : generateBools // ignore: cast_nullable_to_non_nullable
              as bool,
      generateSpacers: null == generateSpacers
          ? _value.generateSpacers
          : generateSpacers // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ConfigImpl extends _Config {
  const _$ConfigImpl(
      {required this.fileId,
      required this.generateColors,
      required this.generateTextStyles,
      required this.generateStrings,
      required this.generateBools,
      required this.generateSpacers})
      : super._();

  /// figma file ID.
  @override
  final String fileId;

  /// Include color generation.
  @override
  final bool generateColors;

  /// Include text style generation.
  @override
  final bool generateTextStyles;

  /// Include String generation
  @override
  final bool generateStrings;

  /// Include bool generation
  @override
  final bool generateBools;

  /// Include spacers generation
  @override
  final bool generateSpacers;

  @override
  String toString() {
    return 'Config(fileId: $fileId, generateColors: $generateColors, generateTextStyles: $generateTextStyles, generateStrings: $generateStrings, generateBools: $generateBools, generateSpacers: $generateSpacers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigImpl &&
            (identical(other.fileId, fileId) || other.fileId == fileId) &&
            (identical(other.generateColors, generateColors) ||
                other.generateColors == generateColors) &&
            (identical(other.generateTextStyles, generateTextStyles) ||
                other.generateTextStyles == generateTextStyles) &&
            (identical(other.generateStrings, generateStrings) ||
                other.generateStrings == generateStrings) &&
            (identical(other.generateBools, generateBools) ||
                other.generateBools == generateBools) &&
            (identical(other.generateSpacers, generateSpacers) ||
                other.generateSpacers == generateSpacers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fileId, generateColors,
      generateTextStyles, generateStrings, generateBools, generateSpacers);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigImplCopyWith<_$ConfigImpl> get copyWith =>
      __$$ConfigImplCopyWithImpl<_$ConfigImpl>(this, _$identity);
}

abstract class _Config extends Config {
  const factory _Config(
      {required final String fileId,
      required final bool generateColors,
      required final bool generateTextStyles,
      required final bool generateStrings,
      required final bool generateBools,
      required final bool generateSpacers}) = _$ConfigImpl;
  const _Config._() : super._();

  @override

  /// figma file ID.
  String get fileId;
  @override

  /// Include color generation.
  bool get generateColors;
  @override

  /// Include text style generation.
  bool get generateTextStyles;
  @override

  /// Include String generation
  bool get generateStrings;
  @override

  /// Include bool generation
  bool get generateBools;
  @override

  /// Include spacers generation
  bool get generateSpacers;
  @override
  @JsonKey(ignore: true)
  _$$ConfigImplCopyWith<_$ConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
