import 'search/search_repository.dart';
import 'user_settings/user_settings_data.dart';
import 'user_settings/user_settings_repository.dart';

abstract interface class UserScopeDependencies {
  UserSettingsRepository get userSettingsRepository;
  UserSettingsData get initialUserSettings;
  SearchRepository get searchRepository;

  Future<void> dispose();
}
