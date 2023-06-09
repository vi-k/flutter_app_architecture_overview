import 'package:flutter/material.dart';

import '../constants/sizes.dart';

class HorizontalSpacer extends StatelessWidget {
  const HorizontalSpacer({
    super.key,
    this.size = Sizes.defaultSpacing,
  });

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(width: size);
}

class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer({
    super.key,
    this.size = Sizes.defaultSpacing,
  });

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(height: size);
}
