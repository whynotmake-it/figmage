import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';

class MockProgress extends Mock implements Progress {
  MockProgress.create() {
    when(() => update(any())).thenReturn(null);
    when(() => fail(any())).thenReturn(null);
    when(() => complete(any())).thenReturn(null);
    when(cancel).thenReturn(null);
  }
}

/// Mock implementation of [Logger].
///
/// **Caution:** [progress] will always return the same [MockProgress] instance
/// due to limitations in `pacgage:mocktail`.
class MockLogger extends Mock implements Logger {
  MockLogger.createWithMockProgress(MockProgress mockProgress) {
    when(() => progress(any())).thenReturn(mockProgress);
    when(() => err(any())).thenReturn(null);
    when(() => warn(any())).thenReturn(null);
    when(() => info(any())).thenReturn(null);
    when(() => success(any())).thenReturn(null);
  }
}
