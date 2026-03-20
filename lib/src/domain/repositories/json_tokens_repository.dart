import 'package:figmage/src/data/repositories/json_tokens_repository.dart';
import 'package:figmage/src/domain/models/design_token.dart';
import 'package:riverpod/riverpod.dart';

/// A provider for a [JsonTokensRepository] that reads tokens from JSON files.
final jsonTokensRepositoryProvider = Provider<JsonTokensRepository>(
  (ref) => const FileJsonTokensRepository(),
);

/// {@template json_tokens_repository}
/// Repository for reading design tokens from JSON files.
/// {@endtemplate}
abstract interface class JsonTokensRepository {
  /// Returns all design tokens from the provided JSON file paths.
  Future<List<DesignToken<dynamic>>> getTokens({
    required Iterable<String> paths,
    void Function(String message)? onDiagnostic,
  });
}
