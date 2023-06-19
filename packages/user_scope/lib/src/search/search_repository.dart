abstract interface class SearchRepository {
  Future<void> init();
  Future<void> dispose();

  Future<List<String>> search(String text);
}
