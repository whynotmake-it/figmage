import 'dart:core';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:figmage/src/data/generators/generator_util.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/generators/theme_extension_generator.dart';

/// A collection of all possible arguments that can be passed to a constructor.
typedef ConstructorArguments = ({
  Iterable<Expression> positionalArguments,
  Map<String, Expression> namedArguments,
  List<Reference> typeArguments
});

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
    required this.extensionSymbol,
    this.buildContextExtensionNullable = false,
    this.valueToConstructorArguments,
    this.extensionSymbolUrl,
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
  final String extensionSymbol;

  @override
  final String? extensionSymbolUrl;

  @override
  final bool buildContextExtensionNullable;

  /// A function that converts a value to the constructor arguments required for
  /// the extension symbol. Can be null if creating a ThemeExtension
  /// for a built in literal type like double, int, num, String or bool
  final ConstructorArguments Function(T value)? valueToConstructorArguments;

  /// A map with the following structure: <ModeName<ValueName, Value>>
  final Map<String, Map<String, T>> valuesByNameByMode;

  /// A [Reference] to a lerp function that can lerp [extensionSymbol].
  /// If this value is null the generator assumes that [extensionSymbol]
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
    final namesList = validValueMaps.values.first.keys.toList();
    final validClassName = convertToValidClassName(className);
    final $class = _getClass(
      namesList: namesList,
      className: validClassName,
      extensionSymbol: extensionSymbol,
      extensionSymbolUrl: extensionSymbolUrl,
      lerpReference: lerpReference,
    );
    final modeConstants = _getExtensionModesFields(
      className: validClassName,
      extensionSymbol: extensionSymbol,
      valueMaps: validValueMaps,
      extensionSymbolUrl: extensionSymbolUrl,
      valueToConstructorArguments: valueToConstructorArguments,
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
            ...modeConstants,
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

  List<Field> _getExtensionModesFields({
    required String className,
    required Map<String, Map<String, T>> valueMaps,
    required String extensionSymbol,
    required String? extensionSymbolUrl,
    required ConstructorArguments Function(T value)?
        valueToConstructorArguments,
  }) {
    final result = <Field>[];
    valueMaps.forEach((modeName, values) {
      final assignment = refer(className).newInstance(
        [],
        values.map(
          (name, value) {
            return MapEntry(
              name,
              _getValueExpression(
                extensionSymbol,
                extensionSymbolUrl,
                value,
                valueToConstructorArguments,
              ),
            );
          },
        ),
      );
      result.add(
        Field(
          (b) => b
            ..modifier = FieldModifier.constant
            ..type = refer(className)
            ..name = convertToValidConstantName('$modeName$className')
            ..assignment = assignment.code,
        ),
      );
    });
    return result;
  }

  Class _getClass({
    required String className,
    required List<String> namesList,
    required String extensionSymbol,
    required String? extensionSymbolUrl,
    required Reference? lerpReference,
  }) {
    final nullableSymbolReference = extensionSymbolUrl == null
        ? refer(
            '$extensionSymbol?',
          )
        : refer(
            '$extensionSymbol?',
            extensionSymbolUrl,
          );
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
        ..constructors.add(_getConstructor(nameList: namesList))
        ..fields.addAll(
          _getClassFields(
            nameList: namesList,
            nullableSymbolReference: nullableSymbolReference,
          ),
        )
        ..methods.addAll([
          _getCopyWith(
            namesList: namesList,
            className: className,
            nullableSymbolReference: nullableSymbolReference,
          ),
          _getLerp(
            namesList: namesList,
            className: className,
            extensionSymbol: extensionSymbol,
            lerpReference: lerpReference,
          ),
          // TODO(JsprBllnbm): getToString()
        ]),
    );
  }

  Method _getLerp({
    required List<String> namesList,
    required String className,
    required String extensionSymbol,
    required Reference? lerpReference,
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
          refer(className)
              .newInstance(
                [],
                _getLerpBodyExpression(
                  namesList: namesList,
                  extensionSymbol: extensionSymbol,
                  lerpReference: lerpReference,
                ),
              )
              .returned
              .statement,
        ]),
    );
  }

  Map<String, Expression> _getLerpBodyExpression({
    required List<String> namesList,
    required String extensionSymbol,
    required Reference? lerpReference,
  }) {
    final res = <String, Expression>{};
    for (final name in namesList) {
      final positionalArguments = [
        refer(name),
        refer('other.$name'),
        refer('t'),
      ];
      res[name] = lerpReference == null
          ? refer('$extensionSymbol.lerp').call(positionalArguments)
          : lerpReference.call(positionalArguments);
    }
    return res;
  }

  Method _getCopyWith({
    required List<String> namesList,
    required String className,
    required Reference nullableSymbolReference,
  }) {
    return Method(
      (method) => method
        ..annotations.add(refer('override'))
        ..name = 'copyWith'
        ..optionalParameters.addAll(
          List.generate(
            namesList.length,
            (index) => Parameter(
              (p) => p
                ..name = namesList[index]
                ..type = nullableSymbolReference,
            ),
          ),
        )
        ..returns = refer(className)
        ..body = refer(className).newInstance(
          [],
          _getCopyWithBodyExpression(namesList: namesList),
        ).code,
    );
  }

  Map<String, Expression> _getCopyWithBodyExpression({
    required List<String> namesList,
  }) {
    final res = <String, Expression>{};
    for (final name in namesList) {
      res[name] = refer(name).ifNullThen(refer('this.$name'));
    }
    return res;
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

  Expression _getValueExpression(
    String extensionSymbol,
    String? extensionSymbolUrl,
    T value,
    ConstructorArguments Function(T value)? valueToConstructorArguments,
  ) {
    if (_isBuiltinLiteralDartType(extensionSymbol)) {
      return literal(value);
    } else {
      assert(
          valueToConstructorArguments != null,
          'Trying to construct an instance of $extensionSymbol,'
          ' but the valueToConstructorArguments callback is null! ');
      final symbolReference = extensionSymbolUrl == null
          ? refer(
              extensionSymbol,
            )
          : refer(
              extensionSymbol,
              extensionSymbolUrl,
            );
      final (:positionalArguments, :namedArguments, :typeArguments) =
          valueToConstructorArguments!(value);
      return symbolReference.newInstance(
        positionalArguments,
        namedArguments,
        typeArguments,
      );
    }
  }

  bool _isBuiltinLiteralDartType(String type) {
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
