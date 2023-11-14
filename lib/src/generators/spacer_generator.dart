import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:figmage/src/generators/util.dart';

///{@space_generator_template}
///A generator for a spacer class.
///{@endtemplate}
class SpacerGenerator {
  ///{@macro space_generator_template}
  SpacerGenerator({
    required this.className,
    required this.numberReference,
    required this.valueNames,
    this.buildContextExtensionNullable = false,
  }) : assert(
          numberReference.symbol != null,
          'The symbol can"t be null when generating a spacer generator',
        );

  ///The of the generated spacer class. Assembled as: 'Spacer$className'
  final String className;

  ///The [Reference] for the class which is providing values for the spacers
  final Reference numberReference;

  ///The names of the values
  final List<String> valueNames;

  /// A bool indicating if the BuildContextExtension should be nullable
  bool buildContextExtensionNullable;

  final _dartfmt = DartFormatter();

  final _emitter = DartEmitter(
    allocator: Allocator(),
    useNullSafetySyntax: true,
    orderDirectives: true,
  );

  ///Generates a spacer class
  String generate() {
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

    final $library = Library(
      (l) => l
        ..body.addAll(
          [
            $class,
            $extension,
          ],
        ),
    );

    final result = '''
      // coverage:ignore-file
      // GENERATED CODE - DO NOT MODIFY BY HAND
      // ignore_for_file: type=lint

      ${$library.accept(_emitter)}
    ''';

    return _dartfmt.format(result);
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
