import 'package:figmage/src/domain/models/design_token.dart';
import 'package:figmage/src/domain/models/figmage_settings.dart';
import 'package:figmage/src/domain/models/style/design_style.dart';
import 'package:figmage/src/domain/models/text_style/text_style.dart';
import 'package:figmage/src/domain/models/tokens_by_file_type/tokens_by_file_type.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage/src/domain/providers/logger_providers.dart';
import 'package:figmage/src/domain/repositories/styles_repository.dart';
import 'package:figmage/src/domain/repositories/variables_repository.dart';
import 'package:figmage/src/domain/util/token_filter_x.dart';
import 'package:riverpod/riverpod.dart';

/// Filters all tokens by file type.
final filteredTokensProvider =
    FutureProvider.family<TokensByFileType, FigmageSettings>(
        (ref, settings) async {
  try {
    await ref.watch(variablesProvider(settings).future);
  } catch (_) {}
  final variables = ref.watch(variablesProvider(settings)).valueOrNull ?? [];

  try {
    await ref.watch(stylesProvider(settings).future);
  } catch (_) {}
  final styles = ref.watch(stylesProvider(settings)).valueOrNull ?? [];

  final allTokens = <DesignToken>[...variables, ...styles];
  if (allTokens.isEmpty) {
    throw ArgumentError.value(
      allTokens,
      "Tokens",
      "Neither styles nor variables could be obtained from file "
          "${settings.fileId} ",
    );
  }
  return TokensByFileType(
    colorTokens: allTokens
        .whereType<DesignToken<int>>()
        .filterByFrom(settings.config.colors),
    typographyTokens: allTokens
        .whereType<DesignToken<TextStyle>>()
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
  try {
    final styles = await repo.getStyles(
      fileId: settings.fileId,
      token: settings.token,
    );
    switch (styles) {
      case []:
        stylesProgress.fail("No styles found");
        throw ArgumentError.value(
          styles,
          "styles",
          "No styles found in file ${settings.fileId}",
        );
      case [...]:
        stylesProgress.complete("Found ${styles.length} variables");
        return styles;
    }
  } on StylesException catch (e) {
    stylesProgress.fail("Failed to fetch styles: ${e.message}");
    rethrow;
  } catch (e) {
    stylesProgress.fail("Failed to fetch styles for unknown reason: $e");
    rethrow;
  }
});
