import 'app_settings_data.dart';

abstract interface class AppSettingsRepository {
  Future<void> init();
  Future<void> dispose();

  Future<AppSettingsData> load();
  Future<void> save(AppSettingsData settings);
}
