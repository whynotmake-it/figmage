// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'variable_alias.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VariableAlias _$VariableAliasFromJson(Map<String, dynamic> json) {
  return _VariableAlias.fromJson(json);
}

/// @nodoc
mixin _$VariableAlias {
  String get type => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VariableAliasCopyWith<VariableAlias> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariableAliasCopyWith<$Res> {
  factory $VariableAliasCopyWith(
          VariableAlias value, $Res Function(VariableAlias) then) =
      _$VariableAliasCopyWithImpl<$Res, VariableAlias>;
  @useResult
  $Res call({String type, String id});
}

/// @nodoc
class _$VariableAliasCopyWithImpl<$Res, $Val extends VariableAlias>
    implements $VariableAliasCopyWith<$Res> {
  _$VariableAliasCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VariableAliasImplCopyWith<$Res>
    implements $VariableAliasCopyWith<$Res> {
  factory _$$VariableAliasImplCopyWith(
          _$VariableAliasImpl value, $Res Function(_$VariableAliasImpl) then) =
      __$$VariableAliasImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String id});
}

/// @nodoc
class __$$VariableAliasImplCopyWithImpl<$Res>
    extends _$VariableAliasCopyWithImpl<$Res, _$VariableAliasImpl>
    implements _$$VariableAliasImplCopyWith<$Res> {
  __$$VariableAliasImplCopyWithImpl(
      _$VariableAliasImpl _value, $Res Function(_$VariableAliasImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
  }) {
    return _then(_$VariableAliasImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VariableAliasImpl implements _VariableAlias {
  const _$VariableAliasImpl({required this.type, required this.id});

  factory _$VariableAliasImpl.fromJson(Map<String, dynamic> json) =>
      _$$VariableAliasImplFromJson(json);

  @override
  final String type;
  @override
  final String id;

  @override
  String toString() {
    return 'VariableAlias(type: $type, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VariableAliasImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VariableAliasImplCopyWith<_$VariableAliasImpl> get copyWith =>
      __$$VariableAliasImplCopyWithImpl<_$VariableAliasImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VariableAliasImplToJson(
      this,
    );
  }
}

abstract class _VariableAlias implements VariableAlias {
  const factory _VariableAlias(
      {required final String type,
      required final String id}) = _$VariableAliasImpl;

  factory _VariableAlias.fromJson(Map<String, dynamic> json) =
      _$VariableAliasImpl.fromJson;

  @override
  String get type;
  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$VariableAliasImplCopyWith<_$VariableAliasImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
