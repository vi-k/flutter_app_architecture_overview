import 'dart:async';
import 'dart:developer';

import 'package:rxdart/rxdart.dart';
import 'package:user_scope/core.dart';

import 'concurency_demo_state.dart';

sealed class ConcurencyDemoEvent {
  const ConcurencyDemoEvent();
}

final class Request extends ConcurencyDemoEvent {
  const Request(this.text);

  final String text;

  @override
  String toString() => '$Request($text)';
}

final class Clear extends ConcurencyDemoEvent {
  const Clear();

  @override
  String toString() => '$Clear()';
}

class ConcurencyDemoBloc implements Sink<ConcurencyDemoEvent> {
  ConcurencyDemoBloc(
    this.concurencyDemoRepostitory, {
    required this.restartable,
  }) : _state = ConcurencyDemoIdle();

  final bool restartable;
  final ConcurencyDemoRepository concurencyDemoRepostitory;
  final _streamController = StreamController<ConcurencyDemoEvent>();

  ConcurencyDemoState _state;
  ConcurencyDemoState get state => _state;

  @override
  void add(ConcurencyDemoEvent event) => _streamController.sink.add(event);

  @override
  Future<void> close() => _streamController.sink.close();

  late final Stream<ConcurencyDemoState> _stream = _streamController.stream
      // .debounceTime(const Duration(milliseconds: 300))
      .map((event) {
        log('event: $event');

        return event;
      })
      .concurencyHandler<ConcurencyDemoState>(
        restartable
            ? (s) => s.switchMap(mapEventToStates)
            : (s) => s.asyncExpand(mapEventToStates),
      )
      .map((state) {
        log('state: $state');

        return _state = state;
      })
      .asBroadcastStream();

  Stream<ConcurencyDemoState> get stream => _stream;

  Future<void> dispose() async {
    await _streamController.close();
  }

  Stream<ConcurencyDemoState> mapEventToStates(ConcurencyDemoEvent event) =>
      switch (event) {
        Request() => _request(event),
        Clear() => _clear(event),
      };

  Stream<ConcurencyDemoState> _request(Request event) async* {
    yield ConcurencyDemoInProgress(_state.history, event.text);

    final results = await concurencyDemoRepostitory.request(event.text);

    final newHistory = [
      results,
      ..._state.history,
    ];

    yield ConcurencyDemoDone(newHistory);
  }

  Stream<ConcurencyDemoState> _clear(Clear event) async* {
    yield ConcurencyDemoIdle();
  }
}

extension _StreamExtension<Event> on Stream<Event> {
  Stream<State> concurencyHandler<State>(
    Stream<State> Function(Stream<Event> s) callback,
  ) =>
      callback(this);
}
