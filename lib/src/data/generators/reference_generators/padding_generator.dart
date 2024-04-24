import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/reference_generators/reference_theme_class_generator.dart';
import 'package:figmage/src/data/generators/theme_extension_generators/mode_theme_extension_generator.dart';
import 'package:figmage/src/data/util/converters/string_dart_conversion_x.dart';

/// {@template padding_generator}
/// A generator for a padding class.
/// {@endtemplate}
class PaddingGenerator extends ReferenceThemeClassGenerator {
  /// {@macro padding_generator_template}
  PaddingGenerator({
    required super.className,
    required super.fromClass,
    required super.valueNames,
    super.buildContextExtensionNullable = false,
  });

  final _edgeInsetsReference =
      refer('EdgeInsets', 'package:flutter/painting.dart');

  @override
  List<Method> buildGetters({
    required String fromClassField,
    required String valueFieldName,
    required bool isNullable,
  }) {
    return [
      for (final type in _EdgeInsetsType.values)
        Method(
          (m) {
            m
              ..name = '$valueFieldName${type.name.toTitleCase()}'
              ..returns = isNullable
                  ? _edgeInsetsReference.toNullable
                  : _edgeInsetsReference
              ..type = MethodType.getter
              ..lambda = true
              ..body = _getEdgeInsetsExpression(
                fromClassField: fromClassField,
                fieldName: valueFieldName,
                type: type,
                isNullable: isNullable,
              ).code;
          },
        ),
    ];
  }

  Expression _getEdgeInsetsExpression({
    required String fromClassField,
    required String fieldName,
    required _EdgeInsetsType type,
    required bool isNullable,
  }) {
    final fieldReference = isNullable
        ? refer('$fromClassField.$fieldName').nullChecked
        : refer('$fromClassField.$fieldName');
    final namedArgument = switch (type) {
      _EdgeInsetsType.left => {
          'left': fieldReference,
        },
      _EdgeInsetsType.top => {
          'top': fieldReference,
        },
      _EdgeInsetsType.right => {
          'right': fieldReference,
        },
      _EdgeInsetsType.bottom => {
          'bottom': fieldReference,
        },
      _EdgeInsetsType.vertical => {
          'top': fieldReference,
          'bottom': fieldReference,
        },
      _EdgeInsetsType.horizontal => {
          'left': fieldReference,
          'right': fieldReference,
        },
      _EdgeInsetsType.all => {
          'left': fieldReference,
          'top': fieldReference,
          'right': fieldReference,
          'bottom': fieldReference,
        },
    };
    if (isNullable == false) {
      return _edgeInsetsReference.newInstanceNamed(
        'only',
        [],
        namedArgument,
      );
    } else {
      return refer('$fromClassField.$fieldName')
          .equalTo(literalNull)
          .conditional(
            literalNull,
            _edgeInsetsReference.newInstanceNamed(
              'only',
              [],
              namedArgument,
            ),
          );
    }
  }
}

enum _EdgeInsetsType { left, top, right, bottom, vertical, horizontal, all }
