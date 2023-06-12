import 'package:common/constants.dart';
import 'package:common/ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:user_scope/core.dart';

class HomeSplashScreen extends StatelessWidget {
  const HomeSplashScreen(
      // this.state, {
      {
    super.key,
    this.state = const UserScopeIdle(),
  });

  final UserScopeState state;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final (background, color) = switch (state) {
      UserScopeFailed() => (colorScheme.error, colorScheme.onError),
      _ => (colorScheme.background, colorScheme.onBackground),
    };

    final content = switch (state) {
      UserScopeInitialization(:final step) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const VerticalSpacer(),
              Text(step),
            ],
          ),
        ),
      UserScopeFailed(
        :final message,
        :final error,
        :final stackTrace,
      ) =>
        !kDebugMode
            ? Center(
                child: Text(message),
              )
            : ListView(
                children: [
                  Text(message),
                  const VerticalSpacer(),
                  Text(error.toString()),
                  const VerticalSpacer(),
                  Text(stackTrace.toString()),
                ],
              ),
      _ => const SizedBox.shrink(),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.homeTitle),
      ),
      backgroundColor: background,
      body: const Center(
        child: Text('Wait...'),
      ),
      // body: DefaultTextStyle(
      //   style: TextStyle(color: color),
      //   child: Padding(
      //     padding: const EdgeInsets.all(Sizes.defaultSpacing),
      //     child: content,
      //   ),
      // ),
    );
  }
}
