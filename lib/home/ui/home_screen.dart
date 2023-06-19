import 'package:app_scope/dependencies.dart';
import 'package:auth/dependencies.dart';
import 'package:common/constants.dart';
import 'package:flutter/material.dart';
import 'package:user_scope/dependencies.dart';

import '../../search/ui/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
          children: const [
            _Greetings(),
            _AppSettingsView(),
            _UserSettingsView(),
            _OneMoreScreen(),
            _Search(),
            _AuthSelector(),
          ],
        ),
      );
}

class _Greetings extends StatelessWidget {
  const _Greetings();

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(
          'Hello ${User.of(context).name}',
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

class _UserSettingsView extends StatelessWidget {
  const _UserSettingsView();

  @override
  Widget build(BuildContext context) {
    final settings = UserSettings.of(context);

    return SwitchListTile(
      title: const Text(Strings.userSomeProperty),
      value: settings.someProperty,
      onChanged: (value) {
        // ignore: discarded_futures
        UserSettings.update(
          context,
          settings.copyWith(someProperty: value),
        );
      },
    );
  }
}

class _OneMoreScreen extends StatelessWidget {
  const _OneMoreScreen();

  @override
  Widget build(BuildContext context) => ListTile(
        title: ElevatedButton(
          onPressed: () {
            // ignore: discarded_futures
            Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              ),
            );
          },
          child: const Text(Strings.oneMoreScreen),
        ),
      );
}

class _Search extends StatelessWidget {
  const _Search();

  @override
  Widget build(BuildContext context) => ListTile(
        title: ElevatedButton(
          onPressed: () {
            // ignore: discarded_futures
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const SearchScreen(),
              ),
            );
          },
          child: const Text(Strings.searchTitle),
        ),
      );
}

class _AuthSelector extends StatelessWidget {
  const _AuthSelector();

  @override
  Widget build(BuildContext context) => ListTile(
        title: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: Sizes.defaultSpacing,
          runSpacing: Sizes.defaultSpacing,
          children: [
            ElevatedButton(
              onPressed: () {
                // ignore: discarded_futures
                Auth.of(context).login(Strings.user1);
              },
              child: const Text(Strings.user1),
            ),
            ElevatedButton(
              onPressed: () {
                // ignore: discarded_futures
                Auth.of(context).login(Strings.user2);
              },
              child: const Text(Strings.user2),
            ),
            ElevatedButton(
              onPressed: () {
                // ignore: discarded_futures
                Auth.of(context).logout();
              },
              child: const Text(Strings.logout),
            ),
          ],
        ),
      );
}
