import 'app_scope_dependencies.dart';

sealed class AppScopeState {
  const AppScopeState();
}

final class AppScopeInitialization extends AppScopeState {
  const AppScopeInitialization(this.step);

  final String step;
}

final class AppScopeInitialized extends AppScopeState {
  const AppScopeInitialized(this.appScopeDependencies);

  final AppScopeDependencies appScopeDependencies;
}
