import 'package:common/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpacing),
          child: Center(
            child: Text('Wait...'),
          ),
        ),
      );
}
