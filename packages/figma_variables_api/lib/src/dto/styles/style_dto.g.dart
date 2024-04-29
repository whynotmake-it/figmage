// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StyleDtoCWProxy {
  StyleDto nodeId(String? nodeId);

  StyleDto key(String? key);

  StyleDto name(String? name);

  StyleDto description(String? description);

  StyleDto type(StyleType? type);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StyleDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StyleDto(...).copyWith(id: 12, name: "My name")
  /// ````
  StyleDto call({
    String? nodeId,
    String? key,
    String? name,
    String? description,
    StyleType? type,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStyleDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStyleDto.copyWith.fieldName(...)`
class _$StyleDtoCWProxyImpl implements _$StyleDtoCWProxy {
  const _$StyleDtoCWProxyImpl(this._value);

  final StyleDto _value;

  @override
  StyleDto nodeId(String? nodeId) => this(nodeId: nodeId);

  @override
  StyleDto key(String? key) => this(key: key);

  @override
  StyleDto name(String? name) => this(name: name);

  @override
  StyleDto description(String? description) => this(description: description);

  @override
  StyleDto type(StyleType? type) => this(type: type);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StyleDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StyleDto(...).copyWith(id: 12, name: "My name")
  /// ````
  StyleDto call({
    Object? nodeId = const $CopyWithPlaceholder(),
    Object? key = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
  }) {
    return StyleDto(
      nodeId: nodeId == const $CopyWithPlaceholder()
          ? _value.nodeId
          // ignore: cast_nullable_to_non_nullable
          : nodeId as String?,
      key: key == const $CopyWithPlaceholder()
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as StyleType?,
    );
  }
}

extension $StyleDtoCopyWith on StyleDto {
  /// Returns a callable class that can be used as follows: `instanceOfStyleDto.copyWith(...)` or like so:`instanceOfStyleDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StyleDtoCWProxy get copyWith => _$StyleDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyleDto _$StyleDtoFromJson(Map<String, dynamic> json) => StyleDto(
      nodeId: json['node_id'] as String?,
      key: json['key'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      type: $enumDecodeNullable(_$StyleTypeEnumMap, json['style_type']),
    );

Map<String, dynamic> _$StyleDtoToJson(StyleDto instance) => <String, dynamic>{
      'node_id': instance.nodeId,
      'key': instance.key,
      'name': instance.name,
      'description': instance.description,
      'style_type': _$StyleTypeEnumMap[instance.type],
    };

const _$StyleTypeEnumMap = {
  StyleType.fill: 'FILL',
  StyleType.text: 'TEXT',
  StyleType.effect: 'EFFECT',
  StyleType.grid: 'GRID',
};
