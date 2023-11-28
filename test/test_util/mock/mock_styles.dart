import 'package:figma/figma.dart';
import 'package:figmage/src/domain/models/style/design_style.dart';

const mockColorStyle = ColorStyle(
  id: "color_id",
  name: "color_name",
  value: 0xFFFFFFFF,
);

final mockStyles = <DesignStyle<dynamic>>[
  mockColorStyle,
  TextStyle(id: "text_id", name: "text_name", value: TypeStyle()),
];
