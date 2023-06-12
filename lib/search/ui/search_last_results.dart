// import 'dart:async';

// import 'package:common/constants.dart';
// import 'package:flutter/material.dart';

// import 'search_screen.dart';

// class SearchLastResults extends StatelessWidget {
//   const SearchLastResults({super.key});

//   static Future<void> show(BuildContext context) => showDialog<void>(
//         context: context,
//         useRootNavigator: false,
//         builder: (context) => const SearchLastResults(),
//       );

//   @override
//   Widget build(BuildContext context) {
//     final screenState = SearchScreen.of(context);

//     return AlertDialog(
//       title: const Text(Strings.searchLastResults),
//       content: ListenableBuilder(
//         listenable: screenState.searchObservable,
//         builder: (_, __) => StreamBuilder(
//           initialData: screenState.searchPublisher.state,
//           stream: screenState.searchPublisher.stream,
//           builder: (_, publisherSnapshot) => StreamBuilder(
//             initialData: screenState.searchBloc.state,
//             stream: screenState.searchBloc.stream,
//             builder: (_, blocSnapshot) {
//               final (a, b, c) = (
//                 screenState.searchObservable.state.history.firstOrNull ?? '',
//                 publisherSnapshot.requireData.history.firstOrNull ?? '',
//                 blocSnapshot.requireData.history.firstOrNull ?? ''
//               );

//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('SearchObservable: $a'),
//                   Text('SearchPublisher: $b'),
//                   Text('SearchBloc: $c'),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//       actions: [
//         ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text(Strings.ok),
//         ),
//       ],
//     );
//   }
// }
