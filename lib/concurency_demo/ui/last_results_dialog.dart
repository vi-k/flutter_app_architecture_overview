import 'dart:async';

import 'package:common/constants.dart';
import 'package:common/ui.dart';
import 'package:flutter/material.dart';

import 'concurency_demo_screen.dart';

class LastResultsDialog extends StatelessWidget {
  const LastResultsDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        builder: (context) => const LastResultsDialog(),
      );

  @override
  Widget build(BuildContext context) {
    final screenState = ConcurencyDemoScreen.of(context);

    return AlertDialog(
      title: const Text(Strings.lastResults),
      content: ListenableBuilder(
        listenable: screenState.observable,
        builder: (_, __) => StreamBuilder(
          initialData: screenState.publisher.state,
          stream: screenState.publisher.stream,
          builder: (_, publisherSnapshot) => StreamBuilder(
            initialData: screenState.sequentialBloc.state,
            stream: screenState.sequentialBloc.stream,
            builder: (_, sequentialBlocSnapshot) => StreamBuilder(
              initialData: screenState.restartableBloc.state,
              stream: screenState.restartableBloc.stream,
              builder: (_, restartableBlocSnapshot) {
                final (a, b, c, d) = (
                  screenState.observable.state.history.firstOrNull ?? '-',
                  publisherSnapshot.requireData.history.firstOrNull ?? '-',
                  sequentialBlocSnapshot.requireData.history.firstOrNull ?? '-',
                  restartableBlocSnapshot.requireData.history.firstOrNull ?? '-'
                );

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${Strings.concurencyDemoObservableTitle}: $a'),
                    Text('${Strings.concurencyDemoPublisherTitle}: $b'),
                    Text('${Strings.concurencyDemoBlocTitle}'
                        ' ${Strings.concurencyDemoSequentialBlocSubtitle}:'
                        ' $c'),
                    Text('${Strings.concurencyDemoBlocTitle}'
                        ' ${Strings.concurencyDemoRestartableBlocSubtitle}:'
                        ' $d'),
                    const VerticalSpacer(),
                    const Text(Strings.lastResultsDescription),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(Strings.ok),
        ),
      ],
    );
  }
}
