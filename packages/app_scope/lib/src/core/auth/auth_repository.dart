import 'user_data.dart';

abstract interface class AuthRepository {
  Future<void> init();
  Future<void> dispose();

  Future<void> login(String name);
  Future<void> logout();

  UserData? get user;
  Stream<UserData?> get userChanges;
}
