import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:test/test.dart';

void main() {
  group("ColorStyle", () {
    const style = ColorDesignStyle(
      id: "id",
      fullName: "colors/color_name",
      value: 0xFFFFFFFF,
    );
    test("is a DesignToken<int>", () {
      expect(style, isA<DesignToken<int>>());

      expect([style].whereType<DesignToken<int>>(), hasLength(1));
    });

    test("has correct name", () {
      expect(style.name, "color_name");
    });

    test("has correct collectionName", () {
      expect(style.collectionName, "colors");
    });
  });
}
