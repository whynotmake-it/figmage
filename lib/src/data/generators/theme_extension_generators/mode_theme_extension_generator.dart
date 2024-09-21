import 'dart:core';

import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/generator_util.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/util/values_by_name_by_mode_x.dart';

/// {@template theme_extension_generator}
/// A generator for theme extension classes.
///
/// The [ModeThemeExtensionGenerator] class is designed to create theme
/// extension classes based on provided parameters. It assumes that you might
/// need your themes in different modes (e.g. light and dark mode for color
/// theme).
///
/// Example usage:
///
/// ```dart
/// final generator = ThemeExtensionGenerator<Color>(
///   className: 'MyColorTheme',
///   valueMaps: {
///     'mode1': {'color1': Color(0xFF000000), 'color2': Color(0xFFFFFFFF)},
///     'mode2': {'color1': Color(0xFF111111), 'color2': Color(0xFF222222)},
///   },
///   extensionSymbol: 'Color',
///   extensionSymbolUrl: 'package:flutter/material.dart',
///   valueToConstructorArguments: (Color value) =>
///      valueArgumentsForColor(value),
/// );
/// ```
/// {@endtemplate}
abstract class ModeThemeExtensionGenerator<T>
    implements ThemeExtensionGenerator {
  /// {@macro theme_extension_generator}
  ModeThemeExtensionGenerator({
    required String className,
    required this.valuesByNameByMode,
    required this.symbolReference,
    this.buildContextExtensionNullable = false,
    this.lerpReference,
  })  : className = convertToValidClassName(className),
        assert(
          ensureSameKeys(valuesByNameByMode.values.toList()),
          'All value maps must have the same keys.',
        );

  @override
  final String className;

  @override
  final Reference symbolReference;

  @override
  final bool buildContextExtensionNullable;

  /// A map with the following structure: <ModeName<ValueName, Value>>
  ///
  /// The value can be optional, in case some aliases were unresolved.
  final Map<String, Map<String, T?>> valuesByNameByMode;

  /// A [Reference] to a lerp function that can lerp [symbolReference].
  /// If this value is null the generator assumes that
  /// [symbolReference] implements a lerp function
  final Reference? lerpReference;

  /// Converts a value to the constructor expression
  /// that initializes the extension symbol.
  Expression getConstructorExpression(T value);

  @override
  Class generateClass() {
    final validValueMaps = valuesByNameByMode.map(
      (key, value) => MapEntry(
        switch (key) {
          "" => "",
          _ => convertToValidVariableName(key),
        },
        value.map(
          (key, value) => MapEntry(convertToValidVariableName(key), value),
        ),
      ),
    );

    return _getClass(valueMaps: validValueMaps);
  }

  @override
  Extension generateExtension() {
    final extensionName = '${className}BuildContextX';
    final bodySuffix = buildContextExtensionNullable ? '' : '!';
    final returnTypeSuffix = buildContextExtensionNullable ? '?' : '';
    final methodName = convertToValidVariableName(className);

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
              ..body =
                  Code('Theme.of(this).extension<$className>()$bodySuffix'),
          ),
        ),
    );
  }

  Class _getClass({
    required Map<String, Map<String, T?>> valueMaps,
  }) {
    final parameterNames = valueMaps.values.first.keys.toList();
    return Class(
      (c) => c
        ..name = className
        ..annotations.add(
          refer(
            'immutable',
            'package:flutter/foundation.dart',
          ),
        )
        ..extend =
            refer('ThemeExtension<$className>', 'package:flutter/material.dart')
        ..constructors.add(_getConstructor(nameList: parameterNames))
        ..constructors.addAll(_getNamedConstructors(valueMaps: valueMaps))
        ..fields.addAll(
          _getClassFields(
            symbolReference: symbolReference,
            valueMaps: valueMaps,
          ),
        )
        ..methods.addAll([
          _getCopyWith(
            parameterNames: parameterNames,
            className: className,
            symbolReference: symbolReference,
          ),
          _getLerp(
            valueMaps: valueMaps,
            className: className,
          ),
          // TODO(JsprBllnbm): getToString()
        ]),
    );
  }

  Method _getLerp({
    required Map<String, Map<String, T?>> valueMaps,
    required String className,
  }) {
    return Method(
      (b) => b
        ..annotations.add(refer('override'))
        ..name = 'lerp'
        ..returns = refer(className)
        ..requiredParameters.addAll([
          Parameter(
            (p) => p
              ..name = 'other'
              ..type = TypeReference(
                (b) => b
                  ..symbol = className
                  ..isNullable = true,
              ),
          ),
          Parameter(
            (p) => p
              ..name = 't'
              ..type = refer('double'),
          ),
        ])
        ..body = Block.of([
          Code('if(other is! $className) return this;'),
          _getLerpedConstructor(valueMaps: valueMaps).returned.statement,
        ]),
    );
  }

  Expression _getLerpedConstructor({
    required Map<String, Map<String, T?>> valueMaps,
  }) {
    final lerpReference =
        this.lerpReference ?? symbolReference.property("lerp");
    final names = valueMaps.values.first.keys.toList();
    return refer(className).newInstance(
      [],
      {
        for (final name in names)
          name: switch (valueMaps.allModesResolved(valueName: name)) {
            true => lerpReference.call(
                [
                  refer(name),
                  refer('other.$name'),
                  refer('t'),
                ],
              ).nullChecked,
            false => lerpReference.call(
                [
                  refer(name),
                  refer('other.$name'),
                  refer('t'),
                ],
              ),
          },
      },
    );
  }

  Method _getCopyWith({
    required List<String> parameterNames,
    required String className,
    required Reference symbolReference,
  }) {
    return Method(
      (method) => method
        ..annotations.add(refer('override'))
        ..name = 'copyWith'
        ..optionalParameters.addAll(
          List.generate(
            parameterNames.length,
            (index) => Parameter(
              (p) => p
                ..name = parameterNames[index]
                ..type = symbolReference.toNullable,
            ),
          ),
        )
        ..returns = refer(className)
        ..body = _getCopyWithConstructor(parameterNames: parameterNames).code,
    );
  }

  Expression _getCopyWithConstructor({
    required List<String> parameterNames,
  }) {
    return refer(className).newInstance([], {
      for (final name in parameterNames)
        name: refer(name).ifNullThen(
          refer('this.$name'),
        ),
    });
  }

  Iterable<Field> _getClassFields({
    required Map<String, Map<String, T?>> valueMaps,
    required Reference symbolReference,
  }) sync* {
    final parameterNames = valueMaps.values.first.keys.toSet();
    for (final name in parameterNames) {
      final isNullable = valueMaps.allModesResolved(valueName: name) == false;
      yield Field(
        (field) => field
          ..name = name
          ..modifier = FieldModifier.final$
          ..type = isNullable ? symbolReference.toNullable : symbolReference,
      );
    }
  }

  Constructor _getConstructor({required List<String> nameList}) {
    return Constructor(
      (constructor) => constructor
        ..constant = true
        ..optionalParameters.addAll(
          [
            for (final name in nameList)
              Parameter(
                (parameter) => parameter
                  ..toThis = true
                  ..name = name
                  ..required = true
                  ..named = true,
              ),
          ],
        ),
    );
  }

  List<Constructor> _getNamedConstructors({
    required Map<String, Map<String, T?>> valueMaps,
  }) {
    return [
      for (final MapEntry(key: modeName, value: valuesByName)
          in valueMaps.entries)
        Constructor(
          (constructor) => constructor
            ..name = switch (modeName) {
              "" => "standard",
              _ => convertToValidVariableName(modeName),
            }
            ..setInitializersAndConst(
              constructorsByParamName: {
                for (final MapEntry(key: name, :value) in valuesByName.entries)
                  name: switch (value) {
                    null => literalNull,
                    _ => getConstructorExpression(value),
                  },
              },
            ),
        ),
    ];
  }
}

/// Extension on Reference
extension ReferenceX on Reference {
  /// Returns the a nullable reference
  Reference get toNullable {
    return Reference(
      switch (symbol) {
        final symbol? when !symbol.endsWith("?") => "$symbol?",
        final symbol? => symbol,
        null => null
      },
      url,
    );
  }
}

extension _ConstructorBuilderX on ConstructorBuilder {
  /// Generates the constructors initializers from [constructorsByParamName].
  ///
  /// If all values are const or literals, the constructor will be marked as
  /// constant.
  ConstructorBuilder setInitializersAndConst({
    required Map<String, Expression> constructorsByParamName,
  }) {
    initializers.addAll([
      for (final MapEntry(key: name, value: expression)
          in constructorsByParamName.entries)
        refer(name).assign(expression).code,
    ]);
    constant = initializers.isEmpty ||
        constructorsByParamName.values.every(
          (element) => element.isConst || element is LiteralExpression,
        );
    return this;
  }
}
