import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:figmage/src/data/generators/generator_util.dart';
import 'package:figmage/src/data/generators/value_names_theme_class_generator.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';

/// {@template padding_generator}
/// A generator for a padding class.
/// {@endtemplate}
class PaddingGenerator implements ValueNamesThemeClassGenerator {
  /// {@macro padding_generator_template}
  PaddingGenerator({
    required this.className,
    required this.numberReference,
    required this.valueNames,
    this.buildContextExtensionNullable = false,
  }) : assert(
          numberReference.symbol != null,
          'The symbol can"t be null when generating a spacer generator',
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

  final _dartfmt = DartFormatter();

  final _emitter = DartEmitter(
    allocator: Allocator(),
    useNullSafetySyntax: true,
    orderDirectives: true,
  );

  @override
  ThemeClassGeneratorResult generate() {
    final fieldName = convertToValidVariableName(numberReference.symbol!);
    final validValueNames = valueNames.map(convertToValidVariableName).toList();
    final validClassName = '${convertToValidClassName(className)}Padding';

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
          _getPaddingGetters(valueNames: valueNames, fieldName: fieldName),
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

  List<Method> _getPaddingGetters({
    required List<String> valueNames,
    required String fieldName,
  }) {
    final edgeInsetsReference =
        refer('EdgeInsets', 'package:flutter/painting.dart');
    return [
      for (final name in valueNames)
        for (final type in _EdgeInsetsType.values)
          Method(
            (m) {
              final methodName =
                  '$name${type.name[0].toUpperCase() + type.name.substring(1)}';
              m
                ..name = methodName
                ..returns = edgeInsetsReference
                ..type = MethodType.getter
                ..lambda = true
                ..body = _getEdgeInsetsExpression(
                  valueName: name,
                  fieldName: fieldName,
                  type: type,
                  edgeInsetsReference: edgeInsetsReference,
                );
            },
          ),
    ];
  }

  Code _getEdgeInsetsExpression({
    required String valueName,
    required String fieldName,
    required _EdgeInsetsType type,
    required Reference edgeInsetsReference,
  }) {
    final namedArgument = switch (type) {
      _EdgeInsetsType.left => {'left': refer('$fieldName.$valueName')},
      _EdgeInsetsType.top => {'top': refer('$fieldName.$valueName')},
      _EdgeInsetsType.right => {'right': refer('$fieldName.$valueName')},
      _EdgeInsetsType.bottom => {'bottom': refer('$fieldName.$valueName')},
      _EdgeInsetsType.vertical => {
          'top': refer('$fieldName.$valueName'),
          'bottom': refer('$fieldName.$valueName'),
        },
      _EdgeInsetsType.horizontal => {
          'left': refer('$fieldName.$valueName'),
          'right': refer('$fieldName.$valueName'),
        },
      _EdgeInsetsType.all => {
          'left': refer('$fieldName.$valueName'),
          'top': refer('$fieldName.$valueName'),
          'right': refer('$fieldName.$valueName'),
          'bottom': refer('$fieldName.$valueName'),
        },
    };
    return edgeInsetsReference
        .newInstanceNamed(
          'only',
          [],
          namedArgument,
        )
        .code;
  }
}

enum _EdgeInsetsType { left, top, right, bottom, vertical, horizontal, all }
