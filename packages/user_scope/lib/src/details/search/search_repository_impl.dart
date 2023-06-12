import 'dart:async';
import 'dart:math';

import 'package:app_scope/core.dart';

import '../../core/search/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRepositoryImpl(this.user);

  final UserData user;

  final random = Random();

  @override
  Future<void> init() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> dispose() async {}

  @override
  Future<List<String>> search(String text) => throw UnimplementedError();
}
