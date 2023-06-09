import 'package:app_scope/core.dart';
import 'package:app_scope/src/details/app_settings/app_settings_repository_impl.dart';
import 'package:app_scope/src/details/app_storage/app_storage_repository_impl.dart';
import 'package:app_scope/src/details/auth/auth_repository_impl.dart';

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
      // инициализация
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
    } on Object catch (error, stackTrace) {
      yield AppScopeFailed('Something went wrong', error, stackTrace);

      await Future.wait(
        [
          appStorageRepository?.dispose(),
          appSettingsRepository?.dispose(),
          authRepository?.dispose(),
        ].whereType(),
      );
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
