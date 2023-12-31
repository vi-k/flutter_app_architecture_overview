import 'package:app_scope/core.dart';
import 'package:user_scope/core.dart';

import '../search/search_repository_impl.dart';
import '../user_settings/user_settings_repository_impl.dart';
import 'user_scope_state.dart';

final class UserScopeDependenciesImpl implements UserScopeDependencies {
  UserScopeDependenciesImpl._(
    this.userSettingsRepository,
    this.initialUserSettings,
    this.searchRepository,
  );

  @override
  final UserSettingsRepository userSettingsRepository;

  @override
  final UserSettingsData initialUserSettings;

  @override
  final SearchRepository searchRepository;

  static Stream<UserScopeState> init(UserData user) async* {
    UserSettingsRepository? userSettingsRepository;
    SearchRepository? searchRepository;

    try {
      yield const UserScopeInitialization('settings');
      userSettingsRepository = UserSettingsRepositoryImpl(user);
      await userSettingsRepository.init();
      final initialUserSettings = await userSettingsRepository.load();

      yield const UserScopeInitialization('search');
      searchRepository = SearchRepositoryImpl(user);
      await searchRepository.init();

      yield UserScopeInitialized(
        UserScopeDependenciesImpl._(
          userSettingsRepository,
          initialUserSettings,
          searchRepository,
        ),
      );
    } on Object {
      await Future.wait(
        [
          userSettingsRepository?.dispose(),
          searchRepository?.dispose(),
        ].whereType(),
      );

      rethrow;
    }
  }

  @override
  Future<void> dispose() => Future.wait(
        [
          userSettingsRepository.dispose(),
          searchRepository.dispose(),
        ],
      );
}
