import 'dart:async';

import 'package:app_scope/core.dart';
import 'package:flutter/material.dart';

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
  final Widget Function(BuildContext context) initialization;
  final Widget Function(BuildContext context) initialized;

  @override
  State<UserScope> createState() => _UserScopeState();
}

class _UserScopeState extends State<UserScope> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    // ignore: discarded_futures
    widget.init(widget.user).then((value) {
      setState(() {
        _initialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) => !_initialized
      ? widget.initialization(context)
      : widget.initialized(context);
}
