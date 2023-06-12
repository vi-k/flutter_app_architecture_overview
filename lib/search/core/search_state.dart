sealed class SearchState {
  SearchState(List<List<String>> history)
      : history = List.unmodifiable(history);

  final List<List<String>> history;
}

final class SearchIdle extends SearchState {
  SearchIdle([super.history = const []]);

  @override
  String toString() => 'SearchIdle($history)';
}

final class SearchInProgress extends SearchState {
  SearchInProgress(super.history, this.text);

  final String text;

  @override
  String toString() => 'SearchInProgress($history, $text)';
}

final class SearchDone extends SearchState {
  SearchDone(super.history);

  @override
  String toString() => 'SearchDone($history)';
}
