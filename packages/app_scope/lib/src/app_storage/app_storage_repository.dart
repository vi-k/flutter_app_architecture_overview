abstract interface class AppStorageRepository {
  Future<void> init();
  Future<void> dispose();
}
