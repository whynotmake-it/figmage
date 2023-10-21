import 'dart:convert';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';

/// An implementation of [AssetWriter] that writes outputs to memory.
/// And dumps a copy of the content into the console,
/// that is useful when creating tests.
class PrintAssetWriter implements RecordingAssetWriter {
  PrintAssetWriter();

  @override
  final Map<AssetId, List<int>> assets = {};

  @override
  Future writeAsBytes(AssetId id, List<int> bytes) async {
    assets[id] = bytes;
  }

  @override
  Future writeAsString(
    AssetId id,
    String contents, {
    Encoding encoding = utf8,
  }) async {
    print(contents);
    assets[id] = encoding.encode(contents);
  }
}
