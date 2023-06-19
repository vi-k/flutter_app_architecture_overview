import 'package:app_scope/core.dart';

class AppStorageRepositoryImpl implements AppStorageRepository {
  @override
  Future<void> init() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<void> dispose() async {}
}
