import 'package:app_scope/core.dart';
import 'package:flutter/material.dart';

class User extends InheritedWidget {
  const User({
    super.key,
    required super.child,
    required this.user,
  });

  final UserData user;

  static UserData of(
    BuildContext context, {
    bool listen = true,
  }) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<User>()!.user
          : context.getInheritedWidgetOfExactType<User>()!.user;

  @override
  bool updateShouldNotify(User oldWidget) => false;
}
