import 'package:common/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen(
    this.step, {
    super.key,
  });

  final String step;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpacing),
          child: Center(
            child: Text(step),
          ),
        ),
      );
}
