sealed class ConcurencyDemoState {
  ConcurencyDemoState(List<String> history)
      : history = List.unmodifiable(history);

  final List<String> history;
}

final class ConcurencyDemoIdle extends ConcurencyDemoState {
  ConcurencyDemoIdle([super.history = const []]);

  @override
  String toString() => '$ConcurencyDemoIdle($history)';
}

final class ConcurencyDemoInProgress extends ConcurencyDemoState {
  ConcurencyDemoInProgress(super.history, this.text);

  final String text;

  @override
  String toString() => '$ConcurencyDemoInProgress($history, $text)';
}

final class ConcurencyDemoDone extends ConcurencyDemoState {
  ConcurencyDemoDone(super.history);

  @override
  String toString() => '$ConcurencyDemoDone($history)';
}
