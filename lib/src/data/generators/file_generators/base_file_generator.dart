import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:figmage/src/data/generators/generator_util.dart';
import 'package:figmage/src/data/util/converters/string_dart_conversion_x.dart';
import 'package:figmage/src/domain/generators/file_generator.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage_package_generator/figmage_package_generator.dart';
import 'package:meta/meta.dart';

/// {@template base_file_generator}
/// A base for all file generators that generate files based on a specific type
/// of design tokens.
/// {@endtemplate}
abstract class BaseFileGenerator<T> implements DesignTokenFileGenerator<T> {
  /// {@macro base_file_generator}
  BaseFileGenerator({
    required this.type,
    required this.tokens,
  });

  @override
  final TokenFileType type;

  @override
  final Iterable<DesignToken<T>> tokens;

  @override
  late Iterable<ThemeClassGenerator> generators = _generators;

  /// Get the class name for a collection name of design tokens for the [type]
  /// of this generator.
  @protected
  String getClassNameForCollection(String collectionName) =>
      getClassNameForCollectionAndType(collectionName, type);

  /// Get the class name for a collection name of design tokens and a [type].
  ///
  /// Can be used to obtain the name for another generator.
  @protected
  String getClassNameForCollectionAndType(
    String collectionName,
    TokenFileType type,
  ) =>
      convertToValidClassName(type.className + collectionName.toTitleCase());

  @override
  List<Spec> generate() {
    return [
      const Code(
        FileGenerator.generatedFilePrefix,
      ),
      for (final g in generators) ...[
        g.generateClass(),
        g.generateExtension(),
      ],
    ];
  }

  /// Build a generator for a collection of design tokens.
  ThemeClassGenerator buildGeneratorForCollection({
    required String collectionName,
    required Iterable<DesignToken<T>> collectionTokens,
  });

  Iterable<ThemeClassGenerator> get _generators sync* {
    final groupedTokens =
        groupBy(tokens, (DesignToken dt) => dt.collectionName);
    for (final MapEntry(key: collectionName, :value) in groupedTokens.entries) {
      yield buildGeneratorForCollection(
        collectionName: collectionName,
        collectionTokens: value,
      );
    }
  }
}
