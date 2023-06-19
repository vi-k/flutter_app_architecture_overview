import 'package:app_scope/core.dart';

abstract interface class AppScopeDependencies {
  AppStorageRepository get appStorageRepository;
  AppSettingsRepository get appSettingsRepository;
  AppSettingsData get initialAppSettings;
  AuthRepository get authRepository;

  Future<void> dispose();
}
