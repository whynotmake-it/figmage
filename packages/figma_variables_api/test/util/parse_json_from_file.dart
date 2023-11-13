//helper function to load json
import 'dart:convert';
import 'dart:io';

(T, Map<String, dynamic>) parseJsonFromFile<T>(
  String relativePath,
  T Function(Map<String, dynamic>) fromJson,
) {
  final currentDirectory = Directory.current.path;
  final filePath = '$currentDirectory/test/src/mock_data/$relativePath';

  final jsonString = File(filePath).readAsStringSync();
  final jsonMap = json.decode(jsonString);

  return (fromJson(jsonMap), jsonMap);
}
