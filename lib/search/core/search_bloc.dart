import 'dart:async';
import 'dart:developer';

import 'package:rxdart/rxdart.dart';
import 'package:user_scope/core.dart';

import 'search_state.dart';

sealed class SearchEvent {
  const SearchEvent();
}

final class Search extends SearchEvent {
  const Search(this.text);

  final String text;

  @override
  String toString() => 'Search($text)';
}

final class Clear extends SearchEvent {
  const Clear();

  @override
  String toString() => 'Clear()';
}

class SearchBloc implements Sink<SearchEvent> {
  SearchBloc(this.searchRepostitory) : _state = SearchIdle();

  final SearchRepository searchRepostitory;
  final _streamController = StreamController<SearchEvent>();

  SearchState _state;
  SearchState get state => _state;

  @override
  void add(SearchEvent event) => _streamController.sink.add(event);

  @override
  Future<void> close() => _streamController.sink.close();

  late final Stream<SearchState> _stream = _streamController.stream
      .debounceTime(const Duration(milliseconds: 300))
      .map((event) {
        log('event: $event');

        return event;
      })
      // .asyncExpand(mapEventToStates)
      .switchMap(mapEventToStates)
      .map((state) {
        log('state: $state');

        return _state = state;
      })
      .asBroadcastStream();

  Stream<SearchState> get stream => _stream;

  Future<void> dispose() async {
    await _streamController.close();
  }

  Stream<SearchState> mapEventToStates(SearchEvent event) => switch (event) {
        Search() => _search(event),
        Clear() => _clear(event),
      };

  Stream<SearchState> _search(Search event) async* {
    yield SearchInProgress(_state.history, event.text);

    final results = await searchRepostitory.search(event.text);

    final newHistory = [
      results,
      ..._state.history,
    ];

    yield SearchDone(newHistory);
  }

  Stream<SearchState> _clear(Clear event) async* {
    yield SearchIdle();
  }
}
