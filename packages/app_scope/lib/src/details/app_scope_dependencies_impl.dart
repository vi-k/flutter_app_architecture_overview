import 'package:app_scope/core.dart';

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

  static Future<void> init() async {
    // AppStorageRepository? appStorageRepository;
    // AppSettingsRepository? appSettingsRepository;
    // AuthRepository? authRepository;

    // try {
    //   // инициализация

    //   AppScopeDependenciesImpl._(
    //     appStorageRepository,
    //     appSettingsRepository,
    //     initialAppSettings,
    //     authRepository,
    //   );
    // } on Object catch (error, stackTrace) {
    //   // обработка ошибки

    //   // dispose репозиториев
    // }
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
