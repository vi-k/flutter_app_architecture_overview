import 'dart:async';

import 'package:app_scope/core.dart';

import '../../core/user_settings/user_settings_data.dart';
import '../../core/user_settings/user_settings_repository.dart';

class UserSettingsRepositoryImpl implements UserSettingsRepository {
  UserSettingsRepositoryImpl(this.user);

  final UserData user;

  @override
  Future<void> init() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> dispose() async {}

  @override
  Future<UserSettingsData> load() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return const UserSettingsData(someProperty: true);
  }

  @override
  Future<void> save(UserSettingsData settings) async {
    // save settings
  }
}
