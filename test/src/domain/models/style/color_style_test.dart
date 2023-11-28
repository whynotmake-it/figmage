import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/style/color_style.dart';
import 'package:test/test.dart';

void main() {
  group("ColorStyle", () {
    test("is a DesignToken<int>", () {
      const style = ColorStyle(id: "id", name: "name", value: 0xFFFFFFFF);
      expect(style, isA<DesignToken<int>>());

      expect([style].whereType<DesignToken<int>>(), hasLength(1));
    });
  });
}
