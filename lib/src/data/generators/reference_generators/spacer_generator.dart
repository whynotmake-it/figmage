import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/reference_generators/reference_theme_class_generator.dart';

///{@template spacer_generator}
///A generator for a spacer class.
///{@endtemplate}
class SpacerGenerator extends ReferenceThemeClassGenerator {
  ///{@macro spacer_generator}
  SpacerGenerator({
    required super.className,
    required super.fromClass,
    required super.valueFields,
    super.buildContextExtensionNullable = false,
  });

  final _sizedBoxReference = refer('SizedBox', 'package:flutter/widgets.dart');

  @override
  List<Method> buildGetters({
    required String fromClassField,
    required String valueFieldName,
  }) {
    return [
      Method(
        (m) => m
          ..name = '${valueFieldName}Horizontal'
          ..returns = _sizedBoxReference
          ..type = MethodType.getter
          ..lambda = true
          ..body = _getSizedBoxExpression(
            fromClassField: fromClassField,
            fieldName: valueFieldName,
            isHorizontal: true,
          ),
      ),
      Method(
        (m) => m
          ..name = '${valueFieldName}Vertical'
          ..returns = _sizedBoxReference
          ..type = MethodType.getter
          ..lambda = true
          ..body = _getSizedBoxExpression(
            fromClassField: fromClassField,
            fieldName: valueFieldName,
            isHorizontal: false,
          ),
      ),
    ];
  }

  Code _getSizedBoxExpression({
    required String fromClassField,
    required String fieldName,
    required bool isHorizontal,
  }) {
    final namedArgument = switch (isHorizontal) {
      true => {'width': refer('$fromClassField.$fieldName')},
      false => {'height': refer('$fromClassField.$fieldName')},
    };
    return refer('SizedBox', 'package:flutter/material.dart').newInstance(
      [],
      namedArgument,
    ).code;
  }
}
