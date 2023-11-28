import 'package:figmage/src/data/repositories/figma_styles_repository.dart';
import 'package:test/test.dart';

void main() {
  group('FigmaStylesRepository', () {
    late FigmaStylesRepository sut;
    setUp(() {
      sut = FigmaStylesRepository();
    });
    group('getStyles', () {
      test('Test me up', () async {
        final res = await sut.getStyles(
          fileId: "ia6MfaZjJvLzd3tqIpaqjv",
          token: "figd_uU4l-NsXuOdV0FzeQvKEs5qf-XjH1CX8m9MlFE58",
        );
        print(res);
      });
    });
  });
}
