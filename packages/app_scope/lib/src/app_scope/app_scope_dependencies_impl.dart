import 'package:app_scope/core.dart';

import '../app_settings/app_settings_repository_impl.dart';
import '../app_storage/app_storage_repository_impl.dart';
import '../auth/auth_repository_impl.dart';
import 'app_scope_state.dart';

final class AppScopeDependenciesImpl implements AppScopeDependencies {
  AppScopeDependenciesImpl._(
    this.appStorageRepository,
    this.appSettingsRepository,
    this.initialAppSettings,
    this.authRepository,
  );

  @override
  final AppStorageRepository appStorageRepository;

  @override
  final AppSettingsRepository appSettingsRepository;

  @override
  final AppSettingsData initialAppSettings;

  @override
  final AuthRepository authRepository;

  static Stream<AppScopeState> init() async* {
    AppStorageRepository? appStorageRepository;
    AppSettingsRepository? appSettingsRepository;
    AuthRepository? authRepository;

    try {
      yield const AppScopeInitialization('storage');
      appStorageRepository = AppStorageRepositoryImpl();
      await appStorageRepository.init();

      yield const AppScopeInitialization('settings');
      appSettingsRepository = AppSettingsRepositoryImpl();
      await appSettingsRepository.init();
      final initialAppSettings = await appSettingsRepository.load();

      yield const AppScopeInitialization('auth');
      authRepository = AuthRepositoryImpl();
      await authRepository.init();

      yield AppScopeInitialized(
        AppScopeDependenciesImpl._(
          appStorageRepository,
          appSettingsRepository,
          initialAppSettings,
          authRepository,
        ),
      );
    } on Object {
      await Future.wait(
        [
          appStorageRepository?.dispose(),
          appSettingsRepository?.dispose(),
          authRepository?.dispose(),
        ].whereType(),
      );

      rethrow;
    }
  }

  @override
  Future<void> dispose() => Future.wait(
        [
          appStorageRepository.dispose(),
          appSettingsRepository.dispose(),
          authRepository.dispose(),
        ],
      );
}
