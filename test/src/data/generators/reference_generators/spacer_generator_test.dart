import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/reference_generators/spacer_generator.dart';
import 'package:test/test.dart';

import '../common.dart';

void main() {
  useDartfmt();
  final emitter = DartEmitter(
    allocator: Allocator(),
    useNullSafetySyntax: true,
    orderDirectives: true,
  );
  const valueNames = [
    (name: 's', resolvedInAllModes: true),
    (name: 'm', resolvedInAllModes: true),
    (name: 'l', resolvedInAllModes: false),
  ];
  test('Should create a Spacer class and BuildContextExtension', () async {
    final generator = SpacerGenerator(
      className: 'WebSpacer',
      fromClass: const Reference('MyNumbers'),
      valueNames: valueNames,
    );
    expect(
      generator.generateClass(),
      equalsDart(
        _expectedSpacerClassString,
        emitter,
      ),
    );
    expect(
      generator.generateExtension(),
      equalsDart(
        _expectedSpacerBuildContextExtensionString,
        emitter,
      ),
    );
  });
  test('Should create a class and nullable BuildContext extension', () async {
    final generator = SpacerGenerator(
      className: 'WebSpacer',
      fromClass: const Reference('MyNumbers'),
      valueNames: valueNames,
      buildContextExtensionNullable: true,
    );
    expect(
      generator.generateClass(),
      equalsDart(_expectedSpacerClassString, emitter),
    );
    expect(
      generator.generateExtension(),
      equalsDart(
        _expectedNullableSpacerBuildContextExtensionString,
        emitter,
      ),
    );
  });
}
// **************************************************************************
// TEST RESOURCES
// **************************************************************************

const _expectedSpacerClassString = '''
@immutable
class WebSpacer {
  const WebSpacer(this.myNumbers);

  final MyNumbers myNumbers;

  SizedBox get sHorizontal => SizedBox(width: myNumbers.s);

  SizedBox get sVertical => SizedBox(height: myNumbers.s);

  SizedBox get mHorizontal => SizedBox(width: myNumbers.m);

  SizedBox get mVertical => SizedBox(height: myNumbers.m);

  SizedBox? get lHorizontal => myNumbers.l == null
    ? null
    : SizedBox(width: myNumbers.l!);

  SizedBox? get lVertical =>  myNumbers.l == null
    ? null
    : SizedBox(height: myNumbers.l!);
}
''';
const _expectedSpacerBuildContextExtensionString = '''
extension WebSpacerBuildContextX on BuildContext {
  WebSpacer get webSpacer => WebSpacer(myNumbers);
}
''';

const _expectedNullableSpacerBuildContextExtensionString = '''
extension WebSpacerBuildContextX on BuildContext {
  WebSpacer? get webSpacer => myNumbers == null ? null : WebSpacer(myNumbers!);
}
''';
