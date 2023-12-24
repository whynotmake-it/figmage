import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/data/generators/padding_generator.dart';
import 'package:test/test.dart';

import 'common.dart';

void main() {
  useDartfmt();
  final emitter = DartEmitter(
    allocator: Allocator(),
    useNullSafetySyntax: true,
    orderDirectives: true,
  );
  test('Should create a padding class and BuildContextExtension', () async {
    final generator = PaddingGenerator(
      className: 'Web',
      numberReference: const Reference('MyNumbers'),
      valueNames: ['s', 'm', 'l'],
    );
    expect(
      generator.generate().$class,
      equalsDart(
        _expectedPaddingClassString,
        emitter,
      ),
    );
    expect(
      generator.generate().$extension,
      equalsDart(
        _expectedPaddingBuildContextExtensionString,
        emitter,
      ),
    );
  });
  test('Should create a padding class and nullable BuildContextExtension',
      () async {
    final generator = PaddingGenerator(
      className: 'Web',
      numberReference: const Reference('MyNumbers'),
      valueNames: ['s', 'm', 'l'],
      buildContextExtensionNullable: true,
    );
    expect(
      generator.generate().$class,
      equalsDart(
        _expectedNullablePaddingClassString,
        emitter,
      ),
    );
    expect(
      generator.generate().$extension,
      equalsDart(
        _expectedNullablePaddingBuildContextExtensionString,
        emitter,
      ),
    );
  });
}
// **************************************************************************
// TEST RESOURCES
// **************************************************************************

const _expectedPaddingClassString = '''
@immutable
class WebPadding {
  const WebPadding(this.myNumbers);

  final MyNumbers myNumbers;

  EdgeInsets get sLeft => EdgeInsets.only(left: myNumbers.s);

  EdgeInsets get sTop => EdgeInsets.only(top: myNumbers.s);

  EdgeInsets get sRight => EdgeInsets.only(right: myNumbers.s);

  EdgeInsets get sBottom => EdgeInsets.only(bottom: myNumbers.s);

  EdgeInsets get sVertical => EdgeInsets.only(
        top: myNumbers.s,
        bottom: myNumbers.s,
      );

  EdgeInsets get sHorizontal => EdgeInsets.only(
        left: myNumbers.s,
        right: myNumbers.s,
      );

  EdgeInsets get sAll => EdgeInsets.only(
        left: myNumbers.s,
        top: myNumbers.s,
        right: myNumbers.s,
        bottom: myNumbers.s,
      );

  EdgeInsets get mLeft => EdgeInsets.only(left: myNumbers.m);

  EdgeInsets get mTop => EdgeInsets.only(top: myNumbers.m);

  EdgeInsets get mRight => EdgeInsets.only(right: myNumbers.m);

  EdgeInsets get mBottom => EdgeInsets.only(bottom: myNumbers.m);

  EdgeInsets get mVertical => EdgeInsets.only(
        top: myNumbers.m,
        bottom: myNumbers.m,
      );

  EdgeInsets get mHorizontal => EdgeInsets.only(
        left: myNumbers.m,
        right: myNumbers.m,
      );

  EdgeInsets get mAll => EdgeInsets.only(
        left: myNumbers.m,
        top: myNumbers.m,
        right: myNumbers.m,
        bottom: myNumbers.m,
      );

  EdgeInsets get lLeft => EdgeInsets.only(left: myNumbers.l);

  EdgeInsets get lTop => EdgeInsets.only(top: myNumbers.l);

  EdgeInsets get lRight => EdgeInsets.only(right: myNumbers.l);

  EdgeInsets get lBottom => EdgeInsets.only(bottom: myNumbers.l);

  EdgeInsets get lVertical => EdgeInsets.only(
        top: myNumbers.l,
        bottom: myNumbers.l,
      );

  EdgeInsets get lHorizontal => EdgeInsets.only(
        left: myNumbers.l,
        right: myNumbers.l,
      );

  EdgeInsets get lAll => EdgeInsets.only(
        left: myNumbers.l,
        top: myNumbers.l,
        right: myNumbers.l,
        bottom: myNumbers.l,
      );
}
''';
const _expectedPaddingBuildContextExtensionString = '''
extension WebPaddingBuildContextX on BuildContext {
  WebPadding get webPadding => WebPadding(myNumbers);
}
''';
const _expectedNullablePaddingClassString = '''
@immutable
class WebPadding {
  const WebPadding(this.myNumbers);

  final MyNumbers myNumbers;

  EdgeInsets get sLeft => EdgeInsets.only(left: myNumbers.s);

  EdgeInsets get sTop => EdgeInsets.only(top: myNumbers.s);

  EdgeInsets get sRight => EdgeInsets.only(right: myNumbers.s);

  EdgeInsets get sBottom => EdgeInsets.only(bottom: myNumbers.s);

  EdgeInsets get sVertical => EdgeInsets.only(
        top: myNumbers.s,
        bottom: myNumbers.s,
      );

  EdgeInsets get sHorizontal => EdgeInsets.only(
        left: myNumbers.s,
        right: myNumbers.s,
      );

  EdgeInsets get sAll => EdgeInsets.only(
        left: myNumbers.s,
        top: myNumbers.s,
        right: myNumbers.s,
        bottom: myNumbers.s,
      );

  EdgeInsets get mLeft => EdgeInsets.only(left: myNumbers.m);

  EdgeInsets get mTop => EdgeInsets.only(top: myNumbers.m);

  EdgeInsets get mRight => EdgeInsets.only(right: myNumbers.m);

  EdgeInsets get mBottom => EdgeInsets.only(bottom: myNumbers.m);

  EdgeInsets get mVertical => EdgeInsets.only(
        top: myNumbers.m,
        bottom: myNumbers.m,
      );

  EdgeInsets get mHorizontal => EdgeInsets.only(
        left: myNumbers.m,
        right: myNumbers.m,
      );

  EdgeInsets get mAll => EdgeInsets.only(
        left: myNumbers.m,
        top: myNumbers.m,
        right: myNumbers.m,
        bottom: myNumbers.m,
      );

  EdgeInsets get lLeft => EdgeInsets.only(left: myNumbers.l);

  EdgeInsets get lTop => EdgeInsets.only(top: myNumbers.l);

  EdgeInsets get lRight => EdgeInsets.only(right: myNumbers.l);

  EdgeInsets get lBottom => EdgeInsets.only(bottom: myNumbers.l);

  EdgeInsets get lVertical => EdgeInsets.only(
        top: myNumbers.l,
        bottom: myNumbers.l,
      );

  EdgeInsets get lHorizontal => EdgeInsets.only(
        left: myNumbers.l,
        right: myNumbers.l,
      );

  EdgeInsets get lAll => EdgeInsets.only(
        left: myNumbers.l,
        top: myNumbers.l,
        right: myNumbers.l,
        bottom: myNumbers.l,
      );
}
''';

const _expectedNullablePaddingBuildContextExtensionString = '''
extension WebPaddingBuildContextX on BuildContext {
  WebPadding? get webPadding =>
      myNumbers == null ? null : WebPadding(myNumbers!);
}
''';
