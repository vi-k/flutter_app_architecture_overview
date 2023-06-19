import 'user_scope_dependencies.dart';

sealed class UserScopeState {
  const UserScopeState();
}

class UserScopeInitialization extends UserScopeState {
  const UserScopeInitialization(this.step);

  final String step;
}

class UserScopeInitialized extends UserScopeState {
  const UserScopeInitialized(this.userScopeDependencies);

  final UserScopeDependencies userScopeDependencies;
}
