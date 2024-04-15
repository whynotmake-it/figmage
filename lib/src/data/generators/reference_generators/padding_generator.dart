import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/reference_generators/reference_theme_class_generator.dart';
import 'package:figmage/src/data/util/converters/string_dart_conversion_x.dart';

/// {@template padding_generator}
/// A generator for a padding class.
/// {@endtemplate}
class PaddingGenerator extends ReferenceThemeClassGenerator {
  /// {@macro padding_generator_template}
  PaddingGenerator({
    required super.className,
    required super.fromClass,
    required super.valueFields,
    super.buildContextExtensionNullable = false,
  });

  final _edgeInsetsReference =
      refer('EdgeInsets', 'package:flutter/painting.dart');

  @override
  List<Method> buildGettersForFromClassField({
    required String fromClassField,
    required String valueFieldName,
  }) {
    return [
      for (final type in _EdgeInsetsType.values)
        Method(
          (m) {
            m
              ..name = '$valueFieldName${type.name.toTitleCase()}'
              ..returns = _edgeInsetsReference
              ..type = MethodType.getter
              ..lambda = true
              ..body = _getEdgeInsetsExpression(
                fromClassField: fromClassField,
                fieldName: valueFieldName,
                type: type,
              ).code;
          },
        ),
    ];
  }

  Expression _getEdgeInsetsExpression({
    required String fromClassField,
    required String fieldName,
    required _EdgeInsetsType type,
  }) {
    final namedArgument = switch (type) {
      _EdgeInsetsType.left => {
          'left': refer('$fromClassField.$fieldName').nullChecked,
        },
      _EdgeInsetsType.top => {
          'top': refer('$fromClassField.$fieldName').nullChecked,
        },
      _EdgeInsetsType.right => {
          'right': refer('$fromClassField.$fieldName').nullChecked,
        },
      _EdgeInsetsType.bottom => {
          'bottom': refer('$fromClassField.$fieldName').nullChecked,
        },
      _EdgeInsetsType.vertical => {
          'top': refer('$fromClassField.$fieldName').nullChecked,
          'bottom': refer('$fromClassField.$fieldName').nullChecked,
        },
      _EdgeInsetsType.horizontal => {
          'left': refer('$fromClassField.$fieldName').nullChecked,
          'right': refer('$fromClassField.$fieldName').nullChecked,
        },
      _EdgeInsetsType.all => {
          'left': refer('$fromClassField.$fieldName').nullChecked,
          'top': refer('$fromClassField.$fieldName').nullChecked,
          'right': refer('$fromClassField.$fieldName').nullChecked,
          'bottom': refer('$fromClassField.$fieldName').nullChecked,
        },
    };
    return _edgeInsetsReference.newInstanceNamed(
      'only',
      [],
      namedArgument,
    );
  }
}

enum _EdgeInsetsType { left, top, right, bottom, vertical, horizontal, all }
