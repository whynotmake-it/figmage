import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:figmage/src/domain/models/text_style/text_style.dart';

const mockColorDesignStyle = ColorDesignStyle(
  id: "color_id",
  name: "color_name",
  value: 0xFFFFFFFF,
);

const mockTextDesignStyle = TextDesignStyle(
  id: "text_id",
  name: "text_name",
  value: TextStyle(
    fontFamily: "Inter",
    fontFamilyPostScriptName: "Inter",
    fontSize: 12,
  ),
);

const mockStyles = <DesignStyle<dynamic>>[
  mockColorDesignStyle,
  mockTextDesignStyle,
];
