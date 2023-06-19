import 'package:auth/dependencies.dart';
import 'package:common/constants.dart';
import 'package:common/ui.dart';
import 'package:flutter/material.dart';

class HomeSplashScreen extends StatelessWidget {
  const HomeSplashScreen(
    this.step, {
    super.key,
  });

  final String step;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(Strings.homeTitle),
        ),
        body: Column(
          children: [
            const _Greetings(),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.defaultSpacing),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const VerticalSpacer(),
                      Text(step),
                    ],
                  ),
                ),
              ),
            ),
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
