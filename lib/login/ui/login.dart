import 'package:auth/dependencies.dart';
import 'package:common/constants.dart';
import 'package:common/ui.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpacing),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(Strings.welcome),
                VerticalSpacer(size: Sizes.defaultSpacing * 3),
                _Users(),
              ],
            ),
          ),
        ),
      );
}

class _Users extends StatelessWidget {
  const _Users();

  @override
  Widget build(BuildContext context) => Wrap(
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
        ],
      );
}
