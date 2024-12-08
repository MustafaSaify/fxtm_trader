abstract class PriceStreamDataSource {
  Future<void> connect();
  void disconnect();
  Future<void> subscribeToSymbol(String symbol);
}
