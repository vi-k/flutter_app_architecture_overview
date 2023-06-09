import 'package:app_scope/core.dart';
import 'package:common/constants.dart';
import 'package:common/ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen(
    this.state, {
    super.key,
  });

  final AppScopeState state;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final (background, color) = switch (state) {
      AppScopeFailed() => (colorScheme.error, colorScheme.onError),
      _ => (colorScheme.background, colorScheme.onBackground),
    };

    final content = switch (state) {
      AppScopeInitialization(:final step) => Center(
          child: Text(step),
        ),
      AppScopeFailed(
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
      backgroundColor: background,
      body: DefaultTextStyle(
        style: TextStyle(color: color),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpacing),
          child: content,
        ),
      ),
    );
  }
}
