abstract class PriceLocalDataSource {
  double? getStoredPrice({required String symbol});
  void storePrice({required double price, required String symbol});
}

class PriceLocalDataSourceImpl implements PriceLocalDataSource {

  final Map<String, double> _symbolPriceMap = {};
  
  @override
  double? getStoredPrice({required String symbol}) {
    return _symbolPriceMap[symbol];
  }

  @override
  void storePrice({required double price, required String symbol}) {
    _symbolPriceMap[symbol] = price;
  }
}