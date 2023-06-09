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
    final settings = AppScope.of(context).initialAppSettings;

    return Text('App someProperty: ${settings.someProperty}');
  }
}
