import 'package:common/constants.dart';
import 'package:common/ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UncaughtExceptions extends StatelessWidget {
  const UncaughtExceptions({
    super.key,
    required this.uncaughtExceptions,
    required this.child,
  });

  final Stream<void> uncaughtExceptions;
  final Widget child;

  @override
  Widget build(BuildContext context) => StreamBuilder<void>(
        stream: uncaughtExceptions,
        builder: (context, snapshot) {
          if (!snapshot.hasError) return child;

          return kDebugMode
              ? const _Failed()
              : _DebugFailed(snapshot.error!, snapshot.stackTrace!);
        },
      );
}

class _Failed extends StatelessWidget {
  const _Failed();

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpacing),
          child: Center(
            child: Text(Strings.uncaughtExceptionTitle),
          ),
        ),
      );
}

class _DebugFailed extends StatelessWidget {
  const _DebugFailed(this.error, this.stackTrace);

  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.error,
      body: DefaultTextStyle(
        style: TextStyle(color: colorScheme.onError),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpacing),
          child: kDebugMode
              ? const Center(
                  child: Text(Strings.uncaughtExceptionTitle),
                )
              : ListView(
                  children: [
                    Text(error.toString()),
                    const VerticalSpacer(),
                    Text(stackTrace.toString()),
                  ],
                ),
        ),
      ),
    );
  }
}
