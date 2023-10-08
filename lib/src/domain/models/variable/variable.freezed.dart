// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'variable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Variable _$VariableFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'boolean':
      return BooleanVariable.fromJson(json);
    case 'float':
      return FloatVariable.fromJson(json);
    case 'color':
      return ColorVariable.fromJson(json);
    case 'string':
      return StringVariable.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Variable',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Variable {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get variableCollectionId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _boolMap)
  Map<String, VariableValue> get valuesByMode =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)
        boolean,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)
        float,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)
        color,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)
        string,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)?
        boolean,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)?
        float,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)?
        color,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)?
        string,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)?
        boolean,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)?
        float,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)?
        color,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)?
        string,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BooleanVariable value) boolean,
    required TResult Function(FloatVariable value) float,
    required TResult Function(ColorVariable value) color,
    required TResult Function(StringVariable value) string,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BooleanVariable value)? boolean,
    TResult? Function(FloatVariable value)? float,
    TResult? Function(ColorVariable value)? color,
    TResult? Function(StringVariable value)? string,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BooleanVariable value)? boolean,
    TResult Function(FloatVariable value)? float,
    TResult Function(ColorVariable value)? color,
    TResult Function(StringVariable value)? string,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VariableCopyWith<Variable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariableCopyWith<$Res> {
  factory $VariableCopyWith(Variable value, $Res Function(Variable) then) =
      _$VariableCopyWithImpl<$Res, Variable>;
  @useResult
  $Res call(
      {String id,
      String name,
      String key,
      String variableCollectionId,
      @JsonKey(fromJson: _boolMap) Map<String, VariableValue> valuesByMode});
}

/// @nodoc
class _$VariableCopyWithImpl<$Res, $Val extends Variable>
    implements $VariableCopyWith<$Res> {
  _$VariableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? key = null,
    Object? variableCollectionId = null,
    Object? valuesByMode = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      variableCollectionId: null == variableCollectionId
          ? _value.variableCollectionId
          : variableCollectionId // ignore: cast_nullable_to_non_nullable
              as String,
      valuesByMode: null == valuesByMode
          ? _value.valuesByMode
          : valuesByMode // ignore: cast_nullable_to_non_nullable
              as Map<String, VariableValue>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BooleanVariableImplCopyWith<$Res>
    implements $VariableCopyWith<$Res> {
  factory _$$BooleanVariableImplCopyWith(_$BooleanVariableImpl value,
          $Res Function(_$BooleanVariableImpl) then) =
      __$$BooleanVariableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String key,
      String variableCollectionId,
      @JsonKey(fromJson: _boolMap) Map<String, VariableValue> valuesByMode});
}

/// @nodoc
class __$$BooleanVariableImplCopyWithImpl<$Res>
    extends _$VariableCopyWithImpl<$Res, _$BooleanVariableImpl>
    implements _$$BooleanVariableImplCopyWith<$Res> {
  __$$BooleanVariableImplCopyWithImpl(
      _$BooleanVariableImpl _value, $Res Function(_$BooleanVariableImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? key = null,
    Object? variableCollectionId = null,
    Object? valuesByMode = null,
  }) {
    return _then(_$BooleanVariableImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      variableCollectionId: null == variableCollectionId
          ? _value.variableCollectionId
          : variableCollectionId // ignore: cast_nullable_to_non_nullable
              as String,
      valuesByMode: null == valuesByMode
          ? _value._valuesByMode
          : valuesByMode // ignore: cast_nullable_to_non_nullable
              as Map<String, VariableValue>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BooleanVariableImpl implements BooleanVariable {
  _$BooleanVariableImpl(
      {required this.id,
      required this.name,
      required this.key,
      required this.variableCollectionId,
      @JsonKey(fromJson: _boolMap)
      required final Map<String, VariableValue> valuesByMode,
      final String? $type})
      : _valuesByMode = valuesByMode,
        $type = $type ?? 'boolean';

  factory _$BooleanVariableImpl.fromJson(Map<String, dynamic> json) =>
      _$$BooleanVariableImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String key;
  @override
  final String variableCollectionId;
  final Map<String, VariableValue> _valuesByMode;
  @override
  @JsonKey(fromJson: _boolMap)
  Map<String, VariableValue> get valuesByMode {
    if (_valuesByMode is EqualUnmodifiableMapView) return _valuesByMode;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_valuesByMode);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Variable.boolean(id: $id, name: $name, key: $key, variableCollectionId: $variableCollectionId, valuesByMode: $valuesByMode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BooleanVariableImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.variableCollectionId, variableCollectionId) ||
                other.variableCollectionId == variableCollectionId) &&
            const DeepCollectionEquality()
                .equals(other._valuesByMode, _valuesByMode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, key,
      variableCollectionId, const DeepCollectionEquality().hash(_valuesByMode));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BooleanVariableImplCopyWith<_$BooleanVariableImpl> get copyWith =>
      __$$BooleanVariableImplCopyWithImpl<_$BooleanVariableImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)
        boolean,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)
        float,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)
        color,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)
        string,
  }) {
    return boolean(id, name, key, variableCollectionId, valuesByMode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)?
        boolean,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)?
        float,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)?
        color,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)?
        string,
  }) {
    return boolean?.call(id, name, key, variableCollectionId, valuesByMode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)?
        boolean,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)?
        float,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)?
        color,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)?
        string,
    required TResult orElse(),
  }) {
    if (boolean != null) {
      return boolean(id, name, key, variableCollectionId, valuesByMode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BooleanVariable value) boolean,
    required TResult Function(FloatVariable value) float,
    required TResult Function(ColorVariable value) color,
    required TResult Function(StringVariable value) string,
  }) {
    return boolean(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BooleanVariable value)? boolean,
    TResult? Function(FloatVariable value)? float,
    TResult? Function(ColorVariable value)? color,
    TResult? Function(StringVariable value)? string,
  }) {
    return boolean?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BooleanVariable value)? boolean,
    TResult Function(FloatVariable value)? float,
    TResult Function(ColorVariable value)? color,
    TResult Function(StringVariable value)? string,
    required TResult orElse(),
  }) {
    if (boolean != null) {
      return boolean(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BooleanVariableImplToJson(
      this,
    );
  }
}

abstract class BooleanVariable implements Variable {
  factory BooleanVariable(
          {required final String id,
          required final String name,
          required final String key,
          required final String variableCollectionId,
          @JsonKey(fromJson: _boolMap)
          required final Map<String, VariableValue> valuesByMode}) =
      _$BooleanVariableImpl;

  factory BooleanVariable.fromJson(Map<String, dynamic> json) =
      _$BooleanVariableImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get key;
  @override
  String get variableCollectionId;
  @override
  @JsonKey(fromJson: _boolMap)
  Map<String, VariableValue> get valuesByMode;
  @override
  @JsonKey(ignore: true)
  _$$BooleanVariableImplCopyWith<_$BooleanVariableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FloatVariableImplCopyWith<$Res>
    implements $VariableCopyWith<$Res> {
  factory _$$FloatVariableImplCopyWith(
          _$FloatVariableImpl value, $Res Function(_$FloatVariableImpl) then) =
      __$$FloatVariableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String key,
      String variableCollectionId,
      @JsonKey(fromJson: _floatMap) Map<String, VariableValue> valuesByMode});
}

/// @nodoc
class __$$FloatVariableImplCopyWithImpl<$Res>
    extends _$VariableCopyWithImpl<$Res, _$FloatVariableImpl>
    implements _$$FloatVariableImplCopyWith<$Res> {
  __$$FloatVariableImplCopyWithImpl(
      _$FloatVariableImpl _value, $Res Function(_$FloatVariableImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? key = null,
    Object? variableCollectionId = null,
    Object? valuesByMode = null,
  }) {
    return _then(_$FloatVariableImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      variableCollectionId: null == variableCollectionId
          ? _value.variableCollectionId
          : variableCollectionId // ignore: cast_nullable_to_non_nullable
              as String,
      valuesByMode: null == valuesByMode
          ? _value._valuesByMode
          : valuesByMode // ignore: cast_nullable_to_non_nullable
              as Map<String, VariableValue>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FloatVariableImpl implements FloatVariable {
  _$FloatVariableImpl(
      {required this.id,
      required this.name,
      required this.key,
      required this.variableCollectionId,
      @JsonKey(fromJson: _floatMap)
      required final Map<String, VariableValue> valuesByMode,
      final String? $type})
      : _valuesByMode = valuesByMode,
        $type = $type ?? 'float';

  factory _$FloatVariableImpl.fromJson(Map<String, dynamic> json) =>
      _$$FloatVariableImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String key;
  @override
  final String variableCollectionId;
  final Map<String, VariableValue> _valuesByMode;
  @override
  @JsonKey(fromJson: _floatMap)
  Map<String, VariableValue> get valuesByMode {
    if (_valuesByMode is EqualUnmodifiableMapView) return _valuesByMode;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_valuesByMode);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Variable.float(id: $id, name: $name, key: $key, variableCollectionId: $variableCollectionId, valuesByMode: $valuesByMode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FloatVariableImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.variableCollectionId, variableCollectionId) ||
                other.variableCollectionId == variableCollectionId) &&
            const DeepCollectionEquality()
                .equals(other._valuesByMode, _valuesByMode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, key,
      variableCollectionId, const DeepCollectionEquality().hash(_valuesByMode));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FloatVariableImplCopyWith<_$FloatVariableImpl> get copyWith =>
      __$$FloatVariableImplCopyWithImpl<_$FloatVariableImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)
        boolean,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)
        float,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)
        color,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)
        string,
  }) {
    return float(id, name, key, variableCollectionId, valuesByMode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)?
        boolean,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)?
        float,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)?
        color,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)?
        string,
  }) {
    return float?.call(id, name, key, variableCollectionId, valuesByMode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)?
        boolean,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)?
        float,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)?
        color,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)?
        string,
    required TResult orElse(),
  }) {
    if (float != null) {
      return float(id, name, key, variableCollectionId, valuesByMode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BooleanVariable value) boolean,
    required TResult Function(FloatVariable value) float,
    required TResult Function(ColorVariable value) color,
    required TResult Function(StringVariable value) string,
  }) {
    return float(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BooleanVariable value)? boolean,
    TResult? Function(FloatVariable value)? float,
    TResult? Function(ColorVariable value)? color,
    TResult? Function(StringVariable value)? string,
  }) {
    return float?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BooleanVariable value)? boolean,
    TResult Function(FloatVariable value)? float,
    TResult Function(ColorVariable value)? color,
    TResult Function(StringVariable value)? string,
    required TResult orElse(),
  }) {
    if (float != null) {
      return float(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FloatVariableImplToJson(
      this,
    );
  }
}

abstract class FloatVariable implements Variable {
  factory FloatVariable(
          {required final String id,
          required final String name,
          required final String key,
          required final String variableCollectionId,
          @JsonKey(fromJson: _floatMap)
          required final Map<String, VariableValue> valuesByMode}) =
      _$FloatVariableImpl;

  factory FloatVariable.fromJson(Map<String, dynamic> json) =
      _$FloatVariableImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get key;
  @override
  String get variableCollectionId;
  @override
  @JsonKey(fromJson: _floatMap)
  Map<String, VariableValue> get valuesByMode;
  @override
  @JsonKey(ignore: true)
  _$$FloatVariableImplCopyWith<_$FloatVariableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ColorVariableImplCopyWith<$Res>
    implements $VariableCopyWith<$Res> {
  factory _$$ColorVariableImplCopyWith(
          _$ColorVariableImpl value, $Res Function(_$ColorVariableImpl) then) =
      __$$ColorVariableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String key,
      String variableCollectionId,
      @JsonKey(fromJson: _colorMap) Map<String, VariableValue> valuesByMode});
}

/// @nodoc
class __$$ColorVariableImplCopyWithImpl<$Res>
    extends _$VariableCopyWithImpl<$Res, _$ColorVariableImpl>
    implements _$$ColorVariableImplCopyWith<$Res> {
  __$$ColorVariableImplCopyWithImpl(
      _$ColorVariableImpl _value, $Res Function(_$ColorVariableImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? key = null,
    Object? variableCollectionId = null,
    Object? valuesByMode = null,
  }) {
    return _then(_$ColorVariableImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      variableCollectionId: null == variableCollectionId
          ? _value.variableCollectionId
          : variableCollectionId // ignore: cast_nullable_to_non_nullable
              as String,
      valuesByMode: null == valuesByMode
          ? _value._valuesByMode
          : valuesByMode // ignore: cast_nullable_to_non_nullable
              as Map<String, VariableValue>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ColorVariableImpl implements ColorVariable {
  _$ColorVariableImpl(
      {required this.id,
      required this.name,
      required this.key,
      required this.variableCollectionId,
      @JsonKey(fromJson: _colorMap)
      required final Map<String, VariableValue> valuesByMode,
      final String? $type})
      : _valuesByMode = valuesByMode,
        $type = $type ?? 'color';

  factory _$ColorVariableImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColorVariableImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String key;
  @override
  final String variableCollectionId;
  final Map<String, VariableValue> _valuesByMode;
  @override
  @JsonKey(fromJson: _colorMap)
  Map<String, VariableValue> get valuesByMode {
    if (_valuesByMode is EqualUnmodifiableMapView) return _valuesByMode;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_valuesByMode);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Variable.color(id: $id, name: $name, key: $key, variableCollectionId: $variableCollectionId, valuesByMode: $valuesByMode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ColorVariableImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.variableCollectionId, variableCollectionId) ||
                other.variableCollectionId == variableCollectionId) &&
            const DeepCollectionEquality()
                .equals(other._valuesByMode, _valuesByMode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, key,
      variableCollectionId, const DeepCollectionEquality().hash(_valuesByMode));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ColorVariableImplCopyWith<_$ColorVariableImpl> get copyWith =>
      __$$ColorVariableImplCopyWithImpl<_$ColorVariableImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)
        boolean,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)
        float,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)
        color,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)
        string,
  }) {
    return color(id, name, key, variableCollectionId, valuesByMode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)?
        boolean,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)?
        float,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)?
        color,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)?
        string,
  }) {
    return color?.call(id, name, key, variableCollectionId, valuesByMode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)?
        boolean,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)?
        float,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)?
        color,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)?
        string,
    required TResult orElse(),
  }) {
    if (color != null) {
      return color(id, name, key, variableCollectionId, valuesByMode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BooleanVariable value) boolean,
    required TResult Function(FloatVariable value) float,
    required TResult Function(ColorVariable value) color,
    required TResult Function(StringVariable value) string,
  }) {
    return color(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BooleanVariable value)? boolean,
    TResult? Function(FloatVariable value)? float,
    TResult? Function(ColorVariable value)? color,
    TResult? Function(StringVariable value)? string,
  }) {
    return color?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BooleanVariable value)? boolean,
    TResult Function(FloatVariable value)? float,
    TResult Function(ColorVariable value)? color,
    TResult Function(StringVariable value)? string,
    required TResult orElse(),
  }) {
    if (color != null) {
      return color(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ColorVariableImplToJson(
      this,
    );
  }
}

abstract class ColorVariable implements Variable {
  factory ColorVariable(
          {required final String id,
          required final String name,
          required final String key,
          required final String variableCollectionId,
          @JsonKey(fromJson: _colorMap)
          required final Map<String, VariableValue> valuesByMode}) =
      _$ColorVariableImpl;

  factory ColorVariable.fromJson(Map<String, dynamic> json) =
      _$ColorVariableImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get key;
  @override
  String get variableCollectionId;
  @override
  @JsonKey(fromJson: _colorMap)
  Map<String, VariableValue> get valuesByMode;
  @override
  @JsonKey(ignore: true)
  _$$ColorVariableImplCopyWith<_$ColorVariableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StringVariableImplCopyWith<$Res>
    implements $VariableCopyWith<$Res> {
  factory _$$StringVariableImplCopyWith(_$StringVariableImpl value,
          $Res Function(_$StringVariableImpl) then) =
      __$$StringVariableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String key,
      String variableCollectionId,
      @JsonKey(fromJson: _stringMap) Map<String, VariableValue> valuesByMode});
}

/// @nodoc
class __$$StringVariableImplCopyWithImpl<$Res>
    extends _$VariableCopyWithImpl<$Res, _$StringVariableImpl>
    implements _$$StringVariableImplCopyWith<$Res> {
  __$$StringVariableImplCopyWithImpl(
      _$StringVariableImpl _value, $Res Function(_$StringVariableImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? key = null,
    Object? variableCollectionId = null,
    Object? valuesByMode = null,
  }) {
    return _then(_$StringVariableImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      variableCollectionId: null == variableCollectionId
          ? _value.variableCollectionId
          : variableCollectionId // ignore: cast_nullable_to_non_nullable
              as String,
      valuesByMode: null == valuesByMode
          ? _value._valuesByMode
          : valuesByMode // ignore: cast_nullable_to_non_nullable
              as Map<String, VariableValue>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StringVariableImpl implements StringVariable {
  _$StringVariableImpl(
      {required this.id,
      required this.name,
      required this.key,
      required this.variableCollectionId,
      @JsonKey(fromJson: _stringMap)
      required final Map<String, VariableValue> valuesByMode,
      final String? $type})
      : _valuesByMode = valuesByMode,
        $type = $type ?? 'string';

  factory _$StringVariableImpl.fromJson(Map<String, dynamic> json) =>
      _$$StringVariableImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String key;
  @override
  final String variableCollectionId;
  final Map<String, VariableValue> _valuesByMode;
  @override
  @JsonKey(fromJson: _stringMap)
  Map<String, VariableValue> get valuesByMode {
    if (_valuesByMode is EqualUnmodifiableMapView) return _valuesByMode;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_valuesByMode);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Variable.string(id: $id, name: $name, key: $key, variableCollectionId: $variableCollectionId, valuesByMode: $valuesByMode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StringVariableImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.variableCollectionId, variableCollectionId) ||
                other.variableCollectionId == variableCollectionId) &&
            const DeepCollectionEquality()
                .equals(other._valuesByMode, _valuesByMode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, key,
      variableCollectionId, const DeepCollectionEquality().hash(_valuesByMode));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StringVariableImplCopyWith<_$StringVariableImpl> get copyWith =>
      __$$StringVariableImplCopyWithImpl<_$StringVariableImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)
        boolean,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)
        float,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)
        color,
    required TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)
        string,
  }) {
    return string(id, name, key, variableCollectionId, valuesByMode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)?
        boolean,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)?
        float,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)?
        color,
    TResult? Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)?
        string,
  }) {
    return string?.call(id, name, key, variableCollectionId, valuesByMode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _boolMap)
            Map<String, VariableValue> valuesByMode)?
        boolean,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _floatMap)
            Map<String, VariableValue> valuesByMode)?
        float,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _colorMap)
            Map<String, VariableValue> valuesByMode)?
        color,
    TResult Function(
            String id,
            String name,
            String key,
            String variableCollectionId,
            @JsonKey(fromJson: _stringMap)
            Map<String, VariableValue> valuesByMode)?
        string,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(id, name, key, variableCollectionId, valuesByMode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BooleanVariable value) boolean,
    required TResult Function(FloatVariable value) float,
    required TResult Function(ColorVariable value) color,
    required TResult Function(StringVariable value) string,
  }) {
    return string(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BooleanVariable value)? boolean,
    TResult? Function(FloatVariable value)? float,
    TResult? Function(ColorVariable value)? color,
    TResult? Function(StringVariable value)? string,
  }) {
    return string?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BooleanVariable value)? boolean,
    TResult Function(FloatVariable value)? float,
    TResult Function(ColorVariable value)? color,
    TResult Function(StringVariable value)? string,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StringVariableImplToJson(
      this,
    );
  }
}

abstract class StringVariable implements Variable {
  factory StringVariable(
          {required final String id,
          required final String name,
          required final String key,
          required final String variableCollectionId,
          @JsonKey(fromJson: _stringMap)
          required final Map<String, VariableValue> valuesByMode}) =
      _$StringVariableImpl;

  factory StringVariable.fromJson(Map<String, dynamic> json) =
      _$StringVariableImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get key;
  @override
  String get variableCollectionId;
  @override
  @JsonKey(fromJson: _stringMap)
  Map<String, VariableValue> get valuesByMode;
  @override
  @JsonKey(ignore: true)
  _$$StringVariableImplCopyWith<_$StringVariableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
