import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:riverpod/riverpod.dart';

/// Provides the [FigmagePackageGenerator] instance.
final figmagePackageGeneratorProvider =
    Provider((ref) => const FigmagePackageGenerator());
