import 'package:common/constants.dart';
import 'package:common/ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UncaughtExceptions extends StatefulWidget {
  const UncaughtExceptions({
    super.key,
    required this.uncaughtExceptions,
    required this.child,
  });

  final Stream<void> uncaughtExceptions;
  final Widget child;

  @override
  State<UncaughtExceptions> createState() => _UncaughtExceptionsState();
}

class _UncaughtExceptionsState extends State<UncaughtExceptions> {
  final _errors = <(Object, StackTrace)>[];

  @override
  void initState() {
    super.initState();

    widget.uncaughtExceptions.listen(
      (event) {},
      // ignore: avoid_types_on_closure_parameters
      onError: (Object error, StackTrace stackTrace) {
        setState(() {
          _errors.insert(0, (error, stackTrace));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) => _errors.isEmpty
      ? widget.child
      : kDebugMode
          ? _DebugFailed(_errors)
          : _Failed(_errors);
}

class _Failed extends StatelessWidget {
  const _Failed(this.errors);

  final List<(Object, StackTrace)> errors;

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
  const _DebugFailed(this.errors);

  final List<(Object, StackTrace)> errors;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.error,
      body: DefaultTextStyle(
        style: TextStyle(color: colorScheme.onError),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpacing),
          child: ListView(
            children: [
              for (final (index, (error, stackTrace)) in errors.indexed) ...[
                if (index != 0) ...[
                  const Divider(),
                ],
                Text(error.toString()),
                const VerticalSpacer(),
                Text(stackTrace.toString()),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
