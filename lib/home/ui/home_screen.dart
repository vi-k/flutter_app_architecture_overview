import 'package:common/constants.dart';
import 'package:flutter/material.dart';

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
        body: const Center(
          child: _Greetings(),
        ),
      );
}

class _Greetings extends StatelessWidget {
  const _Greetings();

  @override
  Widget build(BuildContext context) => const ListTile(
        title: Text(
          'Hello world',
          textAlign: TextAlign.center,
        ),
      );
}
