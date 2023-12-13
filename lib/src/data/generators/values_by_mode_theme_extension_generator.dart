import 'dart:core';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:figmage/src/data/generators/generator_util.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/generators/theme_extension_generator.dart';

/// {@template theme_extension_generator}
/// A generator for theme extension classes.
///
/// The [ValuesByModeThemeExtensionGenerator] class is designed to create theme
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
abstract class ValuesByModeThemeExtensionGenerator<T>
    implements ThemeExtensionGenerator<T> {
  /// {@macro theme_extension_generator}
  ValuesByModeThemeExtensionGenerator({
    required this.className,
    required this.valuesByNameByMode,
    required this.extensionSymbolReference,
    this.buildContextExtensionNullable = false,
    this.valueToConstructorExpression,
    this.lerpReference,
  }) : assert(
          ensureSameKeys(
            valuesByNameByMode.values.toList(),
          ),
          'All value maps must have the same keys.',
        );

  @override
  final String className;

  @override
  final Reference extensionSymbolReference;

  @override
  final bool buildContextExtensionNullable;

  /// A function that converts a value to the constructor expression
  /// that initializes the extension symbol.
  /// Can be null if creating a ThemeExtension for a built in literal type like
  /// double, int, num, String or bool
  final Expression Function(
    T value,
  )? valueToConstructorExpression;

  /// A map with the following structure: <ModeName<ValueName, Value>>
  final Map<String, Map<String, T>> valuesByNameByMode;

  /// A [Reference] to a lerp function that can lerp [extensionSymbolReference].
  /// If this value is null the generator assumes that [extensionSymbolReference]
  /// implements a lerp function
  final Reference? lerpReference;

  final _dartfmt = DartFormatter();

  final _emitter = DartEmitter(
    allocator: Allocator(),
    useNullSafetySyntax: true,
    orderDirectives: true,
  );

  @override
  String generate() {
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
    final validClassName = convertToValidClassName(className);
    final $class = _getClass(
      valueMaps: validValueMaps,
      className: validClassName,
      lerpReference: lerpReference,
    );

    final buildContextExtension = _getBuildContextExtension(
      className: validClassName,
      nullable: buildContextExtensionNullable,
    );

    final $library = Library(
      (l) => l
        ..body.addAll(
          [
            $class,
            buildContextExtension,
          ],
        ),
    );

    final result = '''
      ${ThemeClassGenerator.generatedFilePrefix}

      ${$library.accept(_emitter)}
    ''';

    return _dartfmt.format(result);
  }

  Extension _getBuildContextExtension({
    required String className,
    required bool nullable,
  }) {
    final extensionName = '${className}BuildContextX';
    final bodySuffix = nullable ? '' : '!';
    final returnTypeSuffix = nullable ? '?' : '';
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
    required String className,
    required Map<String, Map<String, T>> valueMaps,
    required Reference? lerpReference,
  }) {
    final nullableSymbolReference = extensionSymbolReference.toNullable;

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
            nameList: parameterNames,
            nullableSymbolReference: nullableSymbolReference,
          ),
        )
        ..methods.addAll([
          _getCopyWith(
            parameterNames: parameterNames,
            className: className,
            nullableSymbolReference: nullableSymbolReference,
          ),
          _getLerp(
            parameterNames: parameterNames,
            className: className,
          ),
          // TODO(JsprBllnbm): getToString()
        ]),
    );
  }

  Method _getLerp({
    required List<String> parameterNames,
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
          _getLerpedConstructor(parameterNames: parameterNames)
              .returned
              .statement,
        ]),
    );
  }

  Expression _getLerpedConstructor({
    required List<String> parameterNames,
  }) {
    final lerpReference =
        this.lerpReference ?? extensionSymbolReference.property("lerp");
    return refer(className).newInstance(
      [],
      {
        for (final name in parameterNames)
          name: lerpReference.call(
            [
              refer(name),
              refer('other.$name'),
              refer('t'),
            ],
          ),
      },
    );
  }

  Method _getCopyWith({
    required List<String> parameterNames,
    required String className,
    required Reference nullableSymbolReference,
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
                ..type = nullableSymbolReference,
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

  List<Field> _getClassFields({
    required List<String> nameList,
    required Reference nullableSymbolReference,
  }) {
    return [
      for (final name in nameList)
        Field(
          (field) => field
            ..name = name
            ..modifier = FieldModifier.final$
            ..type = nullableSymbolReference,
        ),
    ];
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
    required Map<String, Map<String, T>> valueMaps,
  }) {
    return [
      for (final MapEntry(key: modeName, value: valuesByName)
          in valueMaps.entries)
        Constructor(
          (constructor) => constructor
            ..constant = true
            ..name = switch (modeName) {
              "" => "standard",
              _ => convertToValidVariableName(modeName),
            }
            ..initializers.addAll(
              [
                for (final MapEntry(key: name, :value) in valuesByName.entries)
                  Code(
                    '$name = ${_getValueExpression(
                      value,
                    ).accept(_emitter)}',
                  ),
              ],
            ),
        ),
    ];
  }

  Expression _getValueExpression(
    T value,
  ) {
    if (_isBuiltinLiteralDartType(extensionSymbolReference)) {
      return literal(value);
    } else {
      assert(
          valueToConstructorExpression != null,
          'Trying to construct an instance of $extensionSymbolReference,'
          ' but the valueToConstructorArguments callback is null! ');

      return valueToConstructorExpression!(value).call(
        [],
        {},
        [extensionSymbolReference],
      );
    }
  }

  bool _isBuiltinLiteralDartType(Reference symbolReference) {
    final type = symbolReference.symbol;
    const dartCoreLiteralTypes = <String>{
      'int',
      'double',
      'num',
      'bool',
      'String',
    };
    return dartCoreLiteralTypes.contains(type);
  }
}

extension _ReferenceX on Reference {
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
