import 'app_settings/app_settings_data.dart';
import 'app_settings/app_settings_repository.dart';
import 'app_storage/app_storage_repository.dart';
import 'auth/auth_repository.dart';

abstract interface class AppScopeDependencies {
  AppStorageRepository get appStorageRepository;
  AppSettingsRepository get appSettingsRepository;
  AppSettingsData get initialAppSettings;
  AuthRepository get authRepository;

  Future<void> dispose();
}
