import 'package:common/constants.dart';
import 'package:common/ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:user_scope/core.dart';
import 'package:user_scope/ioc.dart';

class HomeSplashScreen extends StatelessWidget {
  const HomeSplashScreen(
    this.state, {
    super.key,
  });

  final UserScopeState state;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final (background, color) = switch (state) {
      UserScopeFailed() => (colorScheme.error, colorScheme.onError),
      UserScopeIdle() ||
      UserScopeInitialization() ||
      UserScopeInitialized() =>
        (colorScheme.background, colorScheme.onBackground),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.homeTitle),
      ),
      backgroundColor: background,
      body: DefaultTextStyle(
        style: TextStyle(color: color),
        child: switch (state) {
          UserScopeIdle() => const _Initialization(''),
          UserScopeInitialization(:final step) => _Initialization(step),
          UserScopeInitialized() => const SizedBox.shrink(),
          UserScopeFailed(:final message, :final error, :final stackTrace) =>
            kDebugMode
                ? _DebugFailed(message, error, stackTrace)
                : _Failed(message),
        },
      ),
    );
  }
}

class _Initialization extends StatelessWidget {
  const _Initialization(this.step);

  final String step;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const _Greetings(),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.defaultSpacing),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const VerticalSpacer(),
                    Text(step),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}

class _Greetings extends StatelessWidget {
  const _Greetings();

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(
          'Hello ${User.of(context).name}',
          textAlign: TextAlign.center,
        ),
      );
}

class _Failed extends StatelessWidget {
  const _Failed(this.message);

  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpacing),
          child: Text(message),
        ),
      );
}

class _DebugFailed extends StatelessWidget {
  const _DebugFailed(this.message, this.error, this.stackTrace);

  final String message;
  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(Sizes.defaultSpacing),
        children: [
          Text(message),
          const VerticalSpacer(),
          Text(error.toString()),
          const VerticalSpacer(),
          Text(stackTrace.toString()),
        ],
      );
}
