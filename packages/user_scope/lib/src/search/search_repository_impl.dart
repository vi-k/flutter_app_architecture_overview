import 'dart:async';
import 'dart:math';

import 'package:app_scope/core.dart';

import 'search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRepositoryImpl(this.user);

  final UserData user;

  final random = Random();

  @override
  Future<void> init() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<void> dispose() async {}

  @override
  Future<List<String>> search(String text) async {
    await Future<void>.delayed(
      Duration(milliseconds: random.nextInt(1000)),
    );

    return [text];
  }
}
