import 'package:app_scope/core.dart';
import 'package:user_scope/core.dart';

import '../concurency_demo/concurency_demo_repository_impl.dart';
import '../user_settings/user_settings_repository_impl.dart';
import 'user_scope_state.dart';

final class UserScopeDependenciesImpl implements UserScopeDependencies {
  UserScopeDependenciesImpl._(
    this.userSettingsRepository,
    this.initialUserSettings,
    this.concurencyDemoRepository,
  );

  @override
  final UserSettingsRepository userSettingsRepository;

  @override
  final UserSettingsData initialUserSettings;

  @override
  final ConcurencyDemoRepository concurencyDemoRepository;

  static Stream<UserScopeState> init(UserData user) async* {
    UserSettingsRepository? userSettingsRepository;
    ConcurencyDemoRepository? concurencyDemoRepository;

    try {
      yield const UserScopeInitialization('settings');
      userSettingsRepository = UserSettingsRepositoryImpl(user);
      await userSettingsRepository.init();
      final initialUserSettings = await userSettingsRepository.load();

      yield const UserScopeInitialization('concurency demo');
      concurencyDemoRepository = ConcurencyDemoRepositoryImpl(user);
      await concurencyDemoRepository.init();

      yield UserScopeInitialized(
        UserScopeDependenciesImpl._(
          userSettingsRepository,
          initialUserSettings,
          concurencyDemoRepository,
        ),
      );
    } on Object {
      await Future.wait(
        [
          userSettingsRepository?.dispose(),
          concurencyDemoRepository?.dispose(),
        ].whereType(),
      );

      rethrow;
    }
  }

  @override
  Future<void> dispose() => Future.wait(
        [
          userSettingsRepository.dispose(),
          concurencyDemoRepository.dispose(),
        ],
      );
}
