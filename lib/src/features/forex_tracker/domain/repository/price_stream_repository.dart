abstract class PriceStreamRepository {
  Future<void> connect();
  void disconnect();
  Future<void> subscribeToSymbol(String symbol);
}
