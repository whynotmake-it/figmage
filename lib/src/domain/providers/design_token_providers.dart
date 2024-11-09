import 'dart:io';

import 'package:figmage/src/data/util/converters/string_dart_conversion_x.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/figmage_settings.dart';
import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:figmage/src/domain/models/tokens_by_file_type/tokens_by_type.dart';
import 'package:figmage/src/domain/models/typography/typography.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/repositories/assets_repository.dart';
import 'package:figmage/src/domain/repositories/styles_repository.dart';
import 'package:figmage/src/domain/repositories/variables_repository.dart';
import 'package:figmage/src/domain/util/token_filter_x.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:riverpod/riverpod.dart';

/// Provides [TokensByType] based on [FigmageSettings].
/// If true, omits tokens missing in any mode, ensuring null safety.
/// If false, includes all tokens, with unresolved ones returning null.
final filterUnresolvedTokensProvider =
    FutureProvider.family<TokensByType, FigmageSettings>((ref, settings) async {
  final logger = ref.watch(loggerProvider);

  final tokensByType = await ref.watch(filteredTokensProvider(settings).future);
  tokensByType.asMap().forEach((name, tokens) {
    final unresolvedTokens = tokens.getUnresolvedTokens();
    if (unresolvedTokens.isNotEmpty) {
      logger.warn(
          ' Found ${unresolvedTokens.length} ${name.toTitleCase()} where the'
          '  value is, at least for one mode, unresolvable.');
      if (logger.level == Level.verbose) {
        for (final token in unresolvedTokens) {
          logger.info(' ${token.fullName}:');
          token.valuesByModeName.forEach((modeName, value) {
            logger.info('   $modeName : $value');
          });
        }
      }
    }
  });
  return settings.config.dropUnresolved
      ? tokensByType.resolvable
      : tokensByType;
});

/// Filters all tokens by file type.
final filteredTokensProvider =
    FutureProvider.family<TokensByType, FigmageSettings>((ref, settings) async {
  late final Iterable<Variable> variables;
  try {
    variables = await ref.watch(variablesProvider(settings).future);
  } catch (_) {
    variables = [];
  }

  late final Iterable<DesignStyle> styles;
  try {
    styles = await ref.watch(stylesProvider(settings).future);
  } catch (_) {
    styles = [];
  }

  final allTokens = <DesignToken>[...variables, ...styles];
  if (allTokens.isEmpty) {
    throw ArgumentError.value(
      allTokens,
      "Tokens",
      "Neither styles nor variables could be obtained from file "
          "${settings.fileId} ",
    );
  }
  return TokensByType(
    colorTokens: allTokens
        .whereType<DesignToken<int>>()
        .filterByFrom(settings.config.colors),
    typographyTokens: allTokens
        .whereType<DesignToken<Typography>>()
        .filterByFrom(settings.config.typography),
    numberTokens: allTokens
        .whereType<DesignToken<double>>()
        .filterByFrom(settings.config.numbers),
    stringTokens: allTokens
        .whereType<DesignToken<String>>()
        .filterByFrom(settings.config.strings),
    boolTokens: allTokens
        .whereType<DesignToken<bool>>()
        .filterByFrom(settings.config.bools),
  );
});

/// Provides a Iterable of all variables obtained from the file in
/// [FigmageSettings].
///
/// This provider doesn't filter for anything yet.
final variablesProvider =
    FutureProvider.family<Iterable<Variable>, FigmageSettings>(
        (ref, settings) async {
  final logger = ref.watch(loggerProvider);
  final repo = ref.watch(variablesRepositoryProvider);
  final varProgress = logger.progress("Fetching all variables...");
  try {
    final variables = await repo.getVariables(
      fileId: settings.fileId,
      token: settings.token,
    );
    switch (variables) {
      case []:
        varProgress.fail("No variables found");
        throw ArgumentError.value(
          variables,
          "variables",
          "No variables found in file ${settings.fileId}",
        );
      case [...]:
        varProgress.complete("Found ${variables.length} variables");
        return variables;
    }
  } on VariablesException catch (e) {
    varProgress.fail("Failed to fetch variables: ${e.message}");
    rethrow;
  } catch (e) {
    varProgress.fail("Failed to fetch variables for unknown reason ($e)");
    rethrow;
  }
});

/// Provides a map of downloaded assets from the file in [FigmageSettings].
///
/// Returns a map of node IDs to their downloaded asset file paths (per scale).
final assetsProvider =
    FutureProvider.family<Map<String, List<String>>, FigmageSettings>(
        (ref, settings) async {
  final logger = ref.watch(loggerProvider);
  final repo = ref.watch(assetsRepositoryProvider);
  final assetsProgress = logger.progress("Downloading assets...");

  try {
    if (settings.config.assets.nodes.isEmpty) {
      assetsProgress
          .fail("No assets specified in figmage.yaml - nothing to download");
      return {};
    }
    // Scale must be a number between 0.01 and 4
    if (settings.config.assets.nodes.entries
        .any((e) => e.value.scales.any((s) => s < 0.01 || s > 4))) {
      logger.warn(
        """
Figma only supports scale values between 0.01 and 4, values out of this range will be ignored""",
      );
    }

    final assets = await repo.fetchAndSaveAssets(
      fileId: settings.fileId,
      token: settings.token,
      nodeSettings: settings.config.assets.nodes,
      outputDir: Directory('${settings.path}/assets'),
    );
    assetsProgress.update('Download complete.');
    if (assets.values.any((l) => l.contains(null))) {
      logger.warn(
        '''
Some assets failed to render. This may be due to: 
  - Invalid node IDs  
  - Nodes with no renderable components (e.g., invisible nodes or nodes with 0% opacity)
  ''',
      );
      for (final asset in assets.entries.where((e) => e.value.contains(null))) {
        logger.warn('${asset.key} could not be rendered');
      }
    }

    // Remove all entries where rendering failed.
    final successAssets = {
      for (final entry in assets.entries)
        // Create a filtered list without nulls
        if (entry.value.whereType<String>().isNotEmpty)
          entry.key: entry.value.whereType<String>().toList(),
    };

    if (successAssets.isEmpty) {
      assetsProgress.fail("No assets downloaded");
      return {};
    } else {
      assetsProgress.complete(
        "Downloaded ${successAssets.length} assets",
      );
      return successAssets;
    }
  } on AssetsException catch (e) {
    assetsProgress.fail("Failed to download assets: ${e.message}");
    return {};
  } catch (e) {
    assetsProgress.fail("Failed to download assets for unknown reason ($e)");
    return {};
  }
});

/// Provides a Iterable of all styles obtained from the file in
/// [FigmageSettings].
///
/// This provider doesn't filter for anything yet.
final stylesProvider =
    FutureProvider.family<Iterable<DesignStyle>, FigmageSettings>(
        (ref, settings) async {
  final logger = ref.watch(loggerProvider);
  final repo = ref.watch(stylesRepositoryProvider);
  final stylesProgress = logger.progress("Fetching all styles...");

  final List<DesignStyle<dynamic>> styles;
  try {
    styles = await repo.getStyles(
      fileId: settings.fileId,
      token: settings.token,
      fromLibrary: settings.config.stylesFromLibrary,
    );
  } on StylesException catch (e) {
    stylesProgress.fail("Failed to fetch styles: ${e.message}");
    rethrow;
  } catch (e) {
    stylesProgress.fail("Failed to fetch styles for unknown reason ($e)");
    rethrow;
  }

  switch (styles) {
    case []:
      stylesProgress.fail("No styles found");
      throw ArgumentError.value(
        styles,
        "styles",
        "No styles found in file ${settings.fileId}",
      );
    case [...]:
      stylesProgress.complete("Found ${styles.length} styles");
      return styles;
  }
});
