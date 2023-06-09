import 'package:app_scope/core.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({
    super.key,
    required this.notAuthorized,
    required this.authorized,
  });

  final Widget Function(BuildContext context) notAuthorized;
  final Widget Function(BuildContext context, UserData user) authorized;

  @override
  State<Auth> createState() => AuthState();
}

class AuthState extends State<Auth> {
  UserData? _user;

  @override
  void initState() {
    super.initState();

    // ignore: discarded_futures
    Future<void>.delayed(const Duration(milliseconds: 3000)).then((_) {
      setState(() {
        _user = const UserData(name: 'User1');
      });
    });
  }

  @override
  Widget build(BuildContext context) => _user == null
      ? widget.notAuthorized(context)
      : widget.authorized(context, _user!);
}
