import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/local/price_local_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/price_socket_remote_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/price_stream_repository.dart';

class ForexPriceSocketRepositoryImpl implements ForexPriceSocketRepository {
  final PriceSocketRemoteDataSource _priceSocketRemoteDataSource;
  final PriceLocalDataSource _priceLocalDataSource;
  final List<String> _subscribedSymbols = [];

  ForexPriceSocketRepositoryImpl({
    required PriceSocketRemoteDataSource priceSocketRemoteDataSource,
    required PriceLocalDataSource priceLocalDataSource,
  })  : _priceSocketRemoteDataSource = priceSocketRemoteDataSource,
        _priceLocalDataSource = priceLocalDataSource;

  @override
  Stream<ForexPrice?> subscribeToSymbol(String symbol) async* {
    final cachedPrice = _priceLocalDataSource.getStoredPrice(symbol: symbol);
    if (cachedPrice != null) {
      yield ForexPrice(symbol: symbol, price: cachedPrice);
    }

    if (!_subscribedSymbols.contains(symbol)) {
      await _priceSocketRemoteDataSource.subscribeToSymbol(symbol);
      _subscribedSymbols.add(symbol);
    }

    // Listen to WebSocket updates and map them to ForexPrice
    await for (final message in _priceSocketRemoteDataSource.priceUpdates) {
      try {
        if (message['type'] == 'trade') {
          List<dynamic> data = message['data'];
          for (var priceData in data) {
            var forexPrice = ForexPrice(
              symbol: priceData['s'],
              price: (priceData['p'] as num).toDouble(),
            );
            _priceLocalDataSource.storePrice(price: forexPrice.price, symbol: forexPrice.symbol);
            yield forexPrice;
          }
        } else {
          yield null;
        }
      } catch (e) {
        print('Error processing data: $e');
        yield null;
      }
    }
  }
}
