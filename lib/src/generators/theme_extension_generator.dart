import 'dart:async';
import 'dart:core';

import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:figmage/src/generators/util.dart';
import 'package:source_gen/source_gen.dart';

typedef ValueArguments = ({
  Iterable<Expression> positionalArguments,
  Map<String, Expression> namedArguments,
  List<Reference> typeArguments
});

/// A generator for theme extension classes.
///
/// The [ThemeExtensionGenerator] class is designed to create theme extension
/// classes based on provided parameters. It assumes that you might need
/// your themes in different modes (e.g. light and dark mode for color theme).
///
/// The [ThemeExtensionGenerator] takes the following parameters:
///
/// - [className]: The name of the generated theme extension class.
/// - [extensionSymbol]: The symbol (e.g., Color, TextStyle) used in the theme
///   extension.
/// - [extensionSymbolUrl]: The URL for the symbol, typically a package URL.
/// - [valueToConstructorArguments]: A function that converts a value to the
///   constructor arguments required for the extension symbol.
/// - [valueMaps]: A map with the following structure:
///   <ModeName<ValueName<Value>>>
///
/// The generated theme extension class includes methods like `copyWith` and
/// `lerp` for easy theme modification and transitions.
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
///   valueToConstructorArguments: (Color value) => valueArgumentsForColor(value),
/// );
/// ```
class ThemeExtensionGenerator<T> extends Generator {
  ThemeExtensionGenerator({
    required this.className,
    required this.valueMaps,
    required this.extensionSymbol,
    required this.extensionSymbolUrl,
    required this.valueToConstructorArguments,
  }) : assert(
          ensureSameKeys(
            valueMaps.values.toList(),
          ),
        );

  final String className;
  final String extensionSymbol;
  final String extensionSymbolUrl;
  final ValueArguments Function(T value) valueToConstructorArguments;

  final Map<String, Map<String, T>> valueMaps;

  final _dartfmt = DartFormatter();
  final _emitter = DartEmitter(useNullSafetySyntax: true);

  @override
  FutureOr<String> generate(
    LibraryReader library,
    BuildStep buildStep,
  ) async =>
      justGenerate();

  FutureOr<String> justGenerate() async {
    final validValueMaps = valueMaps.map(
      (key, value) => MapEntry(
        convertToValidVariableName(key),
        value.map(
          (key, value) => MapEntry(convertToValidVariableName(key), value),
        ),
      ),
    );
    final namesList = validValueMaps.values.first.keys.toList();
    final validClassName = convertToValidClassName(className);
    final extensionClass = _getThemeExtensionClass(
      namesList: namesList,
      className: validClassName,
      extensionSymbol: extensionSymbol,
      extensionSymbolUrl: extensionSymbolUrl,
    );
    final extensionModes = _getExtensionModesFields(
      className: validClassName,
      extensionSymbol: extensionSymbol,
      valueMaps: validValueMaps,
      extensionSymbolUrl: extensionSymbolUrl,
      valueToString: valueToConstructorArguments,
    );
    final extensionCode = extensionClass.accept(_emitter).toString();
    final modeCodes = extensionModes
        .map((mode) => mode.accept(_emitter).toString())
        .join(' \n');
    return _dartfmt.format('$extensionCode \n $modeCodes');
  }

  List<Field> _getExtensionModesFields({
    required String className,
    required Map<String, Map<String, T>> valueMaps,
    required String extensionSymbol,
    required String extensionSymbolUrl,
    required ValueArguments Function(T value) valueToString,
  }) {
    final result = <Field>[];
    valueMaps.forEach((modeName, values) {
      final assignment = refer(className).newInstance(
        [],
        values.map(
          (name, value) {
            final (:positionalArguments, :namedArguments, :typeArguments) =
                valueToString(value);
            return MapEntry(
              name,
              refer(extensionSymbol, extensionSymbolUrl).newInstance(
                positionalArguments,
                namedArguments,
                typeArguments,
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
            ..name = '$modeName$className'
            ..assignment = assignment.code,
        ),
      );
    });
    return result;
  }

  Class _getThemeExtensionClass({
    required String className,
    required List<String> namesList,
    required String extensionSymbol,
    required String extensionSymbolUrl,
  }) {
    return Class(
      (colorClass) => colorClass
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
          _getColorThemeExtensionClassFields(
            nameList: namesList,
            extensionSymbol: extensionSymbol,
            extensionSymbolUrl: extensionSymbolUrl,
          ),
        )
        ..methods.addAll([
          _getCopyWith(
            namesList: namesList,
            className: className,
            extensionSymbol: extensionSymbol,
            extensionUrl: extensionSymbolUrl,
          ),
          _getLerp(
            namesList: namesList,
            className: className,
            extensionSymbol: extensionSymbol,
          ),
          //TODO getToString()
        ]),
    );
  }

  Method _getLerp({
    required List<String> namesList,
    required String className,
    required String extensionSymbol,
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
  }) {
    final res = <String, Expression>{};
    for (final name in namesList) {
      res[name] = refer('$extensionSymbol.lerp').call([
        refer(name),
        refer('other.$name'),
        refer('t'),
      ]);
    }
    return res;
  }

  Method _getCopyWith({
    required List<String> namesList,
    required String className,
    required String extensionSymbol,
    required String extensionUrl,
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
                ..type = refer(
                  '$extensionSymbol?',
                  extensionUrl,
                ),
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

  List<Field> _getColorThemeExtensionClassFields({
    required List<String> nameList,
    required String extensionSymbol,
    required String extensionSymbolUrl,
  }) {
    final List<Field> result = [];
    for (final name in nameList) {
      result.add(
        Field(
          (field) => field
            ..name = name
            ..modifier = FieldModifier.final$
            ..type = refer(
              '$extensionSymbol?',
              extensionSymbolUrl,
            ),
        ),
      );
    }
    return result;
  }

  Constructor _getConstructor({required List<String> nameList}) {
    return Constructor(
      (constructor) => constructor
        ..constant = true
        ..optionalParameters.addAll(
          List.generate(
            nameList.length,
            (index) => Parameter(
              (parameter) => parameter
                ..toThis = true
                ..name = nameList[index]
                ..required = true
                ..named = true,
            ),
          ),
        ), //
    );
  }
}
