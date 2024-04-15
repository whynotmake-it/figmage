import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/generator_util.dart';
import 'package:figmage/src/data/generators/value_names_theme_class_generator.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';

///{@template spacer_generator}
///A generator for a spacer class.
///{@endtemplate}
class SpacerGenerator implements ValueNamesThemeClassGenerator {
  ///{@macro spacer_generator}
  SpacerGenerator({
    required this.className,
    required this.numberReference,
    required this.valueNames,
    this.buildContextExtensionNullable = false,
  }) : assert(
          numberReference.symbol != null,
          "The symbol can't be null when generating a spacer generator",
        );

  @override
  final String className;

  @override
  bool buildContextExtensionNullable;

  /// The [Reference] for the class which is providing values for the spacers
  final Reference numberReference;

  /// The names of the values
  @override
  final Iterable<String> valueNames;

  @override
  ThemeClassGeneratorResult generate() {
    final fieldName = convertToValidVariableName(numberReference.symbol!);
    final validValueNames = valueNames.map(convertToValidVariableName).toList();
    final validClassName = '${convertToValidClassName(className)}Spacer';

    final $class = _getClass(
      className: validClassName,
      numberReference: numberReference,
      fieldName: fieldName,
      valueNames: validValueNames,
    );

    final $extension = _getBuildContextExtension(
      fieldName: fieldName,
      className: validClassName,
      nullable: buildContextExtensionNullable,
    );

    return ($class: $class, $extension: $extension);
  }

  Extension _getBuildContextExtension({
    required String className,
    required String fieldName,
    required bool nullable,
  }) {
    final extensionName = '${className}BuildContextX';
    final returnTypeSuffix = nullable ? '?' : '';
    final methodName = convertToValidVariableName(className);
    final bodyString = nullable
        ? '$fieldName == null ? null : $className($fieldName!)'
        : '$className($fieldName)';
    return Extension(
      (e) => e
        ..name = extensionName
        ..on = refer('BuildContext')
        ..methods.add(
          Method(
            (m) => m
              ..name = methodName
              ..returns = refer('$className$returnTypeSuffix')
              ..type = MethodType.getter
              ..lambda = true
              ..body = Code(bodyString),
          ),
        ),
    );
  }

  Class _getClass({
    required String className,
    required String fieldName,
    required List<String> valueNames,
    required Reference numberReference,
  }) {
    return Class(
      (c) => c
        ..name = className
        ..annotations.add(
          refer(
            'immutable',
            'package:flutter/foundation.dart',
          ),
        )
        ..constructors.add(_getConstructor(fieldName: fieldName))
        ..fields.add(
          _getField(
            fieldName: fieldName,
            numberReference: numberReference,
          ),
        )
        ..methods.addAll(
          _getSpacerGetters(valueNames: valueNames, fieldName: fieldName),
        ),
    );
  }

  Constructor _getConstructor({required String fieldName}) {
    return Constructor(
      (constructor) => constructor
        ..constant = true
        ..requiredParameters.add(
          Parameter(
            (parameter) => parameter
              ..toThis = true
              ..name = fieldName,
          ),
        ),
    );
  }

  Field _getField({
    required String fieldName,
    required Reference numberReference,
  }) {
    return Field(
      (f) => f
        ..modifier = FieldModifier.final$
        ..name = fieldName
        ..type = numberReference,
    );
  }

  List<Method> _getSpacerGetters({
    required List<String> valueNames,
    required String fieldName,
  }) {
    final sizedBoxReference = refer('SizedBox', 'package:flutter/widgets.dart');
    return [
      for (final name in valueNames)
        Method(
          (m) => m
            ..name = '${name}Horizontal'
            ..returns = sizedBoxReference
            ..type = MethodType.getter
            ..lambda = true
            ..body = _getSizedBoxExpression(
              valueName: name,
              fieldName: fieldName,
              isHorizontal: true,
            ),
        ),
      for (final name in valueNames)
        Method(
          (m) => m
            ..name = '${name}Vertical'
            ..returns = sizedBoxReference
            ..type = MethodType.getter
            ..lambda = true
            ..body = _getSizedBoxExpression(
              valueName: name,
              fieldName: fieldName,
              isHorizontal: false,
            ),
        ),
    ];
  }

  Code _getSizedBoxExpression({
    required String valueName,
    required String fieldName,
    required bool isHorizontal,
  }) {
    final namedArgument = switch (isHorizontal) {
      true => {'width': refer('$fieldName.$valueName')},
      false => {'height': refer('$fieldName.$valueName')},
    };
    return refer('SizedBox', 'package:flutter/material.dart').newInstance(
      [],
      namedArgument,
    ).code;
  }
}
