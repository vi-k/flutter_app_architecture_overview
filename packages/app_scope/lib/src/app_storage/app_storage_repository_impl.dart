import 'package:app_scope/core.dart';
import 'package:common/constants.dart';

class AppStorageRepositoryImpl implements AppStorageRepository {
  @override
  Future<void> init() async {
    await Future<void>.delayed(Constants.demoActionDuration);
  }

  @override
  Future<void> dispose() async {}
}
