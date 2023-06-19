import 'package:common/constants.dart';
import 'package:common/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_architecture_overview/search/core/search_observable.dart';
import 'package:flutter_app_architecture_overview/search/ui/search_last_results.dart';
import 'package:user_scope/dependencies.dart';

import '../core/search_bloc.dart';
import '../core/search_publisher.dart';
import '../core/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static SearchScreenState of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<_SearchInheritedWidget>()!.state;

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final textController = TextEditingController();
  final focusNode = FocusNode();
  late final SearchObservable searchObservable;
  late final SearchPublisher searchPublisher;
  late final SearchBloc searchBloc;

  @override
  void initState() {
    super.initState();

    final searchRepostitory = UserScope.of(context).searchRepository;

    searchObservable = SearchObservable(searchRepostitory);
    searchPublisher = SearchPublisher(searchRepostitory);
    searchBloc = SearchBloc(searchRepostitory);
  }

  @override
  void dispose() {
    textController.dispose();
    searchObservable.dispose();
    // ignore: discarded_futures
    searchPublisher.dispose();
    // ignore: discarded_futures
    searchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _SearchInheritedWidget(
        state: this,
        child: const Node(
          child: _Content(),
        ),
      );
}

class _SearchInheritedWidget extends InheritedWidget {
  const _SearchInheritedWidget({
    required this.state,
    required super.child,
  });

  final SearchScreenState state;

  @override
  bool updateShouldNotify(_SearchInheritedWidget oldWidget) => false;
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: const NodeBackButton(),
          title: const Text(Strings.searchTitle),
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
                _SearchInput(),
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

class _SearchInput extends StatelessWidget {
  const _SearchInput();

  @override
  Widget build(BuildContext context) {
    final screenState = SearchScreen.of(context);

    return TextFormField(
      controller: screenState.textController,
      autofocus: true,
      focusNode: screenState.focusNode,
      onChanged: (value) {
        // ignore: discarded_futures
        screenState.searchObservable.search(value);
        // ignore: discarded_futures
        screenState.searchPublisher.search(value);
        screenState.searchBloc.add(Search(value));
      },
      decoration: const InputDecoration(
        label: Text(Strings.searchLabel),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}

class _ResultsColumns extends StatelessWidget {
  const _ResultsColumns();

  @override
  Widget build(BuildContext context) {
    final screenState = SearchScreen.of(context);

    return Row(
      children: [
        Expanded(
          child: ListenableBuilder(
            listenable: screenState.searchObservable,
            builder: (_, __) => _Results(screenState.searchObservable.state),
          ),
        ),
        const VerticalDivider(),
        Expanded(
          child: StreamBuilder(
            initialData: screenState.searchPublisher.state,
            stream: screenState.searchPublisher.stream,
            builder: (_, snapshot) => _Results(snapshot.requireData),
          ),
        ),
        const VerticalDivider(),
        Expanded(
          child: StreamBuilder(
            initialData: screenState.searchBloc.state,
            stream: screenState.searchBloc.stream,
            builder: (_, snapshot) => _Results(snapshot.requireData),
          ),
        ),
      ],
    );
  }
}

class _Results extends StatelessWidget {
  const _Results(this.state);

  final SearchState state;

  @override
  Widget build(BuildContext context) {
    final state = this.state;

    return Column(
      children: [
        if (state is SearchInProgress)
          _Result(
            state.text,
            inProgress: true,
          ),
        Expanded(
          child: ListView.builder(
            itemCount: state.history.length,
            itemBuilder: (_, index) => _Result(state.history[index].toString()),
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
              width: Sizes.searchProgressIndicatorSize,
              height: Sizes.searchProgressIndicatorSize,
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
    final screenState = SearchScreen.of(context);

    return ElevatedButton(
      onPressed: () {
        screenState.focusNode.requestFocus();
        screenState.textController.clear();

        // ignore: discarded_futures
        screenState.searchObservable.clear();
        // ignore: discarded_futures
        screenState.searchPublisher.clear();
        screenState.searchBloc.add(const Clear());
      },
      child: const Text(Strings.searchClear),
    );
  }
}

class _LastResultsButton extends StatelessWidget {
  const _LastResultsButton();

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () {
          // ignore: discarded_futures
          SearchLastResults.show(context);
        },
        icon: const Icon(Icons.info),
      );
}
