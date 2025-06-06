// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alias_or.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AliasOr<T> {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AliasOr<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AliasOr<$T>()';
  }
}

/// @nodoc
class $AliasOrCopyWith<T, $Res> {
  $AliasOrCopyWith(AliasOr<T> _, $Res Function(AliasOr<T>) __);
}

/// @nodoc

class AliasData<T> extends AliasOr<T> {
  const AliasData({required this.data}) : super._();

  final T data;

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AliasDataCopyWith<T, AliasData<T>> get copyWith =>
      _$AliasDataCopyWithImpl<T, AliasData<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AliasData<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'AliasOr<$T>.data(data: $data)';
  }
}

/// @nodoc
abstract mixin class $AliasDataCopyWith<T, $Res>
    implements $AliasOrCopyWith<T, $Res> {
  factory $AliasDataCopyWith(
          AliasData<T> value, $Res Function(AliasData<T>) _then) =
      _$AliasDataCopyWithImpl;
  @useResult
  $Res call({T data});
}

/// @nodoc
class _$AliasDataCopyWithImpl<T, $Res> implements $AliasDataCopyWith<T, $Res> {
  _$AliasDataCopyWithImpl(this._self, this._then);

  final AliasData<T> _self;
  final $Res Function(AliasData<T>) _then;

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = freezed,
  }) {
    return _then(AliasData<T>(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class Alias<T> extends AliasOr<T> {
  const Alias({required this.id, required this.aliasOrValue}) : super._();

  final String id;
  final AliasOr<T> aliasOrValue;

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AliasCopyWith<T, Alias<T>> get copyWith =>
      _$AliasCopyWithImpl<T, Alias<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Alias<T> &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.aliasOrValue, aliasOrValue) ||
                other.aliasOrValue == aliasOrValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, aliasOrValue);

  @override
  String toString() {
    return 'AliasOr<$T>.alias(id: $id, aliasOrValue: $aliasOrValue)';
  }
}

/// @nodoc
abstract mixin class $AliasCopyWith<T, $Res>
    implements $AliasOrCopyWith<T, $Res> {
  factory $AliasCopyWith(Alias<T> value, $Res Function(Alias<T>) _then) =
      _$AliasCopyWithImpl;
  @useResult
  $Res call({String id, AliasOr<T> aliasOrValue});

  $AliasOrCopyWith<T, $Res> get aliasOrValue;
}

/// @nodoc
class _$AliasCopyWithImpl<T, $Res> implements $AliasCopyWith<T, $Res> {
  _$AliasCopyWithImpl(this._self, this._then);

  final Alias<T> _self;
  final $Res Function(Alias<T>) _then;

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? aliasOrValue = null,
  }) {
    return _then(Alias<T>(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      aliasOrValue: null == aliasOrValue
          ? _self.aliasOrValue
          : aliasOrValue // ignore: cast_nullable_to_non_nullable
              as AliasOr<T>,
    ));
  }

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AliasOrCopyWith<T, $Res> get aliasOrValue {
    return $AliasOrCopyWith<T, $Res>(_self.aliasOrValue, (value) {
      return _then(_self.copyWith(aliasOrValue: value));
    });
  }
}

/// @nodoc

class AliasUnresolved<T> extends AliasOr<T> {
  const AliasUnresolved({required this.id}) : super._();

  final String id;

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AliasUnresolvedCopyWith<T, AliasUnresolved<T>> get copyWith =>
      _$AliasUnresolvedCopyWithImpl<T, AliasUnresolved<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AliasUnresolved<T> &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'AliasOr<$T>.unresolved(id: $id)';
  }
}

/// @nodoc
abstract mixin class $AliasUnresolvedCopyWith<T, $Res>
    implements $AliasOrCopyWith<T, $Res> {
  factory $AliasUnresolvedCopyWith(
          AliasUnresolved<T> value, $Res Function(AliasUnresolved<T>) _then) =
      _$AliasUnresolvedCopyWithImpl;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$AliasUnresolvedCopyWithImpl<T, $Res>
    implements $AliasUnresolvedCopyWith<T, $Res> {
  _$AliasUnresolvedCopyWithImpl(this._self, this._then);

  final AliasUnresolved<T> _self;
  final $Res Function(AliasUnresolved<T>) _then;

  /// Create a copy of AliasOr
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(AliasUnresolved<T>(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
