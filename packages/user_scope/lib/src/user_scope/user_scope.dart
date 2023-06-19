import 'dart:async';

import 'package:app_scope/core.dart';
import 'package:auth/dependencies.dart';
import 'package:flutter/material.dart';

import 'user_scope_dependencies.dart';
import 'user_scope_state.dart';

class UserScope extends StatefulWidget {
  const UserScope({
    super.key,
    required this.init,
    required this.initialization,
    required this.initialized,
  });

  final Stream<UserScopeState> Function(UserData user) init;
  final Widget Function(BuildContext context, String step) initialization;
  final Widget Function(BuildContext context) initialized;

  static UserScopeDependencies of(BuildContext context) {
    final userScopeDependencies = context
        .getInheritedWidgetOfExactType<_UserScopeInheritedWidget>()
        ?.userScopeDependencies;

    if (userScopeDependencies == null) {
      throw Exception('UserScopeDependencies not found');
    }

    return userScopeDependencies;
  }

  @override
  State<UserScope> createState() => _UserScopeState();
}

class _UserScopeState extends State<UserScope> {
  late final Stream<UserScopeState> _stream;

  @override
  void initState() {
    super.initState();

    final user = User.of(context, listen: false);
    _stream = widget.init(user);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<UserScopeState>(
        initialData: const UserScopeInitialization('init'),
        stream: _stream,
        builder: (context, snapshot) => switch (snapshot.requireData) {
          UserScopeInitialization(:final step) =>
            widget.initialization(context, step),
          UserScopeInitialized(:final userScopeDependencies) =>
            _UserScopeInheritedWidget(
              userScopeDependencies: userScopeDependencies,
              child: Builder(
                builder: (context) => widget.initialized(context),
              ),
            ),
        },
      );
}

class _UserScopeInheritedWidget extends InheritedWidget {
  const _UserScopeInheritedWidget({
    required this.userScopeDependencies,
    required super.child,
  });

  final UserScopeDependencies userScopeDependencies;

  @override
  bool updateShouldNotify(_UserScopeInheritedWidget oldWidget) => false;
}
