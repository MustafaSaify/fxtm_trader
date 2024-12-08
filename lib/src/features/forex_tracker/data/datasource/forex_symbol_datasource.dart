abstract class ForexSymbolDataSource {
  Future<List<dynamic>> getSymbols({required String exchange});
}