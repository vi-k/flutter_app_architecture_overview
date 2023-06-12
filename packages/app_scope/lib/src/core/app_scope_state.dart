import 'app_scope_dependencies.dart';

sealed class AppScopeState {
  const AppScopeState();
}

final class AppScopeIdle extends AppScopeState {
  const AppScopeIdle();
}

final class AppScopeInitialization extends AppScopeState {
  const AppScopeInitialization(this.step);

  final String step;
}

final class AppScopeInitialized extends AppScopeState {
  const AppScopeInitialized(this.appScopeDependencies);

  final AppScopeDependencies appScopeDependencies;
}

final class AppScopeFailed extends AppScopeState {
  const AppScopeFailed(this.message, this.error, this.stackTrace);

  final String message;
  final Object error;
  final StackTrace stackTrace;
}
