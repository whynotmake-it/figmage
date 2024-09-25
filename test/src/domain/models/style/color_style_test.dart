import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:test/test.dart';

void main() {
  group("ColorStyle", () {
    const styleWithCollection = ColorDesignStyle(
      id: "id",
      fullName: "colors/dark/color_name",
      value: 0xFFFFFFFF,
      useFirstSegmentAsCollection: true,
    );

    const styleWithoutCollection = ColorDesignStyle(
      id: "id",
      fullName: "colors/dark/color_name",
      value: 0xFFFFFFFF,
      useFirstSegmentAsCollection: false,
    );
    test("is a DesignToken<int>", () {
      expect(styleWithCollection, isA<DesignToken<int>>());
      expect(styleWithoutCollection, isA<DesignToken<int>>());

      expect([styleWithCollection].whereType<DesignToken<int>>(), hasLength(1));
      expect(
        [styleWithoutCollection].whereType<DesignToken<int>>(),
        hasLength(1),
      );
    });

    test("has correct name", () {
      expect(styleWithCollection.name, "dark/color_name");
      expect(styleWithoutCollection.name, "colors/dark/color_name");
    });

    test("has correct collectionName", () {
      expect(styleWithCollection.collectionName, "colors");
      expect(styleWithoutCollection.collectionName, "");
    });
  });
}
