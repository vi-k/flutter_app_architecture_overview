import 'dart:async';

import 'package:user_scope/core.dart';

import 'concurency_demo_state.dart';

class ConcurencyDemoPublisher {
  ConcurencyDemoPublisher(this.concurencyDemoRepostitory)
      : _state = ConcurencyDemoIdle();

  final ConcurencyDemoRepository concurencyDemoRepostitory;
  final _streamController = StreamController<ConcurencyDemoState>.broadcast();

  ConcurencyDemoState _state;
  ConcurencyDemoState get state => _state;

  Stream<ConcurencyDemoState> get stream => _streamController.stream;

  Future<void> dispose() async {
    await _streamController.close();
  }

  void _emit(ConcurencyDemoState state) {
    _state = state;
    _streamController.add(state);
  }

  Future<void> request(String text) async {
    _emit(ConcurencyDemoInProgress(_state.history, text));

    final results = await concurencyDemoRepostitory.request(text);

    final newHistory = [
      results,
      ..._state.history,
    ];

    _emit(ConcurencyDemoDone(newHistory));
  }

  Future<void> clear() async {
    _emit(ConcurencyDemoIdle());
  }
}
