import 'package:code_builder/code_builder.dart';
import 'package:figmage/src/generators/theme_extension_generator.dart';

ValueArguments colorFromIntBuilder(int value) {
  return (
    positionalArguments: [refer('0x${value.toRadixString(16)}')],
    namedArguments: const {},
    typeArguments: const []
  );
}
