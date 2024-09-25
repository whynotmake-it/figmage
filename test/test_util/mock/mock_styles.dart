import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';

const mockColorDesignStyle = ColorDesignStyle(
  id: "color_id",
  fullName: "colors/color_name",
  value: 0xFFFFFFFF,
  useFirstSegmentAsCollection: true,
);

const mockTextDesignStyle = TextDesignStyle(
  id: "text_id",
  fullName: "text_name",
  value: Typography(
    fontFamily: "Inter",
    fontFamilyPostScriptName: "Inter",
    fontSize: 12,
  ),
  useFirstSegmentAsCollection: true,
);

const mockStylesWithCollection = <DesignStyle<dynamic>>[
  mockColorDesignStyle,
  mockTextDesignStyle,
];
