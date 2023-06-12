import 'dart:async';

import 'package:app_scope/core.dart';
import 'package:user_scope/core.dart';

final _mockUsersStorage = <String, UserSettingsData>{};

class UserSettingsRepositoryImpl implements UserSettingsRepository {
  UserSettingsRepositoryImpl(this.user);

  final UserData user;

  @override
  Future<void> init() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<void> dispose() async {}

  @override
  Future<UserSettingsData> load() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    return _mockUsersStorage[user.name] ??
        const UserSettingsData(someProperty: true);
  }

  @override
  Future<void> save(UserSettingsData settings) async {
    _mockUsersStorage[user.name] = settings;
  }
}
