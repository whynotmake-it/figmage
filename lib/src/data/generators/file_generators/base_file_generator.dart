import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:figmage/src/data/generators/generator_util.dart';
import 'package:figmage/src/data/util/converters/string_dart_conversion_x.dart';
import 'package:figmage/src/domain/generators/file_generator.dart';
import 'package:figmage/src/domain/generators/theme_class_generator.dart';
import 'package:figmage/src/domain/models/config/config.dart';
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
    required this.inheritanceSettings,
    bool Function(String collectionId)? isMixedTokenCollection,
  }) : _isMixedTokenCollection = isMixedTokenCollection ?? _neverMixed;

  @override
  final TokenFileType type;

  @override
  final Iterable<DesignToken<T>> tokens;

  @override
  late Iterable<ThemeClassGenerator> generators = _generators;

  @override
  final Iterable<InheritanceSettings> inheritanceSettings;
  final bool Function(String collectionId) _isMixedTokenCollection;

  /// Get the class name for a collection name of design tokens for the [type]
  /// of this generator.
  @protected
  String getClassNameForCollection(String collectionName) =>
      convertToValidClassName(collectionName);

  /// Get the class name for a collection name of design tokens and a [type].
  ///
  /// Can be used to obtain the name for another generator.
  @protected
  String getClassNameForCollectionAndType(
    String collectionName,
    TokenFileType type,
  ) => convertToValidClassName(type.className + collectionName.toTitleCase());

  /// Returns the deterministic class name for [collectionId] as generated for
  /// [type].
  @protected
  String getClassNameForCollectionIdAndType(
    String collectionId,
    TokenFileType type,
  ) {
    final className = _buildClassNamesForType(type)[collectionId];
    if (className == null) {
      throw StateError('No class name found for collectionId "$collectionId".');
    }
    return className;
  }

  @override
  Library generate() {
    final lib = LibraryBuilder();
    lib.comments.addAll(FileGenerator.generatedFilePrefix);
    lib.body.addAll(
      [
        for (final g in generators) ...[
          g.generateClass(),
          g.generateExtension(),
        ],
      ],
    );
    return lib.build();
  }

  /// Build a generator for a collection of design tokens.
  ThemeClassGenerator buildGeneratorForCollection({
    required String collectionName,
    required Iterable<DesignToken<T>> collectionTokens,
    required Iterable<InterfaceSettings> interfaces,
  });

  Iterable<ThemeClassGenerator> get _generators sync* {
    final groupedTokens = groupBy(
      tokens,
      (DesignToken dt) => dt.collectionId,
    );
    final classNamesByCollectionId = _buildClassNamesForType(type);
    for (final entry in groupedTokens.entries) {
      final className = classNamesByCollectionId[entry.key];
      if (className == null) {
        throw StateError(
          'No class name found for collectionId "${entry.key}".',
        );
      }
      yield buildGeneratorForCollection(
        collectionName: className,
        collectionTokens: entry.value,
        interfaces: _getInterfacesForCollection(
          entry.value.first.collectionName,
        ),
      );
    }
  }

  Map<String, String> _buildClassNamesForType(TokenFileType classType) {
    final groupedTokens = groupBy(
      tokens,
      (DesignToken dt) => dt.collectionId,
    );
    final usedClassNames = <String>{};
    final result = <String, String>{};

    for (final entry in groupedTokens.entries) {
      final classNamePath = _classNamePathForCollection(entry.value);
      final baseClassName = _isMixedTokenCollection(entry.key)
          ? getClassNameForCollectionAndType(classNamePath, classType)
          : convertToValidClassName(classNamePath);
      final className = _getUniqueClassName(baseClassName, usedClassNames);
      usedClassNames.add(className);
      result[entry.key] = className;
    }

    return result;
  }

  String _classNamePathForCollection(
    Iterable<DesignToken<T>> collectionTokens,
  ) {
    final collectionName = collectionTokens.first.collectionName;
    final modeNames = collectionTokens
        .expand((token) => token.valuesByModeName.keys)
        .toSet();
    final segments = collectionName
        .split('/')
        .where((s) => s.isNotEmpty)
        .toList();
    if (segments.length < 2 || modeNames.length != 1) {
      return collectionName;
    }
    return segments.sublist(0, segments.length - 1).join('/');
  }

  String _getUniqueClassName(String name, Set<String> usedNames) {
    if (usedNames.contains(name) == false) {
      return name;
    }
    var index = 1;
    while (usedNames.contains('$name$index')) {
      index += 1;
    }
    return '$name$index';
  }

  Iterable<InterfaceSettings> _getInterfacesForCollection(
    String collectionName,
  ) {
    return inheritanceSettings
        .where(
          (s) =>
              s.appliesToAllCollections ||
              s.collections.contains(collectionName),
        )
        .expand((s) => s.interfaces);
  }
}

bool _neverMixed(String _) => false;
