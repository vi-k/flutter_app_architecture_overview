import 'dart:async';

import 'package:flutter/material.dart';

class NavigationNode extends StatefulWidget {
  const NavigationNode({
    super.key,
    required this.child,
  });

  final Widget child;

  static NavigationNodeState of(BuildContext context) =>
      context.findAncestorStateOfType<NavigationNodeState>() ??
      (throw Exception('$NavigationNode not fount in the context.'));

  @override
  State<NavigationNode> createState() => NavigationNodeState();
}

class NavigationNodeState extends State<NavigationNode> {
  late final _NodeNavigatorState _navigatorState;
  BackButtonDispatcher? _backButtonDispatcher;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Не в initState из-за подписки в Router.maybeOf
    if (_backButtonDispatcher == null) {
      final parentBackButtonDispatcher =
          Router.maybeOf(context)?.backButtonDispatcher;
      _backButtonDispatcher = parentBackButtonDispatcher
              ?.createChildBackButtonDispatcher() ??
          RootBackButtonDispatcher()
        ..takePriority();
    }
  }

  @override
  Widget build(BuildContext context) => Router<void>(
        routerDelegate: _NodeRouterDelegate(
          node: this,
          child: widget.child,
        ),
        backButtonDispatcher: _backButtonDispatcher,
      );
}

class _NodeRouterDelegate<T> extends RouterDelegate<T> with ChangeNotifier {
  _NodeRouterDelegate({
    required this.node,
    required this.child,
  });

  final NavigationNodeState node;
  final Widget child;

  @override
  Widget build(BuildContext context) => _NodeNavigator(
        pages: [
          _NodeMaterialPage(child: child),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );

  @override
  Future<bool> popRoute() => node._navigatorState.maybePop();

  @override
  Future<void> setNewRoutePath(T configuration) async {}
}

class _NodeNavigator extends Navigator {
  const _NodeNavigator({
    super.pages,
    super.onPopPage,
  });

  @override
  NavigatorState createState() => _NodeNavigatorState();
}

class _NodeNavigatorState extends NavigatorState {
  @override
  _NodeNavigator get widget => super.widget as _NodeNavigator;

  @override
  void initState() {
    super.initState();
    NavigationNode.of(context)._navigatorState = this;
  }

  @override
  bool canPop() => super.canPop() || (prev?.canPop() ?? false);

  // Future<bool> maybePopInsideRoute<T extends Object?>([T? result]) async =>
  //     super.maybePop(result);

  @override
  Future<bool> maybePop<T extends Object?>([T? result]) async =>
      await super.maybePop(result) || (await prev?.maybePop(result) ?? false);
}

class _NodeMaterialPage<T> extends MaterialPage<T> {
  const _NodeMaterialPage({
    required super.child,
    super.maintainState,
    super.fullscreenDialog,
    super.allowSnapshotting,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) =>
      _NodePageBasedMaterialPageRoute<T>(
        page: this,
        allowSnapshotting: allowSnapshotting,
      );
}

class _NodePageBasedMaterialPageRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  _NodePageBasedMaterialPageRoute({
    required _NodeMaterialPage<T> page,
    super.allowSnapshotting,
  }) : super(settings: page) {
    assert(opaque);
  }

  _NodeMaterialPage<T> get _page => settings as _NodeMaterialPage<T>;

  @override
  Widget buildContent(BuildContext context) => _page.child;

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';

  @override
  bool get impliesAppBarDismissal =>
      super.impliesAppBarDismissal || (navigator?.canPop() ?? false);
}

extension PrevNavigatorExtension on NavigatorState {
  NavigatorState? get prev {
    if (!context.mounted) {
      return null;
    }

    NavigatorState? prevNavigator;
    context.visitAncestorElements(
      (element) {
        prevNavigator = Navigator.maybeOf(element);
        return false;
      },
    );

    return prevNavigator;
  }
}
