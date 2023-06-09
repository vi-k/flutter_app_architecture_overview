import 'dart:async';

import 'package:app_scope/core.dart';
import 'package:app_scope/src/ioc/app_settings.dart';
import 'package:flutter/material.dart';

class AppScope extends StatefulWidget {
  const AppScope({
    super.key,
    required this.init,
    required this.initialization,
    required this.initialized,
  });

  final Stream<AppScopeState> Function() init;
  final Widget Function(BuildContext context, AppScopeState state)
      initialization;
  final Widget Function(BuildContext context) initialized;

  static AppScopeDependencies of(BuildContext context) =>
      switch (context.findAncestorStateOfType<_AppScopeState>()?._state) {
        AppScopeInitialized(:final appScopeDependencies) =>
          appScopeDependencies,
        _ => throw Exception('AppScope not found'),
      };

  @override
  State<AppScope> createState() => _AppScopeState();
}

class _AppScopeState extends State<AppScope> {
  AppScopeState _state = const AppScopeIdle();

  @override
  void initState() {
    super.initState();

    widget.init().listen((state) {
      setState(() {
        _state = state;
      });

      if (state is AppScopeFailed) {
        Error.throwWithStackTrace(state.error, state.stackTrace);
      }
    });
  }

  @override
  Widget build(BuildContext context) => _state is! AppScopeInitialized
      ? widget.initialization(context, _state)
      : AppSettings(
          child: Builder(
            builder: (context) => widget.initialized(context),
          ),
        );
}
