import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/price_stream_repository.dart';

abstract class GetForexPricesUsecase {
  Stream<Map<String, ForexPrice>?> call(List<ForexSymbol> symbols);
}

class GetForexPricesUsecaseImpl implements GetForexPricesUsecase {
  final ForexPriceSocketRepository repository;

  GetForexPricesUsecaseImpl({required this.repository});

  @override
  Stream<Map<String, ForexPrice>?> call(List<ForexSymbol> symbols) {
    return repository.subscribeToSymbols(symbols);
  }
}
