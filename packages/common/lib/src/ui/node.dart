import 'dart:async';

import 'package:flutter/material.dart';

class Node extends StatefulWidget {
  const Node({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<Node> createState() => _NodeState();
}

class _NodeState extends State<Node> {
  BackButtonDispatcher? _backButtonDispatcher;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Не в initState из-за подписки в Router.maybeOf
    if (_backButtonDispatcher == null) {
      final parentBackButtonDispatcher =
          Router.maybeOf(context)?.backButtonDispatcher;
      _backButtonDispatcher = parentBackButtonDispatcher == null
          ? RootBackButtonDispatcher()
          : ChildBackButtonDispatcher(parentBackButtonDispatcher)
        ..takePriority();
    }
  }

  @override
  Widget build(BuildContext context) => Router<void>(
        routerDelegate: _NodeRouterDelegate(
          child: widget.child,
        ),
        backButtonDispatcher: _backButtonDispatcher,
      );
}

class _NodeRouterDelegate<T> extends RouterDelegate<T> with ChangeNotifier {
  _NodeRouterDelegate({
    required this.child,
  });

  final Widget child;

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => Navigator(
        key: _navigatorKey,
        pages: [
          MaterialPage(child: child),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );

  @override
  Future<bool> popRoute() async {
    if (_navigatorKey.currentState!.canPop()) {
      await _navigatorKey.currentState?.maybePop();
      return true;
    }

    return false;
  }

  @override
  Future<void> setNewRoutePath(T configuration) async {}
}

class NodeBackButton extends StatelessWidget {
  const NodeBackButton({super.key});

  @override
  Widget build(BuildContext context) => BackButton(
        onPressed: () {
          NavigatorState? navigator = Navigator.of(context);
          if (!navigator.canPop()) {
            navigator.context.visitAncestorElements(
              (element) {
                navigator = Navigator.maybeOf(element);
                return false;
              },
            );
          }
          // ignore: discarded_futures
          navigator?.maybePop();
        },
      );
}
