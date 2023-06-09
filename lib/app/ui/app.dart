import 'package:common/constants.dart';
import 'package:flutter/material.dart';

import '../../home/ui/home_screen.dart';

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
        home: const HomeScreen(),
      );
}
