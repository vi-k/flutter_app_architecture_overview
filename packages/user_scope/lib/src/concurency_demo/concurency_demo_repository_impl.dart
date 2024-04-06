import 'dart:async';
import 'dart:math';

import 'package:app_scope/core.dart';
import 'package:common/constants.dart';

import 'concurency_demo_repository.dart';

class ConcurencyDemoRepositoryImpl implements ConcurencyDemoRepository {
  ConcurencyDemoRepositoryImpl(this.user);

  final UserData user;

  final random = Random();

  @override
  Future<void> init() async {
    await Future<void>.delayed(Constants.demoActionDuration);
  }

  @override
  Future<void> dispose() async {}

  @override
  Future<String> request(String text) async {
    await Future<void>.delayed(
      Duration(
        milliseconds: random.nextInt(
          Constants.demoRequestMaxDuration.inMilliseconds,
        ),
      ),
    );

    return text.isEmpty ? '(empty)' : text;
  }
}
