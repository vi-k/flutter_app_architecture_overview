import 'package:common/constants.dart';
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
            child: Text('Login'),
            // child: Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     // Text('Login'),
            //     Text(Strings.welcome),
            //     VerticalSpacer(size: Sizes.defaultSpacing * 3),
            //     _Users(),
            //   ],
            // ),
          ),
        ),
      );
}

// class _Users extends StatelessWidget {
//   const _Users();

//   @override
//   Widget build(BuildContext context) => Wrap(
//         spacing: Sizes.defaultSpacing,
//         runSpacing: Sizes.defaultSpacing,
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               unawaited(Auth.of(context).login(Strings.user1));
//             },
//             child: const Text(Strings.user1),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               unawaited(Auth.of(context).login(Strings.user2));
//             },
//             child: const Text(Strings.user2),
//           ),
//         ],
//       );
// }
