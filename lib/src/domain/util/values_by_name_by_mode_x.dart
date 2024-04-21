/// Extension methods for [Map<String, Map<String, T?>>] where [T] is a nullable
extension ValuesByNameByModeX<T> on Map<String, Map<String, T?>> {
  /// Returns true, if [valueName] is present and non-null in all modes.
  ///
  /// This means, the token with [valueName] was fully resolvable in all modes.
  bool allModesResolved({required String valueName}) {
    return values.every((valuesByName) => valuesByName[valueName] != null);
  }
}
