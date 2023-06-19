import 'package:app_scope/core.dart';
import 'package:app_scope/dependencies.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({
    super.key,
    required this.notAuthorized,
    required this.authorized,
  });

  final Widget Function(BuildContext context) notAuthorized;
  final Widget Function(BuildContext context, UserData user) authorized;

  static AuthState of(BuildContext context) =>
      context.findAncestorStateOfType<AuthState>()!;

  @override
  State<Auth> createState() => AuthState();
}

class AuthState extends State<Auth> {
  late final AuthRepository _authRepository;

  Future<void> login(String name) => _authRepository.login(name);

  Future<void> logout() => _authRepository.logout();

  @override
  void initState() {
    super.initState();

    _authRepository = AppScope.of(context).authRepository;
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<UserData?>(
        stream: _authRepository.userChanges,
        builder: (context, snapshot) {
          final user = snapshot.data;

          return user == null
              ? widget.notAuthorized(context)
              : widget.authorized(context, user);
        },
      );
}
