import 'dart:async';

import 'package:app_scope/core.dart';
import 'package:flutter/material.dart';

import 'app_scope_state.dart';

class AppScope extends StatefulWidget {
  const AppScope({
    super.key,
    required this.init,
    required this.initialization,
    required this.initialized,
  });

  final Stream<AppScopeState> Function() init;
  final Widget Function(BuildContext context, String step) initialization;
  final Widget Function(BuildContext context) initialized;

  static AppScopeDependencies of(BuildContext context) {
    final appScopeDependencies = context
        .getInheritedWidgetOfExactType<_AppScopeInheritedWidget>()
        ?.appScopeDependencies;

    if (appScopeDependencies == null) {
      throw Exception('AppScopeDependencies not found');
    }

    return appScopeDependencies;
  }

  @override
  State<AppScope> createState() => _AppScopeState();
}

class _AppScopeState extends State<AppScope> {
  late final Stream<AppScopeState> _stream = widget.init();

  @override
  Widget build(BuildContext context) => StreamBuilder<AppScopeState>(
        initialData: const AppScopeInitialization('init'),
        stream: _stream,
        builder: (context, snapshot) => switch (snapshot.requireData) {
          AppScopeInitialization(:final step) =>
            widget.initialization(context, step),
          AppScopeInitialized(:final appScopeDependencies) =>
            _AppScopeInheritedWidget(
              appScopeDependencies: appScopeDependencies,
              child: Builder(
                builder: (context) => widget.initialized(context),
              ),
            ),
        },
      );
}

class _AppScopeInheritedWidget extends InheritedWidget {
  const _AppScopeInheritedWidget({
    required this.appScopeDependencies,
    required super.child,
  });

  final AppScopeDependencies appScopeDependencies;

  @override
  bool updateShouldNotify(_AppScopeInheritedWidget oldWidget) => false;
}
