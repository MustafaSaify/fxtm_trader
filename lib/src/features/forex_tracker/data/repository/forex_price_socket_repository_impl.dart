import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/price_socket_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/price_stream_repository.dart';

class ForexPriceSocketRepositoryImpl implements ForexPriceSocketRepository {

  final PriceSocketDataSource _priceSocketDataSource;

  ForexPriceSocketRepositoryImpl({required PriceSocketDataSource priceSocketDataSource}) : _priceSocketDataSource = priceSocketDataSource;

  @override
  Stream<ForexPrice?> subscribeToSymbol(String symbol) async* {
    // Connect and subscribe to a currency
    await _priceSocketDataSource.connect();
    await _priceSocketDataSource.subscribeToSymbol(symbol);
    // Listen to currency updates
    // Listen to WebSocket updates and map them to ForexPrice
    await for (final message in _priceSocketDataSource.priceUpdates) {
      try {
        if (message['type'] == 'trade') {
          List<dynamic> data = message['data'];
          if (data.first['s'] == symbol) {
            yield ForexPrice(
              symbol: symbol,
              price: (data.first['p'] as num).toDouble(),
            );
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
