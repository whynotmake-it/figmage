import 'package:mocktail/mocktail.dart';

/// A helper class to verify provider state changes with mocktail.
class TestListener<T> extends Mock {
  void call(T? previous, T value);
}
