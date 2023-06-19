import 'user_settings_data.dart';

abstract interface class UserSettingsRepository {
  Future<void> init();
  Future<void> dispose();

  Future<UserSettingsData> load();
  Future<void> save(UserSettingsData settings);
}
