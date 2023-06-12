import 'package:app_scope/core.dart';
import 'package:app_scope/ioc.dart';
import 'package:common/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.user});

  final UserData user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(Strings.homeTitle),
        ),
        body: ListView(
          children: [
            _Greetings(widget.user.name),
            const _AppSettingsView(),
            _OneMoreScreen(widget.user),
          ],
        ),
      );
}

class _Greetings extends StatelessWidget {
  const _Greetings(this.name);

  final String name;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(
          'Hello $name',
          textAlign: TextAlign.center,
        ),
      );
}

class _AppSettingsView extends StatelessWidget {
  const _AppSettingsView();

  @override
  Widget build(BuildContext context) {
    final settings = AppSettings.of(context);

    return SwitchListTile(
      value: settings.someProperty,
      title: const Text(Strings.appSomeProperty),
      onChanged: (value) {
        // ignore: discarded_futures
        AppSettings.update(
          context,
          settings.copyWith(someProperty: value),
        );
      },
    );
  }
}

// class _UserSettingsView extends StatelessWidget {
//   const _UserSettingsView();

//   @override
//   Widget build(BuildContext context) {
//     final settings = UserSettings.of(context);

//     return SwitchListTile(
//       title: const Text('User settings:'),
//       value: settings.someProperty,
//       onChanged: (value) {
//         // ignore: discarded_futures
//         UserSettings.update(
//           context,
//           settings.copyWith(someProperty: value),
//         );
//       },
//     );
//   }
// }

class _OneMoreScreen extends StatelessWidget {
  const _OneMoreScreen(this.user);

  final UserData user;

  @override
  Widget build(BuildContext context) => ListTile(
        title: ElevatedButton(
          onPressed: () {
            // ignore: discarded_futures
            Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(user: user),
              ),
            );
          },
          child: const Text(Strings.oneMoreScreen),
        ),
      );
}

// class _AuthSelector extends StatelessWidget {
//   const _AuthSelector();

//   @override
//   Widget build(BuildContext context) => ListTile(
//         title: Wrap(
//           alignment: WrapAlignment.spaceEvenly,
//           spacing: Sizes.defaultSpacing,
//           runSpacing: Sizes.defaultSpacing,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 // ignore: discarded_futures
//                 Auth.of(context).login(Strings.user1);
//               },
//               child: const Text(Strings.user1),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // ignore: discarded_futures
//                 Auth.of(context).login(Strings.user2);
//               },
//               child: const Text(Strings.user2),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // ignore: discarded_futures
//                 Auth.of(context).logout();
//               },
//               child: const Text(Strings.logout),
//             ),
//           ],
//         ),
//       );
// }
