import 'package:app_scope/dependencies.dart';
import 'package:auth/dependencies.dart';
import 'package:common/constants.dart';
import 'package:common/ui.dart';
import 'package:flutter/material.dart';
import 'package:user_scope/dependencies.dart';

import '../../concurency_demo/ui/concurency_demo_screen.dart';

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
            _Description(),
            _AppSettingsView(),
            _UserSettingsView(),
            _AuthSelector(),
            Divider(),
            _OneMoreScreen(),
            Divider(),
            _ConcurencyDemo(),
          ],
        ),
      );
}

class _Greetings extends StatelessWidget {
  const _Greetings();

  @override
  Widget build(BuildContext context) => ListTile(
        title: Builder(
          builder: (context) => DefaultTextStyle(
            style: DefaultTextStyle.of(context).style.apply(
                  fontSizeFactor: 1.8,
                  fontWeightDelta: 2,
                ),
            child: Text(
              'Hello ${User.of(context).name}',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}

class _Description extends StatelessWidget {
  const _Description();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(Sizes.defaultSpacing),
        child: Text(Strings.homeDescription),
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
        UserSettings.update(
          context,
          settings.copyWith(someProperty: value),
        );
      },
    );
  }
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
                Auth.of(context).login(Strings.user1);
              },
              child: const Text(Strings.user1),
            ),
            ElevatedButton(
              onPressed: () {
                Auth.of(context).login(Strings.user2);
              },
              child: const Text(Strings.user2),
            ),
            ElevatedButton(
              onPressed: () {
                Auth.of(context).logout();
              },
              child: const Text(Strings.logout),
            ),
          ],
        ),
      );
}

class _OneMoreScreen extends StatelessWidget {
  const _OneMoreScreen();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(Sizes.defaultSpacing),
            child: Text(Strings.oneMoreDescription),
          ),
          ListTile(
            title: ElevatedButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NavigationNode(
                      child: HomeScreen(),
                    ),
                  ),
                );
              },
              child: const Text(Strings.oneMoreScreen),
            ),
          ),
        ],
      );
}

class _ConcurencyDemo extends StatelessWidget {
  const _ConcurencyDemo();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(Sizes.defaultSpacing),
            child: Text(Strings.concurencyDemoHomeDescription),
          ),
          ListTile(
            title: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const ConcurencyDemoScreen(),
                  ),
                );
              },
              child: const Text(Strings.concurencyDemoTitle),
            ),
          ),
        ],
      );
}
