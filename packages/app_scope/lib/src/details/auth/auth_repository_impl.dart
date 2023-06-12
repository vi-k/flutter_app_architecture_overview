import 'dart:async';

import 'package:app_scope/core.dart';

class AuthRepositoryImpl implements AuthRepository {
  UserData? _user;
  late final StreamController<UserData?> _controller;

  @override
  UserData? get user => _user;

  @override
  Stream<UserData?> get userChanges => _controller.stream;

  @override
  Future<void> init() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    _controller = StreamController<UserData?>();
  }

  @override
  Future<void> dispose() async {
    await _controller.close();
  }

  @override
  Future<void> login(String name) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    _setUser(UserData(name: name));
  }

  @override
  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    _setUser(null);
  }

  void _setUser(UserData? user) {
    _user = user;
    _controller.add(user);
  }
}
