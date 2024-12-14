import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/price_stream_repository.dart';

abstract class ForexPriceUsecase {
  Stream<ForexPrice?> subscribeToSymbol(String symbol);
}

class ForexPriceUsecaseImpl implements ForexPriceUsecase {
  final ForexPriceSocketRepository repository;

  ForexPriceUsecaseImpl(this.repository);

  @override
  Stream<ForexPrice?> subscribeToSymbol(String symbol) {
    return repository.subscribeToSymbol(symbol);
  }
}
