import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/price_stream_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/price_stream_repository.dart';

class PriceStreamRepositoryImpl implements PriceStreamRepository {
  final PriceStreamDataSource _priceStreamDataSource;

  PriceStreamRepositoryImpl({required PriceStreamDataSource priceStreamDataSource})
      : _priceStreamDataSource = priceStreamDataSource;

  @override
  Future<void> connect() async => _priceStreamDataSource.connect();

  @override
  void disconnect() => _priceStreamDataSource.disconnect();

  @override
  Future<void> subscribeToSymbol(String symbol) => _priceStreamDataSource.subscribeToSymbol(symbol);
}
