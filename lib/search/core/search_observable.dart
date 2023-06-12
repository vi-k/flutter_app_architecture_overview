import 'package:flutter/foundation.dart';
import 'package:user_scope/core.dart';

import 'search_state.dart';

class SearchObservable with ChangeNotifier {
  SearchObservable(this.searchRepostitory) : _state = SearchIdle();

  final SearchRepository searchRepostitory;

  SearchState _state;
  SearchState get state => _state;

  void _emit(SearchState state) {
    _state = state;
    notifyListeners();
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
