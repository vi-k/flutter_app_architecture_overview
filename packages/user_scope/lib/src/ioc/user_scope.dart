import 'dart:async';

import 'package:app_scope/core.dart';
import 'package:flutter/material.dart';

import '../core/user_scope_dependencies.dart';
import '../core/user_scope_state.dart';

class UserScope extends StatefulWidget {
  const UserScope({
    super.key,
    required this.user,
    required this.init,
    required this.initialization,
    required this.initialized,
  });

  final UserData user;
  final Future<void> Function(UserData user) init;
  // final Stream<UserScopeState> Function(UserData user) init;
  final Widget Function(BuildContext context) initialization;
  // final Widget Function(BuildContext context, UserScopeState state)
  // initialization;
  final Widget Function(BuildContext context) initialized;

  static UserScopeDependencies of(BuildContext context) =>
      switch (context.findAncestorStateOfType<_UserScopeState>()?._state) {
        UserScopeInitialized(:final userScopeDependencies) =>
          userScopeDependencies,
        _ => throw Exception('UserScope not found'),
      };

  @override
  State<UserScope> createState() => _UserScopeState();
}

class _UserScopeState extends State<UserScope> {
  bool _initialized = false;
  UserScopeState _state = const UserScopeIdle();

  @override
  void initState() {
    super.initState();

    // ignore: discarded_futures
    widget.init(widget.user).then((value) {
      setState(() {
        _initialized = true;
      });
    });

    // widget.init(widget.user).listen((state) {
    //   setState(() {
    //     _state = state;
    //   });

    //   if (state is UserScopeFailed) {
    //     Error.throwWithStackTrace(state.error, state.stackTrace);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) => !_initialized
      ? widget.initialization(context)
      : widget.initialized(context);

  // @override
  // Widget build(BuildContext context) => _state is! UserScopeInitialized
  //     ? widget.initialization(context, _state)
  //     : UserSettings(
  //         child: Builder(
  //           builder: (context) => widget.initialized(context),
  //         ),
  //       );
}
