import 'package:user_scope/core.dart';

abstract interface class UserScopeDependencies {
  UserSettingsRepository get userSettingsRepository;
  UserSettingsData get initialUserSettings;
  ConcurencyDemoRepository get concurencyDemoRepository;

  Future<void> dispose();
}
