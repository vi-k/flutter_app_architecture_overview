import 'user_scope_dependencies.dart';

sealed class UserScopeState {
  const UserScopeState();
}

class UserScopeIdle extends UserScopeState {
  const UserScopeIdle();
}

class UserScopeInitialization extends UserScopeState {
  const UserScopeInitialization(this.step);

  final String step;
}

class UserScopeInitialized extends UserScopeState {
  const UserScopeInitialized(this.userScopeDependencies);

  final UserScopeDependencies userScopeDependencies;
}

class UserScopeFailed extends UserScopeState {
  const UserScopeFailed(this.message, this.error, this.stackTrace);

  final String message;
  final Object error;
  final StackTrace stackTrace;
}
