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
