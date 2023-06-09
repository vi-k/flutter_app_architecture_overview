import 'dart:async';

import 'package:flutter/material.dart';

class AppScope extends StatefulWidget {
  const AppScope({
    super.key,
    required this.init,
    required this.initialization,
    required this.initialized,
  });

  final Future<void> Function() init;
  final Widget Function(BuildContext context) initialization;
  final Widget Function(BuildContext context) initialized;

  @override
  State<AppScope> createState() => _AppScopeState();
}

class _AppScopeState extends State<AppScope> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    // ignore: discarded_futures
    widget.init().then((value) {
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
