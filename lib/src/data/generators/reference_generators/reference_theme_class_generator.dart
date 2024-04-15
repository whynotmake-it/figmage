import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/generator_util.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:meta/meta.dart';

/// {@template reference_theme_class_generator}
/// A [ThemeClassGenerator] that generates a class that doesn't hold any values,
/// but rather contains a bunch of getters that build values based on the fields
/// of another class.
/// {@endtemplate}
abstract class ReferenceThemeClassGenerator implements ThemeClassGenerator {
  /// {@macro reference_theme_class_generator}
  ReferenceThemeClassGenerator({
    required String className,
    required this.valueFields,
    required this.fromClass,
    required this.buildContextExtensionNullable,
  }) : className = convertToValidClassName(className);

  @override
  final String className;

  @override
  final bool buildContextExtensionNullable;

  /// The [Reference] to the type of [fromClass].
  final Reference fromClass;

  /// The fields in [fromClass] that will be used to generate the getters.
  ///
  /// In a numbers class for example, these could be `["s", "m", "l"]`.
  final List<String> valueFields;

  /// The name of the field in the generated class that holds the reference to
  /// the fr.
  String get _fieldName => convertToValidVariableName(fromClass.symbol!);

  List<String> get _valueNames =>
      valueFields.map(convertToValidVariableName).toList();

  /// This method will be used to build the actual getters that are generated
  /// from each of the fields in [fromClass].
  ///
  /// The [fromClassField] will be the reference to the field in the generated
  /// class that references [fromClass], and [valueFieldName] will be the name
  /// of the field in [fromClass] that the getter will return.
  ///
  /// Thus, to access the value of interest, the returned getters should call
  /// `fromClassField.fieldName`.
  List<Method> buildGetters({
    required String fromClassField,
    required String valueFieldName,
  });

  @override
  Class generateClass() {
    return Class(
      (c) => c
        ..name = className
        ..annotations.add(
          refer(
            'immutable',
            'package:flutter/foundation.dart',
          ),
        )
        ..constructors.add(getConstructor())
        ..fields.add(getField())
        ..methods.addAll(
          [
            for (final name in _valueNames)
              ...buildGetters(
                fromClassField: _fieldName,
                valueFieldName: name,
              ),
          ],
        ),
    );
  }

  @override
  Extension generateExtension() {
    final methodName = convertToValidVariableName(className);

    final extensionName = '${className}BuildContextX';

    final returnTypeSuffix = buildContextExtensionNullable ? '?' : '';
    final bodyString = buildContextExtensionNullable
        ? '$_fieldName == null ? null : $className($_fieldName!)'
        : '$className($_fieldName)';
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

  /// Builds the constructor for the generated class.
  @visibleForTesting
  Constructor getConstructor() {
    return Constructor(
      (constructor) => constructor
        ..constant = true
        ..requiredParameters.add(
          Parameter(
            (parameter) => parameter
              ..toThis = true
              ..name = _fieldName,
          ),
        ),
    );
  }

  /// Builds the field that will hold the reference to the [fromClass].
  @visibleForTesting
  Field getField() {
    return Field(
      (f) => f
        ..modifier = FieldModifier.final$
        ..name = _fieldName
        ..type = fromClass,
    );
  }
}
