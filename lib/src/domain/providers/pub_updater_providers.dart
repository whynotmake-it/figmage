import 'package:pub_updater/pub_updater.dart';
import 'package:riverpod/riverpod.dart';

/// Provides the [PubUpdater] instance.
final pubUpdaterProvider = Provider((ref) => PubUpdater());
