import 'package:flutter/foundation.dart';
import 'package:user_scope/core.dart';

import 'concurency_demo_state.dart';

class ConcurencyDemoObservable with ChangeNotifier {
  ConcurencyDemoObservable(this.concurencyDemoRepostitory)
      : _state = ConcurencyDemoIdle();

  final ConcurencyDemoRepository concurencyDemoRepostitory;

  ConcurencyDemoState _state;
  ConcurencyDemoState get state => _state;

  void _emit(ConcurencyDemoState state) {
    _state = state;
    notifyListeners();
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
