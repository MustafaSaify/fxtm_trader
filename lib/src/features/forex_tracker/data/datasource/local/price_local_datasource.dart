import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';

abstract class PriceLocalDataSource {
  ForexPrice? getStoredPrice({required String symbol});
  Map<String, ForexPrice> getStoredPrices();
  void storePrice({required ForexPrice price, required String symbol});
}

class PriceLocalDataSourceImpl implements PriceLocalDataSource {

  final Map<String, ForexPrice> _symbolPriceMap = {};
  
  @override
  ForexPrice? getStoredPrice({required String symbol}) {
    return _symbolPriceMap[symbol];
  }

  Map<String, ForexPrice> getStoredPrices() {
    return _symbolPriceMap;
  }

  @override
  void storePrice({required ForexPrice price, required String symbol}) {
    _symbolPriceMap[symbol] = price;
  }
}