import 'package:common/constants.dart';
import 'package:common/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_architecture_overview/concurency_demo/core/concurency_demo_observable.dart';
import 'package:flutter_app_architecture_overview/concurency_demo/ui/last_results_dialog.dart';
import 'package:user_scope/dependencies.dart';

import '../core/concurency_demo_bloc.dart';
import '../core/concurency_demo_publisher.dart';
import '../core/concurency_demo_state.dart';

class ConcurencyDemoScreen extends StatefulWidget {
  const ConcurencyDemoScreen({super.key});

  static ConcurencyDemoScreenState of(BuildContext context) => context
      .getInheritedWidgetOfExactType<_ConcurencyDemoScreenInheritedWidget>()!
      .state;

  @override
  State<ConcurencyDemoScreen> createState() => ConcurencyDemoScreenState();
}

class ConcurencyDemoScreenState extends State<ConcurencyDemoScreen> {
  final textController = TextEditingController();
  final focusNode = FocusNode();
  late final ConcurencyDemoObservable observable;
  late final ConcurencyDemoPublisher publisher;
  late final ConcurencyDemoBloc sequentialBloc;
  late final ConcurencyDemoBloc restartableBloc;

  @override
  void initState() {
    super.initState();

    final concurencyDemoRepostitory =
        UserScope.of(context).concurencyDemoRepository;

    observable = ConcurencyDemoObservable(concurencyDemoRepostitory);
    publisher = ConcurencyDemoPublisher(concurencyDemoRepostitory);
    sequentialBloc = ConcurencyDemoBloc(
      concurencyDemoRepostitory,
      restartable: false,
    );
    restartableBloc = ConcurencyDemoBloc(
      concurencyDemoRepostitory,
      restartable: true,
    );
  }

  @override
  void dispose() {
    textController.dispose();
    observable.dispose();
    publisher.dispose();
    sequentialBloc.dispose();
    restartableBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _ConcurencyDemoScreenInheritedWidget(
        state: this,
        child: const NavigationNode(
          child: _Content(),
        ),
      );
}

class _ConcurencyDemoScreenInheritedWidget extends InheritedWidget {
  const _ConcurencyDemoScreenInheritedWidget({
    required this.state,
    required super.child,
  });

  final ConcurencyDemoScreenState state;

  @override
  bool updateShouldNotify(_ConcurencyDemoScreenInheritedWidget oldWidget) =>
      false;
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(Strings.concurencyDemoTitle),
          actions: const [
            _LastResultsButton(),
          ],
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(Sizes.defaultSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Description(),
                _Input(),
                VerticalSpacer(),
                Expanded(
                  child: _ResultsColumns(),
                ),
                _ClearButton(),
              ],
            ),
          ),
        ),
      );
}

class _Description extends StatelessWidget {
  const _Description();

  @override
  Widget build(BuildContext context) =>
      const Text(Strings.concurencyDemoDescription);
}

class _Input extends StatelessWidget {
  const _Input();

  @override
  Widget build(BuildContext context) {
    final screenState = ConcurencyDemoScreen.of(context);

    return TextFormField(
      controller: screenState.textController,
      autofocus: true,
      focusNode: screenState.focusNode,
      onChanged: (value) {
        screenState.observable.request(value);
        screenState.publisher.request(value);
        screenState.sequentialBloc.add(Request(value));
        screenState.restartableBloc.add(Request(value));
      },
      decoration: const InputDecoration(
        label: Text(Strings.concurencyDemoInputLabel),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}

class _ResultsColumns extends StatelessWidget {
  const _ResultsColumns();

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).textTheme.
    final screenState = ConcurencyDemoScreen.of(context);

    return DefaultTextStyle(
      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.9),
      maxLines: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DefaultTextStyle(
            style: DefaultTextStyle.of(context).style.apply(fontWeightDelta: 2),
            maxLines: 1,
            child: const Row(
              children: [
                Expanded(
                  child: Text(Strings.concurencyDemoObservableTitle),
                ),
                HorizontalSpacer(),
                Expanded(
                  child: Text(Strings.concurencyDemoPublisherTitle),
                ),
                HorizontalSpacer(),
                Expanded(
                  child: Text(Strings.concurencyDemoBlocTitle),
                ),
                HorizontalSpacer(),
                Expanded(
                  child: Text(Strings.concurencyDemoBlocTitle),
                ),
              ],
            ),
          ),
          DefaultTextStyle(
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.75),
            maxLines: 1,
            child: const Row(
              children: [
                Expanded(
                  child: Text(Strings.concurencyDemoObservableSubtitle),
                ),
                HorizontalSpacer(),
                Expanded(
                  child: Text(Strings.concurencyDemoPublisherSubtitle),
                ),
                HorizontalSpacer(),
                Expanded(
                  child: Text(Strings.concurencyDemoSequentialBlocSubtitle),
                ),
                HorizontalSpacer(),
                Expanded(
                  child: Text(Strings.concurencyDemoRestartableBlocSubtitle),
                ),
              ],
            ),
          ),
          const VerticalSpacer(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListenableBuilder(
                    listenable: screenState.observable,
                    builder: (_, __) => _Results(screenState.observable.state),
                  ),
                ),
                const HorizontalSpacer(),
                Expanded(
                  child: StreamBuilder(
                    initialData: screenState.publisher.state,
                    stream: screenState.publisher.stream,
                    builder: (_, snapshot) => _Results(snapshot.requireData),
                  ),
                ),
                const HorizontalSpacer(),
                Expanded(
                  child: StreamBuilder(
                    initialData: screenState.sequentialBloc.state,
                    stream: screenState.sequentialBloc.stream,
                    builder: (_, snapshot) => _Results(snapshot.requireData),
                  ),
                ),
                const HorizontalSpacer(),
                Expanded(
                  child: StreamBuilder(
                    initialData: screenState.restartableBloc.state,
                    stream: screenState.restartableBloc.stream,
                    builder: (_, snapshot) => _Results(snapshot.requireData),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Results extends StatelessWidget {
  const _Results(this.state);

  final ConcurencyDemoState state;

  @override
  Widget build(BuildContext context) {
    final state = this.state;

    return Column(
      children: [
        if (state is ConcurencyDemoInProgress)
          _Result(
            state.text,
            inProgress: true,
          ),
        Expanded(
          child: ListView.builder(
            itemCount: state.history.length,
            itemBuilder: (_, index) => _Result(state.history[index]),
          ),
        ),
      ],
    );
  }
}

class _Result extends StatelessWidget {
  const _Result(
    this.results, {
    this.inProgress = false,
  });

  final String results;
  final bool inProgress;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              results,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(inProgress ? 0.5 : 1),
              ),
            ),
          ),
          if (inProgress) ...const [
            HorizontalSpacer(),
            SizedBox(
              width: Sizes.concurencyDemoProgressIndicatorSize,
              height: Sizes.concurencyDemoProgressIndicatorSize,
              child: CircularProgressIndicator(),
            ),
          ],
        ],
      );
}

class _ClearButton extends StatelessWidget {
  const _ClearButton();

  @override
  Widget build(BuildContext context) {
    final screenState = ConcurencyDemoScreen.of(context);

    return ElevatedButton(
      onPressed: () {
        screenState.focusNode.requestFocus();
        screenState.observable.clear();
        screenState.publisher.clear();
        screenState.sequentialBloc.add(const Clear());
        screenState.restartableBloc.add(const Clear());
      },
      child: const Text(Strings.concurencyDemoClearHistory),
    );
  }
}

class _LastResultsButton extends StatelessWidget {
  const _LastResultsButton();

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () {
          LastResultsDialog.show(context);
        },
        icon: const Icon(Icons.info),
      );
}
