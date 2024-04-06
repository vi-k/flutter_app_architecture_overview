abstract interface class ConcurencyDemoRepository {
  Future<void> init();
  Future<void> dispose();

  Future<String> request(String text);
}
