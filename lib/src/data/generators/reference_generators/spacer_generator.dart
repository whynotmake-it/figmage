import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/reference_generators/reference_theme_class_generator.dart';
import 'package:figmage/src/data/generators/theme_extension_generators/mode_theme_extension_generator.dart';

///{@template spacer_generator}
///A generator for a spacer class.
///{@endtemplate}
class SpacerGenerator extends ReferenceThemeClassGenerator {
  ///{@macro spacer_generator}
  SpacerGenerator({
    required super.className,
    required super.fromClass,
    required super.valueNames,
    super.buildContextExtensionNullable = false,
  });

  final _sizedBoxReference = refer('SizedBox', 'package:flutter/widgets.dart');

  @override
  List<Method> buildGetters({
    required String fromClassField,
    required String valueFieldName,
    required bool isNullable,
  }) {
    final reference =
        isNullable ? _sizedBoxReference.toNullable : _sizedBoxReference;
    return [
      Method(
        (m) => m
          ..name = '${valueFieldName}Horizontal'
          ..returns = reference
          ..type = MethodType.getter
          ..lambda = true
          ..body = _getSizedBoxExpression(
            fromClassField: fromClassField,
            fieldName: valueFieldName,
            isHorizontal: true,
            isNullable: isNullable,
          ).code,
      ),
      Method(
        (m) => m
          ..name = '${valueFieldName}Vertical'
          ..returns = reference
          ..type = MethodType.getter
          ..lambda = true
          ..body = _getSizedBoxExpression(
            fromClassField: fromClassField,
            fieldName: valueFieldName,
            isHorizontal: false,
            isNullable: isNullable,
          ).code,
      ),
    ];
  }

  Expression _getSizedBoxExpression({
    required String fromClassField,
    required String fieldName,
    required bool isHorizontal,
    required bool isNullable,
  }) {
    final fieldReference = isNullable
        ? refer('$fromClassField.$fieldName').nullChecked
        : refer('$fromClassField.$fieldName');

    final namedArguments = switch (isHorizontal) {
      true => {'width': fieldReference},
      false => {'height': fieldReference},
    };
    if (isNullable == false) {
      return _sizedBoxReference.newInstance(
        [],
        namedArguments,
      );
    } else {
      return refer('$fromClassField.$fieldName')
          .equalTo(literalNull)
          .conditional(
            literalNull,
            _sizedBoxReference.newInstance(
              [],
              namedArguments,
            ),
          );
    }
  }
}
