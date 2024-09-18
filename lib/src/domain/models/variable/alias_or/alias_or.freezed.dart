// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alias_or.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AliasOr<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) data,
    required TResult Function(String id, AliasOr<T> aliasOrValue) alias,
    required TResult Function(String id) unresolved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? data,
    TResult? Function(String id, AliasOr<T> aliasOrValue)? alias,
    TResult? Function(String id)? unresolved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? data,
    TResult Function(String id, AliasOr<T> aliasOrValue)? alias,
    TResult Function(String id)? unresolved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AliasData<T> value) data,
    required TResult Function(Alias<T> value) alias,
    required TResult Function(AliasUnresolved<T> value) unresolved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AliasData<T> value)? data,
    TResult? Function(Alias<T> value)? alias,
    TResult? Function(AliasUnresolved<T> value)? unresolved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AliasData<T> value)? data,
    TResult Function(Alias<T> value)? alias,
    TResult Function(AliasUnresolved<T> value)? unresolved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AliasOrCopyWith<T, $Res> {
  factory $AliasOrCopyWith(AliasOr<T> value, $Res Function(AliasOr<T>) then) =
      _$AliasOrCopyWithImpl<T, $Res, AliasOr<T>>;
}

/// @nodoc
class _$AliasOrCopyWithImpl<T, $Res, $Val extends AliasOr<T>>
    implements $AliasOrCopyWith<T, $Res> {
  _$AliasOrCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AliasDataImplCopyWith<T, $Res> {
  factory _$$AliasDataImplCopyWith(
          _$AliasDataImpl<T> value, $Res Function(_$AliasDataImpl<T>) then) =
      __$$AliasDataImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$AliasDataImplCopyWithImpl<T, $Res>
    extends _$AliasOrCopyWithImpl<T, $Res, _$AliasDataImpl<T>>
    implements _$$AliasDataImplCopyWith<T, $Res> {
  __$$AliasDataImplCopyWithImpl(
      _$AliasDataImpl<T> _value, $Res Function(_$AliasDataImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$AliasDataImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$AliasDataImpl<T> extends AliasData<T> {
  const _$AliasDataImpl({required this.data}) : super._();

  @override
  final T data;

  @override
  String toString() {
    return 'AliasOr<$T>.data(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AliasDataImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AliasDataImplCopyWith<T, _$AliasDataImpl<T>> get copyWith =>
      __$$AliasDataImplCopyWithImpl<T, _$AliasDataImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) data,
    required TResult Function(String id, AliasOr<T> aliasOrValue) alias,
    required TResult Function(String id) unresolved,
  }) {
    return data(this.data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? data,
    TResult? Function(String id, AliasOr<T> aliasOrValue)? alias,
    TResult? Function(String id)? unresolved,
  }) {
    return data?.call(this.data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? data,
    TResult Function(String id, AliasOr<T> aliasOrValue)? alias,
    TResult Function(String id)? unresolved,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this.data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AliasData<T> value) data,
    required TResult Function(Alias<T> value) alias,
    required TResult Function(AliasUnresolved<T> value) unresolved,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AliasData<T> value)? data,
    TResult? Function(Alias<T> value)? alias,
    TResult? Function(AliasUnresolved<T> value)? unresolved,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AliasData<T> value)? data,
    TResult Function(Alias<T> value)? alias,
    TResult Function(AliasUnresolved<T> value)? unresolved,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class AliasData<T> extends AliasOr<T> {
  const factory AliasData({required final T data}) = _$AliasDataImpl<T>;
  const AliasData._() : super._();

  T get data;

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AliasDataImplCopyWith<T, _$AliasDataImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AliasImplCopyWith<T, $Res> {
  factory _$$AliasImplCopyWith(
          _$AliasImpl<T> value, $Res Function(_$AliasImpl<T>) then) =
      __$$AliasImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String id, AliasOr<T> aliasOrValue});

  $AliasOrCopyWith<T, $Res> get aliasOrValue;
}

/// @nodoc
class __$$AliasImplCopyWithImpl<T, $Res>
    extends _$AliasOrCopyWithImpl<T, $Res, _$AliasImpl<T>>
    implements _$$AliasImplCopyWith<T, $Res> {
  __$$AliasImplCopyWithImpl(
      _$AliasImpl<T> _value, $Res Function(_$AliasImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? aliasOrValue = null,
  }) {
    return _then(_$AliasImpl<T>(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      aliasOrValue: null == aliasOrValue
          ? _value.aliasOrValue
          : aliasOrValue // ignore: cast_nullable_to_non_nullable
              as AliasOr<T>,
    ));
  }

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AliasOrCopyWith<T, $Res> get aliasOrValue {
    return $AliasOrCopyWith<T, $Res>(_value.aliasOrValue, (value) {
      return _then(_value.copyWith(aliasOrValue: value));
    });
  }
}

/// @nodoc

class _$AliasImpl<T> extends Alias<T> {
  const _$AliasImpl({required this.id, required this.aliasOrValue}) : super._();

  @override
  final String id;
  @override
  final AliasOr<T> aliasOrValue;

  @override
  String toString() {
    return 'AliasOr<$T>.alias(id: $id, aliasOrValue: $aliasOrValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AliasImpl<T> &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.aliasOrValue, aliasOrValue) ||
                other.aliasOrValue == aliasOrValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, aliasOrValue);

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AliasImplCopyWith<T, _$AliasImpl<T>> get copyWith =>
      __$$AliasImplCopyWithImpl<T, _$AliasImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) data,
    required TResult Function(String id, AliasOr<T> aliasOrValue) alias,
    required TResult Function(String id) unresolved,
  }) {
    return alias(id, aliasOrValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? data,
    TResult? Function(String id, AliasOr<T> aliasOrValue)? alias,
    TResult? Function(String id)? unresolved,
  }) {
    return alias?.call(id, aliasOrValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? data,
    TResult Function(String id, AliasOr<T> aliasOrValue)? alias,
    TResult Function(String id)? unresolved,
    required TResult orElse(),
  }) {
    if (alias != null) {
      return alias(id, aliasOrValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AliasData<T> value) data,
    required TResult Function(Alias<T> value) alias,
    required TResult Function(AliasUnresolved<T> value) unresolved,
  }) {
    return alias(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AliasData<T> value)? data,
    TResult? Function(Alias<T> value)? alias,
    TResult? Function(AliasUnresolved<T> value)? unresolved,
  }) {
    return alias?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AliasData<T> value)? data,
    TResult Function(Alias<T> value)? alias,
    TResult Function(AliasUnresolved<T> value)? unresolved,
    required TResult orElse(),
  }) {
    if (alias != null) {
      return alias(this);
    }
    return orElse();
  }
}

abstract class Alias<T> extends AliasOr<T> {
  const factory Alias(
      {required final String id,
      required final AliasOr<T> aliasOrValue}) = _$AliasImpl<T>;
  const Alias._() : super._();

  String get id;
  AliasOr<T> get aliasOrValue;

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AliasImplCopyWith<T, _$AliasImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AliasUnresolvedImplCopyWith<T, $Res> {
  factory _$$AliasUnresolvedImplCopyWith(_$AliasUnresolvedImpl<T> value,
          $Res Function(_$AliasUnresolvedImpl<T>) then) =
      __$$AliasUnresolvedImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$AliasUnresolvedImplCopyWithImpl<T, $Res>
    extends _$AliasOrCopyWithImpl<T, $Res, _$AliasUnresolvedImpl<T>>
    implements _$$AliasUnresolvedImplCopyWith<T, $Res> {
  __$$AliasUnresolvedImplCopyWithImpl(_$AliasUnresolvedImpl<T> _value,
      $Res Function(_$AliasUnresolvedImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$AliasUnresolvedImpl<T>(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AliasUnresolvedImpl<T> extends AliasUnresolved<T> {
  const _$AliasUnresolvedImpl({required this.id}) : super._();

  @override
  final String id;

  @override
  String toString() {
    return 'AliasOr<$T>.unresolved(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AliasUnresolvedImpl<T> &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AliasUnresolvedImplCopyWith<T, _$AliasUnresolvedImpl<T>> get copyWith =>
      __$$AliasUnresolvedImplCopyWithImpl<T, _$AliasUnresolvedImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) data,
    required TResult Function(String id, AliasOr<T> aliasOrValue) alias,
    required TResult Function(String id) unresolved,
  }) {
    return unresolved(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? data,
    TResult? Function(String id, AliasOr<T> aliasOrValue)? alias,
    TResult? Function(String id)? unresolved,
  }) {
    return unresolved?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? data,
    TResult Function(String id, AliasOr<T> aliasOrValue)? alias,
    TResult Function(String id)? unresolved,
    required TResult orElse(),
  }) {
    if (unresolved != null) {
      return unresolved(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AliasData<T> value) data,
    required TResult Function(Alias<T> value) alias,
    required TResult Function(AliasUnresolved<T> value) unresolved,
  }) {
    return unresolved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AliasData<T> value)? data,
    TResult? Function(Alias<T> value)? alias,
    TResult? Function(AliasUnresolved<T> value)? unresolved,
  }) {
    return unresolved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AliasData<T> value)? data,
    TResult Function(Alias<T> value)? alias,
    TResult Function(AliasUnresolved<T> value)? unresolved,
    required TResult orElse(),
  }) {
    if (unresolved != null) {
      return unresolved(this);
    }
    return orElse();
  }
}

abstract class AliasUnresolved<T> extends AliasOr<T> {
  const factory AliasUnresolved({required final String id}) =
      _$AliasUnresolvedImpl<T>;
  const AliasUnresolved._() : super._();

  String get id;

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AliasUnresolvedImplCopyWith<T, _$AliasUnresolvedImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
