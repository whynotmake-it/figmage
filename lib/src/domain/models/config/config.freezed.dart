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

  /// The name of the generated dart package, e.g. figmage_example.
  String get packageName => throw _privateConstructorUsedError;

  /// The description of the generated dart package.
  String get packageDescription => throw _privateConstructorUsedError;

  /// The directory to generate the package in, relative to the config file.
  ///
  /// Defaults to the current directory.
  String get packageDir => throw _privateConstructorUsedError;

  /// Color generation settings, defaults to generating color tokens from
  /// all paths.
  GenerationSettings get colors => throw _privateConstructorUsedError;

  /// Typography generation settings, defaults to generating typography tokens
  /// from all paths.
  GenerationSettings get typography => throw _privateConstructorUsedError;

  /// String generation settings, defaults to generating string tokens from
  /// all paths.
  GenerationSettings get strings => throw _privateConstructorUsedError;

  /// Boolean generation settings, defaults to generating boolean tokens from
  /// all paths.
  GenerationSettings get bools => throw _privateConstructorUsedError;

  /// Spacers generation settings, defaults to not generating spacers.
  GenerationSettings get spacers => throw _privateConstructorUsedError;

  /// Paddings generation settings, defaults to not generating paddings.
  GenerationSettings get paddings => throw _privateConstructorUsedError;

  /// Borders generation settings, defaults to not generating borders.
  GenerationSettings get radii => throw _privateConstructorUsedError;

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
      String packageName,
      String packageDescription,
      String packageDir,
      GenerationSettings colors,
      GenerationSettings typography,
      GenerationSettings strings,
      GenerationSettings bools,
      GenerationSettings spacers,
      GenerationSettings paddings,
      GenerationSettings radii});

  $GenerationSettingsCopyWith<$Res> get colors;
  $GenerationSettingsCopyWith<$Res> get typography;
  $GenerationSettingsCopyWith<$Res> get strings;
  $GenerationSettingsCopyWith<$Res> get bools;
  $GenerationSettingsCopyWith<$Res> get spacers;
  $GenerationSettingsCopyWith<$Res> get paddings;
  $GenerationSettingsCopyWith<$Res> get radii;
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
    Object? packageName = null,
    Object? packageDescription = null,
    Object? packageDir = null,
    Object? colors = null,
    Object? typography = null,
    Object? strings = null,
    Object? bools = null,
    Object? spacers = null,
    Object? paddings = null,
    Object? radii = null,
  }) {
    return _then(_value.copyWith(
      fileId: null == fileId
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageDescription: null == packageDescription
          ? _value.packageDescription
          : packageDescription // ignore: cast_nullable_to_non_nullable
              as String,
      packageDir: null == packageDir
          ? _value.packageDir
          : packageDir // ignore: cast_nullable_to_non_nullable
              as String,
      colors: null == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as GenerationSettings,
      typography: null == typography
          ? _value.typography
          : typography // ignore: cast_nullable_to_non_nullable
              as GenerationSettings,
      strings: null == strings
          ? _value.strings
          : strings // ignore: cast_nullable_to_non_nullable
              as GenerationSettings,
      bools: null == bools
          ? _value.bools
          : bools // ignore: cast_nullable_to_non_nullable
              as GenerationSettings,
      spacers: null == spacers
          ? _value.spacers
          : spacers // ignore: cast_nullable_to_non_nullable
              as GenerationSettings,
      paddings: null == paddings
          ? _value.paddings
          : paddings // ignore: cast_nullable_to_non_nullable
              as GenerationSettings,
      radii: null == radii
          ? _value.radii
          : radii // ignore: cast_nullable_to_non_nullable
              as GenerationSettings,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GenerationSettingsCopyWith<$Res> get colors {
    return $GenerationSettingsCopyWith<$Res>(_value.colors, (value) {
      return _then(_value.copyWith(colors: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GenerationSettingsCopyWith<$Res> get typography {
    return $GenerationSettingsCopyWith<$Res>(_value.typography, (value) {
      return _then(_value.copyWith(typography: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GenerationSettingsCopyWith<$Res> get strings {
    return $GenerationSettingsCopyWith<$Res>(_value.strings, (value) {
      return _then(_value.copyWith(strings: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GenerationSettingsCopyWith<$Res> get bools {
    return $GenerationSettingsCopyWith<$Res>(_value.bools, (value) {
      return _then(_value.copyWith(bools: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GenerationSettingsCopyWith<$Res> get spacers {
    return $GenerationSettingsCopyWith<$Res>(_value.spacers, (value) {
      return _then(_value.copyWith(spacers: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GenerationSettingsCopyWith<$Res> get paddings {
    return $GenerationSettingsCopyWith<$Res>(_value.paddings, (value) {
      return _then(_value.copyWith(paddings: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GenerationSettingsCopyWith<$Res> get radii {
    return $GenerationSettingsCopyWith<$Res>(_value.radii, (value) {
      return _then(_value.copyWith(radii: value) as $Val);
    });
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
      String packageName,
      String packageDescription,
      String packageDir,
      GenerationSettings colors,
      GenerationSettings typography,
      GenerationSettings strings,
      GenerationSettings bools,
      GenerationSettings spacers,
      GenerationSettings paddings,
      GenerationSettings radii});

  @override
  $GenerationSettingsCopyWith<$Res> get colors;
  @override
  $GenerationSettingsCopyWith<$Res> get typography;
  @override
  $GenerationSettingsCopyWith<$Res> get strings;
  @override
  $GenerationSettingsCopyWith<$Res> get bools;
  @override
  $GenerationSettingsCopyWith<$Res> get spacers;
  @override
  $GenerationSettingsCopyWith<$Res> get paddings;
  @override
  $GenerationSettingsCopyWith<$Res> get radii;
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
    Object? packageName = null,
    Object? packageDescription = null,
    Object? packageDir = null,
    Object? colors = null,
    Object? typography = null,
    Object? strings = null,
    Object? bools = null,
    Object? spacers = null,
    Object? paddings = null,
    Object? radii = null,
  }) {
    return _then(_$ConfigImpl(
      fileId: null == fileId
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageDescription: null == packageDescription
          ? _value.packageDescription
          : packageDescription // ignore: cast_nullable_to_non_nullable
              as String,
      packageDir: null == packageDir
          ? _value.packageDir
          : packageDir // ignore: cast_nullable_to_non_nullable
              as String,
      colors: null == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as GenerationSettings,
      typography: null == typography
          ? _value.typography
          : typography // ignore: cast_nullable_to_non_nullable
              as GenerationSettings,
      strings: null == strings
          ? _value.strings
          : strings // ignore: cast_nullable_to_non_nullable
              as GenerationSettings,
      bools: null == bools
          ? _value.bools
          : bools // ignore: cast_nullable_to_non_nullable
              as GenerationSettings,
      spacers: null == spacers
          ? _value.spacers
          : spacers // ignore: cast_nullable_to_non_nullable
              as GenerationSettings,
      paddings: null == paddings
          ? _value.paddings
          : paddings // ignore: cast_nullable_to_non_nullable
              as GenerationSettings,
      radii: null == radii
          ? _value.radii
          : radii // ignore: cast_nullable_to_non_nullable
              as GenerationSettings,
    ));
  }
}

/// @nodoc

class _$ConfigImpl extends _Config {
  const _$ConfigImpl(
      {required this.fileId,
      required this.packageName,
      this.packageDescription = '',
      this.packageDir = '.',
      this.colors = const GenerationSettings(),
      this.typography = const GenerationSettings(),
      this.strings = const GenerationSettings(),
      this.bools = const GenerationSettings(),
      this.spacers = const GenerationSettings(generate: false),
      this.paddings = const GenerationSettings(generate: false),
      this.radii = const GenerationSettings(generate: false)})
      : super._();

  /// figma file ID.
  @override
  final String fileId;

  /// The name of the generated dart package, e.g. figmage_example.
  @override
  final String packageName;

  /// The description of the generated dart package.
  @override
  @JsonKey()
  final String packageDescription;

  /// The directory to generate the package in, relative to the config file.
  ///
  /// Defaults to the current directory.
  @override
  @JsonKey()
  final String packageDir;

  /// Color generation settings, defaults to generating color tokens from
  /// all paths.
  @override
  @JsonKey()
  final GenerationSettings colors;

  /// Typography generation settings, defaults to generating typography tokens
  /// from all paths.
  @override
  @JsonKey()
  final GenerationSettings typography;

  /// String generation settings, defaults to generating string tokens from
  /// all paths.
  @override
  @JsonKey()
  final GenerationSettings strings;

  /// Boolean generation settings, defaults to generating boolean tokens from
  /// all paths.
  @override
  @JsonKey()
  final GenerationSettings bools;

  /// Spacers generation settings, defaults to not generating spacers.
  @override
  @JsonKey()
  final GenerationSettings spacers;

  /// Paddings generation settings, defaults to not generating paddings.
  @override
  @JsonKey()
  final GenerationSettings paddings;

  /// Borders generation settings, defaults to not generating borders.
  @override
  @JsonKey()
  final GenerationSettings radii;

  @override
  String toString() {
    return 'Config(fileId: $fileId, packageName: $packageName, packageDescription: $packageDescription, packageDir: $packageDir, colors: $colors, typography: $typography, strings: $strings, bools: $bools, spacers: $spacers, paddings: $paddings, radii: $radii)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigImpl &&
            (identical(other.fileId, fileId) || other.fileId == fileId) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.packageDescription, packageDescription) ||
                other.packageDescription == packageDescription) &&
            (identical(other.packageDir, packageDir) ||
                other.packageDir == packageDir) &&
            (identical(other.colors, colors) || other.colors == colors) &&
            (identical(other.typography, typography) ||
                other.typography == typography) &&
            (identical(other.strings, strings) || other.strings == strings) &&
            (identical(other.bools, bools) || other.bools == bools) &&
            (identical(other.spacers, spacers) || other.spacers == spacers) &&
            (identical(other.paddings, paddings) ||
                other.paddings == paddings) &&
            (identical(other.radii, radii) || other.radii == radii));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fileId,
      packageName,
      packageDescription,
      packageDir,
      colors,
      typography,
      strings,
      bools,
      spacers,
      paddings,
      radii);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigImplCopyWith<_$ConfigImpl> get copyWith =>
      __$$ConfigImplCopyWithImpl<_$ConfigImpl>(this, _$identity);
}

abstract class _Config extends Config {
  const factory _Config(
      {required final String fileId,
      required final String packageName,
      final String packageDescription,
      final String packageDir,
      final GenerationSettings colors,
      final GenerationSettings typography,
      final GenerationSettings strings,
      final GenerationSettings bools,
      final GenerationSettings spacers,
      final GenerationSettings paddings,
      final GenerationSettings radii}) = _$ConfigImpl;
  const _Config._() : super._();

  @override

  /// figma file ID.
  String get fileId;
  @override

  /// The name of the generated dart package, e.g. figmage_example.
  String get packageName;
  @override

  /// The description of the generated dart package.
  String get packageDescription;
  @override

  /// The directory to generate the package in, relative to the config file.
  ///
  /// Defaults to the current directory.
  String get packageDir;
  @override

  /// Color generation settings, defaults to generating color tokens from
  /// all paths.
  GenerationSettings get colors;
  @override

  /// Typography generation settings, defaults to generating typography tokens
  /// from all paths.
  GenerationSettings get typography;
  @override

  /// String generation settings, defaults to generating string tokens from
  /// all paths.
  GenerationSettings get strings;
  @override

  /// Boolean generation settings, defaults to generating boolean tokens from
  /// all paths.
  GenerationSettings get bools;
  @override

  /// Spacers generation settings, defaults to not generating spacers.
  GenerationSettings get spacers;
  @override

  /// Paddings generation settings, defaults to not generating paddings.
  GenerationSettings get paddings;
  @override

  /// Borders generation settings, defaults to not generating borders.
  GenerationSettings get radii;
  @override
  @JsonKey(ignore: true)
  _$$ConfigImplCopyWith<_$ConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GenerationSettings {
  /// Whether or not to generate the token, defaults to true.
  bool get generate => throw _privateConstructorUsedError;

  /// The paths to generate from, defaults to empty which means all paths.
  Iterable<String> get from => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GenerationSettingsCopyWith<GenerationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerationSettingsCopyWith<$Res> {
  factory $GenerationSettingsCopyWith(
          GenerationSettings value, $Res Function(GenerationSettings) then) =
      _$GenerationSettingsCopyWithImpl<$Res, GenerationSettings>;
  @useResult
  $Res call({bool generate, Iterable<String> from});
}

/// @nodoc
class _$GenerationSettingsCopyWithImpl<$Res, $Val extends GenerationSettings>
    implements $GenerationSettingsCopyWith<$Res> {
  _$GenerationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generate = null,
    Object? from = null,
  }) {
    return _then(_value.copyWith(
      generate: null == generate
          ? _value.generate
          : generate // ignore: cast_nullable_to_non_nullable
              as bool,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as Iterable<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenerationSettingsImplCopyWith<$Res>
    implements $GenerationSettingsCopyWith<$Res> {
  factory _$$GenerationSettingsImplCopyWith(_$GenerationSettingsImpl value,
          $Res Function(_$GenerationSettingsImpl) then) =
      __$$GenerationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool generate, Iterable<String> from});
}

/// @nodoc
class __$$GenerationSettingsImplCopyWithImpl<$Res>
    extends _$GenerationSettingsCopyWithImpl<$Res, _$GenerationSettingsImpl>
    implements _$$GenerationSettingsImplCopyWith<$Res> {
  __$$GenerationSettingsImplCopyWithImpl(_$GenerationSettingsImpl _value,
      $Res Function(_$GenerationSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generate = null,
    Object? from = null,
  }) {
    return _then(_$GenerationSettingsImpl(
      generate: null == generate
          ? _value.generate
          : generate // ignore: cast_nullable_to_non_nullable
              as bool,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as Iterable<String>,
    ));
  }
}

/// @nodoc

class _$GenerationSettingsImpl extends _GenerationSettings {
  const _$GenerationSettingsImpl(
      {this.generate = true, this.from = const <String>[]})
      : super._();

  /// Whether or not to generate the token, defaults to true.
  @override
  @JsonKey()
  final bool generate;

  /// The paths to generate from, defaults to empty which means all paths.
  @override
  @JsonKey()
  final Iterable<String> from;

  @override
  String toString() {
    return 'GenerationSettings(generate: $generate, from: $from)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerationSettingsImpl &&
            (identical(other.generate, generate) ||
                other.generate == generate) &&
            const DeepCollectionEquality().equals(other.from, from));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, generate, const DeepCollectionEquality().hash(from));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerationSettingsImplCopyWith<_$GenerationSettingsImpl> get copyWith =>
      __$$GenerationSettingsImplCopyWithImpl<_$GenerationSettingsImpl>(
          this, _$identity);
}

abstract class _GenerationSettings extends GenerationSettings {
  const factory _GenerationSettings(
      {final bool generate,
      final Iterable<String> from}) = _$GenerationSettingsImpl;
  const _GenerationSettings._() : super._();

  @override

  /// Whether or not to generate the token, defaults to true.
  bool get generate;
  @override

  /// The paths to generate from, defaults to empty which means all paths.
  Iterable<String> get from;
  @override
  @JsonKey(ignore: true)
  _$$GenerationSettingsImplCopyWith<_$GenerationSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
