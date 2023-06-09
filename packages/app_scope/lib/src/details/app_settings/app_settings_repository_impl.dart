import 'dart:async';

import 'package:app_scope/core.dart';

class AppSettingsRepositoryImpl implements AppSettingsRepository {
  AppSettingsRepositoryImpl();

  @override
  Future<void> init() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> dispose() async {}

  @override
  Future<AppSettingsData> load() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return const AppSettingsData(someProperty: true);
  }

  @override
  Future<void> save(AppSettingsData settings) async {
    // save settings
  }
}
