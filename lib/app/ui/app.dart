import 'dart:async';

import 'package:app_scope/dependencies.dart';
import 'package:app_scope/implementations.dart';
import 'package:auth/dependencies.dart';
import 'package:common/constants.dart';
import 'package:common/ui.dart';
import 'package:flutter/material.dart';
import 'package:user_scope/dependencies.dart';
import 'package:user_scope/implementations.dart';

import '../../home/ui/home_screen.dart';
import '../../home/ui/home_splash_screen.dart';
import '../../login/ui/login.dart';
import 'splash_screen.dart';
import 'uncaught_exceptions.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.uncaughtExceptions,
  });

  final Stream<void> uncaughtExceptions;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Strings.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            secondary: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: UncaughtExceptions(
          uncaughtExceptions: widget.uncaughtExceptions,
          child: AppScope(
            init: AppScopeDependenciesImpl.init,
            initialization: (_, step) => SplashScreen(step),
            initialized: (_) => AppSettings(
              child: Auth(
                notAuthorized: (_) => const LoginScreen(),
                authorized: (_, user) => User(
                  key: ValueKey(user),
                  user: user,
                  child: UserScope(
                    init: UserScopeDependenciesImpl.init,
                    initialization: (_, step) => HomeSplashScreen(step),
                    initialized: (_) => const UserSettings(
                      child: NavigationNode(
                        child: HomeScreen(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
