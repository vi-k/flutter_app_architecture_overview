import 'package:common/constants.dart';
import 'package:common/ui.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) => const _Content();
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: const NodeBackButton(),
          title: const Text(Strings.searchTitle),
          // actions: const [
          //   _LastResultsButton(),
          // ],
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
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              autofocus: true,
              onChanged: (value) {},
              onFieldSubmitted: (value) {},
              decoration: const InputDecoration(
                label: Text(Strings.searchLabel),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
          ),
          const HorizontalSpacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                Strings.searchAuto,
                style: TextStyle(fontSize: 11),
              ),
              Switch(
                value: false,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      );
}

class _ResultsColumns extends StatelessWidget {
  const _ResultsColumns();

  @override
  Widget build(BuildContext context) => const Row(
        children: [
          Expanded(
            child: SizedBox.shrink(),
          ),
          VerticalDivider(),
          Expanded(
            child: SizedBox.shrink(),
          ),
          VerticalDivider(),
          Expanded(
            child: SizedBox.shrink(),
          ),
        ],
      );
}

// class _Results extends StatelessWidget {
//   const _Results(this.state);

//   final SearchState state;

//   @override
//   Widget build(BuildContext context) {
//     final state = this.state;

//     return Column(
//       children: [
//         if (state is SearchInProgress)
//           _Result(
//             state.text,
//             inProgress: true,
//           ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: state.history.length,
//             itemBuilder: (_, index) => _Result(state.history[index].toString()),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _Result extends StatelessWidget {
//   const _Result(
//     this.results, {
//     this.inProgress = false,
//   });

//   final String results;
//   final bool inProgress;

//   @override
//   Widget build(BuildContext context) => Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Expanded(
//             child: Text(
//               results,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//               style: TextStyle(
//                 color: Theme.of(context)
//                     .colorScheme
//                     .onBackground
//                     .withOpacity(inProgress ? 0.5 : 1),
//               ),
//             ),
//           ),
//           if (inProgress) ...const [
//             HorizontalSpacer(),
//             SizedBox(
//               width: Sizes.searchProgressIndicatorSize,
//               height: Sizes.searchProgressIndicatorSize,
//               child: CircularProgressIndicator(),
//             ),
//           ],
//         ],
//       );
// }

class _ClearButton extends StatelessWidget {
  const _ClearButton();

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () {},
        child: const Text(Strings.searchClear),
      );
}

class _LastResultsButton extends StatelessWidget {
  const _LastResultsButton();

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () {
          // SearchLastResults.show(context);
        },
        icon: const Icon(Icons.info),
      );
}
