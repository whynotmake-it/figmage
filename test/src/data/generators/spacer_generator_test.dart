import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/spacer_generator.dart';
import 'package:test/test.dart';

void main() {
  test('Generates a spacer output file', () async {
    final generator = SpacerGenerator(
      className: 'Web',
      numberReference: const Reference('MyNumbers'),
      valueNames: ['s', 'm', 'l'],
    );
    expect(generator.generate(), equals(_expectedSpacerClassString));
  });
  test('Generates output file with nullable BuildContext extension', () async {
    final generator = SpacerGenerator(
      className: 'Web',
      numberReference: const Reference('MyNumbers'),
      valueNames: ['s', 'm', 'l'],
      buildContextExtensionNullable: true,
    );
    expect(
      generator.generate(),
      equals(_expectedNullableSpacerClassString),
    );
  });
}
// **************************************************************************
// TEST RESOURCES
// **************************************************************************

const _expectedSpacerClassString = '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
class WebSpacer {
  const WebSpacer(this.myNumbers);

  final MyNumbers myNumbers;

  SizedBox get sHorizontal => SizedBox(width: myNumbers.s);

  SizedBox get mHorizontal => SizedBox(width: myNumbers.m);

  SizedBox get lHorizontal => SizedBox(width: myNumbers.l);

  SizedBox get sVertical => SizedBox(height: myNumbers.s);

  SizedBox get mVertical => SizedBox(height: myNumbers.m);

  SizedBox get lVertical => SizedBox(height: myNumbers.l);
}

extension WebSpacerBuildContextX on BuildContext {
  WebSpacer get webSpacer => WebSpacer(myNumbers);
}
''';
const _expectedNullableSpacerClassString = '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
class WebSpacer {
  const WebSpacer(this.myNumbers);

  final MyNumbers myNumbers;

  SizedBox get sHorizontal => SizedBox(width: myNumbers.s);

  SizedBox get mHorizontal => SizedBox(width: myNumbers.m);

  SizedBox get lHorizontal => SizedBox(width: myNumbers.l);

  SizedBox get sVertical => SizedBox(height: myNumbers.s);

  SizedBox get mVertical => SizedBox(height: myNumbers.m);

  SizedBox get lVertical => SizedBox(height: myNumbers.l);
}

extension WebSpacerBuildContextX on BuildContext {
  WebSpacer? get webSpacer => myNumbers == null ? null : WebSpacer(myNumbers!);
}
''';
