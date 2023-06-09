import 'package:app_scope/core.dart';
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
        body: Center(
          child: _Greetings(widget.user.name),
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
