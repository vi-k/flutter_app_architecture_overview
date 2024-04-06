import 'dart:async';

import 'package:app_scope/core.dart';
import 'package:common/constants.dart';

class AppSettingsRepositoryImpl implements AppSettingsRepository {
  AppSettingsRepositoryImpl();

  @override
  Future<void> init() async {
    await Future<void>.delayed(Constants.demoActionDuration);
  }

  @override
  Future<void> dispose() async {}

  @override
  Future<AppSettingsData> load() async {
    await Future<void>.delayed(Constants.demoActionDuration);

    return const AppSettingsData(someProperty: true);
  }

  @override
  Future<void> save(AppSettingsData settings) async {
    // save settings
  }
}
