import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/spacer_generator.dart';
import 'package:test/test.dart';

import 'common.dart';

void main() {
  useDartfmt();
  final emitter = DartEmitter(
    allocator: Allocator(),
    useNullSafetySyntax: true,
    orderDirectives: true,
  );
  test('Should create a Spacer class and BuildContextExtension', () async {
    final generator = SpacerGenerator(
      className: 'Web',
      numberReference: const Reference('MyNumbers'),
      valueNames: ['s', 'm', 'l'],
    );
    expect(
      generator.generate().$class,
      equalsDart(
        _expectedSpacerClassString,
        emitter,
      ),
    );
    expect(
      generator.generate().$extension,
      equalsDart(
        _expectedSpacerBuildContextExtensionString,
        emitter,
      ),
    );
  });
  test('Should create a class and nullable BuildContext extension', () async {
    final generator = SpacerGenerator(
      className: 'Web',
      numberReference: const Reference('MyNumbers'),
      valueNames: ['s', 'm', 'l'],
      buildContextExtensionNullable: true,
    );
    expect(
      generator.generate().$class,
      equalsDart(
        _expectedNullableSpacerClassString,
        emitter,
      ),
    );
    expect(
      generator.generate().$extension,
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

  SizedBox get mHorizontal => SizedBox(width: myNumbers.m);

  SizedBox get lHorizontal => SizedBox(width: myNumbers.l);

  SizedBox get sVertical => SizedBox(height: myNumbers.s);

  SizedBox get mVertical => SizedBox(height: myNumbers.m);

  SizedBox get lVertical => SizedBox(height: myNumbers.l);
}
''';
const _expectedSpacerBuildContextExtensionString = '''
extension WebSpacerBuildContextX on BuildContext {
  WebSpacer get webSpacer => WebSpacer(myNumbers);
}
''';
const _expectedNullableSpacerClassString = '''
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
''';
const _expectedNullableSpacerBuildContextExtensionString = '''
extension WebSpacerBuildContextX on BuildContext {
  WebSpacer? get webSpacer => myNumbers == null ? null : WebSpacer(myNumbers!);
}
''';
