import 'dart:async';
import 'dart:core';

import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:figmage/src/generators/util.dart';
import 'package:source_gen/source_gen.dart';

class ColorThemeExtensionGenerator extends Generator {
  ColorThemeExtensionGenerator({required this.name, required this.colorMaps})
      : assert(ensureSameKeys(colorMaps.values.toList()));

  final String name;

  final Map<String, Map<String, int>> colorMaps;

  final _dartfmt = DartFormatter();
  final _emitter = DartEmitter(useNullSafetySyntax: true);

  @override
  FutureOr<String> generate(
    LibraryReader library,
    BuildStep buildStep,
  ) async {
    final namesList = colorMaps.values.first.keys.toList();
    final extensionClass = _getColorThemeExtensionClass(name, namesList);
    final extensionModes = _getExtensionModesFields(name, colorMaps);
    final extensionCode = extensionClass.accept(_emitter).toString();
    final modeCodes = extensionModes
        .map((mode) => mode.accept(_emitter).toString())
        .join(' \n');
    return _dartfmt.format('$extensionCode \n $modeCodes');
  }
}

List<Field> _getExtensionModesFields(
  String className,
  Map<String, Map<String, int>> colorMaps,
) {
  final result = <Field>[];
  colorMaps.forEach((modeName, colorValues) {
    final assignment = refer(className).newInstance(
      [],
      colorValues.map(
        (colorName, colorValue) => MapEntry(
          colorName,
          refer('Color', 'package:flutter/material.dart').newInstance(
            [refer('0x${colorValue.toRadixString(16)}')],
          ),
        ),
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

Class _getColorThemeExtensionClass(
  String className,
  List<String> namesList,
) {
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
      ..constructors.add(_getConstructor(namesList))
      ..fields.addAll(
        _getColorThemeExtensionClassFields(namesList),
      )
      ..methods.addAll([
        _getCopyWith(namesList, className),
        _getLerp(namesList, className),
        //TODO getToString()
      ]),
  );
}

Method _getLerp(List<String> namesList, String className) {
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
            .newInstance([], _getLerpBodyExpression(namesList))
            .returned
            .statement,
      ]),
  );
}

Map<String, Expression> _getLerpBodyExpression(List<String> namesList) {
  final res = <String, Expression>{};
  for (final name in namesList) {
    res[name] = refer('Color.lerp').call([
      refer(name),
      refer('other.$name'),
      refer('t'),
    ]);
  }
  return res;
}

Method _getCopyWith(List<String> namesList, String className) {
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
                'Color?',
                'package:flutter/material.dart',
              ),
          ),
        ),
      )
      ..returns = refer(className)
      ..body = refer(className)
          .newInstance([], _getCopyWithBodyExpression(namesList)).code,
  );
}

Map<String, Expression> _getCopyWithBodyExpression(List<String> namesList) {
  final res = <String, Expression>{};
  for (final name in namesList) {
    res[name] = refer(name).ifNullThen(refer('this.$name'));
  }
  return res;
}

List<Field> _getColorThemeExtensionClassFields(
  List<String> nameList,
) {
  final List<Field> result = [];
  for (final name in nameList) {
    result.add(
      Field(
        (field) => field
          ..name = name
          ..modifier = FieldModifier.final$
          ..type = refer(
            'Color?',
            'package:flutter/material.dart',
          ),
      ),
    );
  }
  return result;
}

Constructor _getConstructor(List<String> nameList) {
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
