import 'dart:async';

import 'package:user_scope/core.dart';

import 'search_state.dart';

class SearchPublisher {
  SearchPublisher(this.searchRepostitory) : _state = SearchIdle();

  final SearchRepository searchRepostitory;
  final _streamController = StreamController<SearchState>.broadcast();

  SearchState _state;
  SearchState get state => _state;

  Stream<SearchState> get stream => _streamController.stream;

  Future<void> dispose() async {
    await _streamController.close();
  }

  void _emit(SearchState state) {
    _state = state;
    _streamController.add(state);
  }

  Future<void> search(String text) async {
    _emit(SearchInProgress(_state.history, text));

    final results = await searchRepostitory.search(text);

    final newHistory = [
      results,
      ..._state.history,
    ];

    _emit(SearchDone(newHistory));
  }

  Future<void> clear() async {
    _emit(SearchIdle());
  }
}
