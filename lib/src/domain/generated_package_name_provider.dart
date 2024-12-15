import 'dart:io';

import 'package:figmage/src/domain/models/figmage_settings.dart';
import 'package:figmage/src/domain/shared/dart_symbol_conversion.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';

/// Provides the name of the generated package
final generatedPackageNameProvider = Provider.family<String, FigmageSettings>(
  (ref, settings) {
    final directoryName = basename(Directory(settings.path).absolute.path);
    return settings.config.packageName ??
        toDartPackageName(directoryName, defaultName: 'figmage_package');
  },
);