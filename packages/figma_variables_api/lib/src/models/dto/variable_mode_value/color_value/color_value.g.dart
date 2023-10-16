// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_value.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ColorValueCWProxy {
  ColorValue r(double r);

  ColorValue g(double g);

  ColorValue b(double b);

  ColorValue a(double a);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ColorValue(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ColorValue(...).copyWith(id: 12, name: "My name")
  /// ````
  ColorValue call({
    double? r,
    double? g,
    double? b,
    double? a,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfColorValue.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfColorValue.copyWith.fieldName(...)`
class _$ColorValueCWProxyImpl implements _$ColorValueCWProxy {
  const _$ColorValueCWProxyImpl(this._value);

  final ColorValue _value;

  @override
  ColorValue r(double r) => this(r: r);

  @override
  ColorValue g(double g) => this(g: g);

  @override
  ColorValue b(double b) => this(b: b);

  @override
  ColorValue a(double a) => this(a: a);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ColorValue(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ColorValue(...).copyWith(id: 12, name: "My name")
  /// ````
  ColorValue call({
    Object? r = const $CopyWithPlaceholder(),
    Object? g = const $CopyWithPlaceholder(),
    Object? b = const $CopyWithPlaceholder(),
    Object? a = const $CopyWithPlaceholder(),
  }) {
    return ColorValue(
      r: r == const $CopyWithPlaceholder() || r == null
          ? _value.r
          // ignore: cast_nullable_to_non_nullable
          : r as double,
      g: g == const $CopyWithPlaceholder() || g == null
          ? _value.g
          // ignore: cast_nullable_to_non_nullable
          : g as double,
      b: b == const $CopyWithPlaceholder() || b == null
          ? _value.b
          // ignore: cast_nullable_to_non_nullable
          : b as double,
      a: a == const $CopyWithPlaceholder() || a == null
          ? _value.a
          // ignore: cast_nullable_to_non_nullable
          : a as double,
    );
  }
}

extension $ColorValueCopyWith on ColorValue {
  /// Returns a callable class that can be used as follows: `instanceOfColorValue.copyWith(...)` or like so:`instanceOfColorValue.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ColorValueCWProxy get copyWith => _$ColorValueCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorValue _$ColorValueFromJson(Map<String, dynamic> json) => ColorValue(
      r: (json['r'] as num).toDouble(),
      g: (json['g'] as num).toDouble(),
      b: (json['b'] as num).toDouble(),
      a: (json['a'] as num).toDouble(),
    );

Map<String, dynamic> _$ColorValueToJson(ColorValue instance) =>
    <String, dynamic>{
      'r': instance.r,
      'g': instance.g,
      'b': instance.b,
      'a': instance.a,
    };
