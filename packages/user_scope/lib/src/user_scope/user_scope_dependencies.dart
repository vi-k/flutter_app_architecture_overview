import 'package:user_scope/core.dart';

abstract interface class UserScopeDependencies {
  UserSettingsRepository get userSettingsRepository;
  UserSettingsData get initialUserSettings;
  SearchRepository get searchRepository;

  Future<void> dispose();
}
