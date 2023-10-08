// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'variable_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VariableValue _$VariableValueFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'boolean':
      return BooleanValue.fromJson(json);
    case 'number':
      return NumberValue.fromJson(json);
    case 'string':
      return StringValue.fromJson(json);
    case 'color':
      return ColorValue.fromJson(json);
    case 'variableAlias':
      return VariableAliasValue.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'VariableValue',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$VariableValue {
  Object get value => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool value) boolean,
    required TResult Function(double value) number,
    required TResult Function(String value) string,
    required TResult Function(int value) color,
    required TResult Function(VariableAlias value) variableAlias,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool value)? boolean,
    TResult? Function(double value)? number,
    TResult? Function(String value)? string,
    TResult? Function(int value)? color,
    TResult? Function(VariableAlias value)? variableAlias,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool value)? boolean,
    TResult Function(double value)? number,
    TResult Function(String value)? string,
    TResult Function(int value)? color,
    TResult Function(VariableAlias value)? variableAlias,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BooleanValue value) boolean,
    required TResult Function(NumberValue value) number,
    required TResult Function(StringValue value) string,
    required TResult Function(ColorValue value) color,
    required TResult Function(VariableAliasValue value) variableAlias,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BooleanValue value)? boolean,
    TResult? Function(NumberValue value)? number,
    TResult? Function(StringValue value)? string,
    TResult? Function(ColorValue value)? color,
    TResult? Function(VariableAliasValue value)? variableAlias,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BooleanValue value)? boolean,
    TResult Function(NumberValue value)? number,
    TResult Function(StringValue value)? string,
    TResult Function(ColorValue value)? color,
    TResult Function(VariableAliasValue value)? variableAlias,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariableValueCopyWith<$Res> {
  factory $VariableValueCopyWith(
          VariableValue value, $Res Function(VariableValue) then) =
      _$VariableValueCopyWithImpl<$Res, VariableValue>;
}

/// @nodoc
class _$VariableValueCopyWithImpl<$Res, $Val extends VariableValue>
    implements $VariableValueCopyWith<$Res> {
  _$VariableValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BooleanValueImplCopyWith<$Res> {
  factory _$$BooleanValueImplCopyWith(
          _$BooleanValueImpl value, $Res Function(_$BooleanValueImpl) then) =
      __$$BooleanValueImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool value});
}

/// @nodoc
class __$$BooleanValueImplCopyWithImpl<$Res>
    extends _$VariableValueCopyWithImpl<$Res, _$BooleanValueImpl>
    implements _$$BooleanValueImplCopyWith<$Res> {
  __$$BooleanValueImplCopyWithImpl(
      _$BooleanValueImpl _value, $Res Function(_$BooleanValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$BooleanValueImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BooleanValueImpl implements BooleanValue {
  const _$BooleanValueImpl(this.value, {final String? $type})
      : $type = $type ?? 'boolean';

  factory _$BooleanValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$BooleanValueImplFromJson(json);

  @override
  final bool value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'VariableValue.boolean(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BooleanValueImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BooleanValueImplCopyWith<_$BooleanValueImpl> get copyWith =>
      __$$BooleanValueImplCopyWithImpl<_$BooleanValueImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool value) boolean,
    required TResult Function(double value) number,
    required TResult Function(String value) string,
    required TResult Function(int value) color,
    required TResult Function(VariableAlias value) variableAlias,
  }) {
    return boolean(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool value)? boolean,
    TResult? Function(double value)? number,
    TResult? Function(String value)? string,
    TResult? Function(int value)? color,
    TResult? Function(VariableAlias value)? variableAlias,
  }) {
    return boolean?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool value)? boolean,
    TResult Function(double value)? number,
    TResult Function(String value)? string,
    TResult Function(int value)? color,
    TResult Function(VariableAlias value)? variableAlias,
    required TResult orElse(),
  }) {
    if (boolean != null) {
      return boolean(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BooleanValue value) boolean,
    required TResult Function(NumberValue value) number,
    required TResult Function(StringValue value) string,
    required TResult Function(ColorValue value) color,
    required TResult Function(VariableAliasValue value) variableAlias,
  }) {
    return boolean(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BooleanValue value)? boolean,
    TResult? Function(NumberValue value)? number,
    TResult? Function(StringValue value)? string,
    TResult? Function(ColorValue value)? color,
    TResult? Function(VariableAliasValue value)? variableAlias,
  }) {
    return boolean?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BooleanValue value)? boolean,
    TResult Function(NumberValue value)? number,
    TResult Function(StringValue value)? string,
    TResult Function(ColorValue value)? color,
    TResult Function(VariableAliasValue value)? variableAlias,
    required TResult orElse(),
  }) {
    if (boolean != null) {
      return boolean(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BooleanValueImplToJson(
      this,
    );
  }
}

abstract class BooleanValue implements VariableValue {
  const factory BooleanValue(final bool value) = _$BooleanValueImpl;

  factory BooleanValue.fromJson(Map<String, dynamic> json) =
      _$BooleanValueImpl.fromJson;

  @override
  bool get value;
  @JsonKey(ignore: true)
  _$$BooleanValueImplCopyWith<_$BooleanValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NumberValueImplCopyWith<$Res> {
  factory _$$NumberValueImplCopyWith(
          _$NumberValueImpl value, $Res Function(_$NumberValueImpl) then) =
      __$$NumberValueImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double value});
}

/// @nodoc
class __$$NumberValueImplCopyWithImpl<$Res>
    extends _$VariableValueCopyWithImpl<$Res, _$NumberValueImpl>
    implements _$$NumberValueImplCopyWith<$Res> {
  __$$NumberValueImplCopyWithImpl(
      _$NumberValueImpl _value, $Res Function(_$NumberValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$NumberValueImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NumberValueImpl implements NumberValue {
  const _$NumberValueImpl(this.value, {final String? $type})
      : $type = $type ?? 'number';

  factory _$NumberValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$NumberValueImplFromJson(json);

  @override
  final double value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'VariableValue.number(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NumberValueImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NumberValueImplCopyWith<_$NumberValueImpl> get copyWith =>
      __$$NumberValueImplCopyWithImpl<_$NumberValueImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool value) boolean,
    required TResult Function(double value) number,
    required TResult Function(String value) string,
    required TResult Function(int value) color,
    required TResult Function(VariableAlias value) variableAlias,
  }) {
    return number(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool value)? boolean,
    TResult? Function(double value)? number,
    TResult? Function(String value)? string,
    TResult? Function(int value)? color,
    TResult? Function(VariableAlias value)? variableAlias,
  }) {
    return number?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool value)? boolean,
    TResult Function(double value)? number,
    TResult Function(String value)? string,
    TResult Function(int value)? color,
    TResult Function(VariableAlias value)? variableAlias,
    required TResult orElse(),
  }) {
    if (number != null) {
      return number(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BooleanValue value) boolean,
    required TResult Function(NumberValue value) number,
    required TResult Function(StringValue value) string,
    required TResult Function(ColorValue value) color,
    required TResult Function(VariableAliasValue value) variableAlias,
  }) {
    return number(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BooleanValue value)? boolean,
    TResult? Function(NumberValue value)? number,
    TResult? Function(StringValue value)? string,
    TResult? Function(ColorValue value)? color,
    TResult? Function(VariableAliasValue value)? variableAlias,
  }) {
    return number?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BooleanValue value)? boolean,
    TResult Function(NumberValue value)? number,
    TResult Function(StringValue value)? string,
    TResult Function(ColorValue value)? color,
    TResult Function(VariableAliasValue value)? variableAlias,
    required TResult orElse(),
  }) {
    if (number != null) {
      return number(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NumberValueImplToJson(
      this,
    );
  }
}

abstract class NumberValue implements VariableValue {
  const factory NumberValue(final double value) = _$NumberValueImpl;

  factory NumberValue.fromJson(Map<String, dynamic> json) =
      _$NumberValueImpl.fromJson;

  @override
  double get value;
  @JsonKey(ignore: true)
  _$$NumberValueImplCopyWith<_$NumberValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StringValueImplCopyWith<$Res> {
  factory _$$StringValueImplCopyWith(
          _$StringValueImpl value, $Res Function(_$StringValueImpl) then) =
      __$$StringValueImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$StringValueImplCopyWithImpl<$Res>
    extends _$VariableValueCopyWithImpl<$Res, _$StringValueImpl>
    implements _$$StringValueImplCopyWith<$Res> {
  __$$StringValueImplCopyWithImpl(
      _$StringValueImpl _value, $Res Function(_$StringValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$StringValueImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StringValueImpl implements StringValue {
  const _$StringValueImpl(this.value, {final String? $type})
      : $type = $type ?? 'string';

  factory _$StringValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$StringValueImplFromJson(json);

  @override
  final String value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'VariableValue.string(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StringValueImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StringValueImplCopyWith<_$StringValueImpl> get copyWith =>
      __$$StringValueImplCopyWithImpl<_$StringValueImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool value) boolean,
    required TResult Function(double value) number,
    required TResult Function(String value) string,
    required TResult Function(int value) color,
    required TResult Function(VariableAlias value) variableAlias,
  }) {
    return string(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool value)? boolean,
    TResult? Function(double value)? number,
    TResult? Function(String value)? string,
    TResult? Function(int value)? color,
    TResult? Function(VariableAlias value)? variableAlias,
  }) {
    return string?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool value)? boolean,
    TResult Function(double value)? number,
    TResult Function(String value)? string,
    TResult Function(int value)? color,
    TResult Function(VariableAlias value)? variableAlias,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BooleanValue value) boolean,
    required TResult Function(NumberValue value) number,
    required TResult Function(StringValue value) string,
    required TResult Function(ColorValue value) color,
    required TResult Function(VariableAliasValue value) variableAlias,
  }) {
    return string(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BooleanValue value)? boolean,
    TResult? Function(NumberValue value)? number,
    TResult? Function(StringValue value)? string,
    TResult? Function(ColorValue value)? color,
    TResult? Function(VariableAliasValue value)? variableAlias,
  }) {
    return string?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BooleanValue value)? boolean,
    TResult Function(NumberValue value)? number,
    TResult Function(StringValue value)? string,
    TResult Function(ColorValue value)? color,
    TResult Function(VariableAliasValue value)? variableAlias,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StringValueImplToJson(
      this,
    );
  }
}

abstract class StringValue implements VariableValue {
  const factory StringValue(final String value) = _$StringValueImpl;

  factory StringValue.fromJson(Map<String, dynamic> json) =
      _$StringValueImpl.fromJson;

  @override
  String get value;
  @JsonKey(ignore: true)
  _$$StringValueImplCopyWith<_$StringValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ColorValueImplCopyWith<$Res> {
  factory _$$ColorValueImplCopyWith(
          _$ColorValueImpl value, $Res Function(_$ColorValueImpl) then) =
      __$$ColorValueImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$ColorValueImplCopyWithImpl<$Res>
    extends _$VariableValueCopyWithImpl<$Res, _$ColorValueImpl>
    implements _$$ColorValueImplCopyWith<$Res> {
  __$$ColorValueImplCopyWithImpl(
      _$ColorValueImpl _value, $Res Function(_$ColorValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$ColorValueImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ColorValueImpl implements ColorValue {
  const _$ColorValueImpl(this.value, {final String? $type})
      : $type = $type ?? 'color';

  factory _$ColorValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColorValueImplFromJson(json);

  @override
  final int value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'VariableValue.color(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ColorValueImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ColorValueImplCopyWith<_$ColorValueImpl> get copyWith =>
      __$$ColorValueImplCopyWithImpl<_$ColorValueImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool value) boolean,
    required TResult Function(double value) number,
    required TResult Function(String value) string,
    required TResult Function(int value) color,
    required TResult Function(VariableAlias value) variableAlias,
  }) {
    return color(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool value)? boolean,
    TResult? Function(double value)? number,
    TResult? Function(String value)? string,
    TResult? Function(int value)? color,
    TResult? Function(VariableAlias value)? variableAlias,
  }) {
    return color?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool value)? boolean,
    TResult Function(double value)? number,
    TResult Function(String value)? string,
    TResult Function(int value)? color,
    TResult Function(VariableAlias value)? variableAlias,
    required TResult orElse(),
  }) {
    if (color != null) {
      return color(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BooleanValue value) boolean,
    required TResult Function(NumberValue value) number,
    required TResult Function(StringValue value) string,
    required TResult Function(ColorValue value) color,
    required TResult Function(VariableAliasValue value) variableAlias,
  }) {
    return color(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BooleanValue value)? boolean,
    TResult? Function(NumberValue value)? number,
    TResult? Function(StringValue value)? string,
    TResult? Function(ColorValue value)? color,
    TResult? Function(VariableAliasValue value)? variableAlias,
  }) {
    return color?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BooleanValue value)? boolean,
    TResult Function(NumberValue value)? number,
    TResult Function(StringValue value)? string,
    TResult Function(ColorValue value)? color,
    TResult Function(VariableAliasValue value)? variableAlias,
    required TResult orElse(),
  }) {
    if (color != null) {
      return color(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ColorValueImplToJson(
      this,
    );
  }
}

abstract class ColorValue implements VariableValue {
  const factory ColorValue(final int value) = _$ColorValueImpl;

  factory ColorValue.fromJson(Map<String, dynamic> json) =
      _$ColorValueImpl.fromJson;

  @override
  int get value;
  @JsonKey(ignore: true)
  _$$ColorValueImplCopyWith<_$ColorValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VariableAliasValueImplCopyWith<$Res> {
  factory _$$VariableAliasValueImplCopyWith(_$VariableAliasValueImpl value,
          $Res Function(_$VariableAliasValueImpl) then) =
      __$$VariableAliasValueImplCopyWithImpl<$Res>;
  @useResult
  $Res call({VariableAlias value});

  $VariableAliasCopyWith<$Res> get value;
}

/// @nodoc
class __$$VariableAliasValueImplCopyWithImpl<$Res>
    extends _$VariableValueCopyWithImpl<$Res, _$VariableAliasValueImpl>
    implements _$$VariableAliasValueImplCopyWith<$Res> {
  __$$VariableAliasValueImplCopyWithImpl(_$VariableAliasValueImpl _value,
      $Res Function(_$VariableAliasValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$VariableAliasValueImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as VariableAlias,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $VariableAliasCopyWith<$Res> get value {
    return $VariableAliasCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$VariableAliasValueImpl implements VariableAliasValue {
  const _$VariableAliasValueImpl(this.value, {final String? $type})
      : $type = $type ?? 'variableAlias';

  factory _$VariableAliasValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$VariableAliasValueImplFromJson(json);

  @override
  final VariableAlias value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'VariableValue.variableAlias(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VariableAliasValueImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VariableAliasValueImplCopyWith<_$VariableAliasValueImpl> get copyWith =>
      __$$VariableAliasValueImplCopyWithImpl<_$VariableAliasValueImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool value) boolean,
    required TResult Function(double value) number,
    required TResult Function(String value) string,
    required TResult Function(int value) color,
    required TResult Function(VariableAlias value) variableAlias,
  }) {
    return variableAlias(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool value)? boolean,
    TResult? Function(double value)? number,
    TResult? Function(String value)? string,
    TResult? Function(int value)? color,
    TResult? Function(VariableAlias value)? variableAlias,
  }) {
    return variableAlias?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool value)? boolean,
    TResult Function(double value)? number,
    TResult Function(String value)? string,
    TResult Function(int value)? color,
    TResult Function(VariableAlias value)? variableAlias,
    required TResult orElse(),
  }) {
    if (variableAlias != null) {
      return variableAlias(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BooleanValue value) boolean,
    required TResult Function(NumberValue value) number,
    required TResult Function(StringValue value) string,
    required TResult Function(ColorValue value) color,
    required TResult Function(VariableAliasValue value) variableAlias,
  }) {
    return variableAlias(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BooleanValue value)? boolean,
    TResult? Function(NumberValue value)? number,
    TResult? Function(StringValue value)? string,
    TResult? Function(ColorValue value)? color,
    TResult? Function(VariableAliasValue value)? variableAlias,
  }) {
    return variableAlias?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BooleanValue value)? boolean,
    TResult Function(NumberValue value)? number,
    TResult Function(StringValue value)? string,
    TResult Function(ColorValue value)? color,
    TResult Function(VariableAliasValue value)? variableAlias,
    required TResult orElse(),
  }) {
    if (variableAlias != null) {
      return variableAlias(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$VariableAliasValueImplToJson(
      this,
    );
  }
}

abstract class VariableAliasValue implements VariableValue {
  const factory VariableAliasValue(final VariableAlias value) =
      _$VariableAliasValueImpl;

  factory VariableAliasValue.fromJson(Map<String, dynamic> json) =
      _$VariableAliasValueImpl.fromJson;

  @override
  VariableAlias get value;
  @JsonKey(ignore: true)
  _$$VariableAliasValueImplCopyWith<_$VariableAliasValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
