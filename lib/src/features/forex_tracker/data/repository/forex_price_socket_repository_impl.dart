import 'dart:async';

import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/local/price_local_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/price_socket_remote_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/price_stream_repository.dart';

class ForexPriceSocketRepositoryImpl implements ForexPriceSocketRepository {
  final PriceSocketRemoteDataSource _priceSocketRemoteDataSource;
  final PriceLocalDataSource _priceLocalDataSource;
  final StreamController<Map<String, ForexPrice>?> _priceMapStreamController = StreamController<Map<String, ForexPrice>?>.broadcast();

  ForexPriceSocketRepositoryImpl({
    required PriceSocketRemoteDataSource priceSocketRemoteDataSource,
    required PriceLocalDataSource priceLocalDataSource,
  })  : _priceSocketRemoteDataSource = priceSocketRemoteDataSource,
        _priceLocalDataSource = priceLocalDataSource;

  @override
  Stream<Map<String, ForexPrice>?> subscribeToSymbols(List<ForexSymbol> symbols) async* {
    for (var symbol in symbols) {
      _priceSocketRemoteDataSource.subscribeToSymbol(symbol.symbol);
    }

    // Listen to WebSocket updates and map them to ForexPrice
    _priceSocketRemoteDataSource.priceUpdates.listen((message) {
      try {
        if (message['type'] == 'trade') {
          List<dynamic> data = message['data'];
          for (var priceData in data) {
            var forexPrice = ForexPrice.fromMap(priceData);
            // Cache the price
            _priceLocalDataSource.storePrice(price: forexPrice, symbol: forexPrice.symbol);
          }
          // Return prices from cache.
          _priceMapStreamController.add(_priceLocalDataSource.getStoredPrices());
        }
      } catch (e) {
        print('Error processing data: $e');
      }
    });
    yield* _priceMapStreamController.stream;
  }
}
