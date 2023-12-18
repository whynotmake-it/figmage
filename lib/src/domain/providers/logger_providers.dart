import 'package:mason_logger/mason_logger.dart';
import 'package:riverpod/riverpod.dart';

/// Provides the current [Logger] for the app.
final loggerProvider = Provider<Logger>((ref) => Logger());
