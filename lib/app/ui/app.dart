import 'package:app_scope/details.dart';
import 'package:app_scope/ioc.dart';
import 'package:auth/ioc.dart';
import 'package:common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_architecture_overview/home/ui/home_splash_screen.dart';
import 'package:user_scope/ioc.dart';

import '../../home/ui/home_screen.dart';
import '../../login/ui/login.dart';
import 'splash_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

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
        home: AppScope(
          init: AppScopeDependenciesImpl.init,
          initialization: (_, state) => SplashScreen(state),
          initialized: (_) => Auth(
            notAuthorized: (_) => const LoginScreen(),
            authorized: (_, user) => UserScope(
              user: user,
              init: (user) =>
                  Future<void>.delayed(const Duration(milliseconds: 3000)),
              initialization: (context) => const HomeSplashScreen(),
              initialized: (context) => HomeScreen(user: user),
            ),
          ),
        ),
      );
}
