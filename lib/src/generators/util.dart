bool ensureSameKeys(List<Map<String, int>> maps) {
  if (maps.isEmpty) return true;
  final firstKeys = maps[0].keys.toSet();
  for (final map in maps) {
    final keys = map.keys.toSet();
    if (!keys.containsAll(firstKeys) || !firstKeys.containsAll(keys)) {
      return false;
    }
  }
  return true;
}
