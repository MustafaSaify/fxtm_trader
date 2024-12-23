import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/price_stream_repository.dart';

abstract class ForexPriceUsecase {
  Stream<ForexPrice?> subscribeToSymbol(String symbol);
  Stream<List<ForexPrice>?> subscribeToSymbols(List<ForexSymbol> symbols);
}

class ForexPriceUsecaseImpl implements ForexPriceUsecase {
  final ForexPriceSocketRepository repository;

  ForexPriceUsecaseImpl({required this.repository});

  @override
  Stream<ForexPrice?> subscribeToSymbol(String symbol) {
    return repository.subscribeToSymbol(symbol);
  }

  @override
  Stream<List<ForexPrice>?> subscribeToSymbols(List<ForexSymbol> symbols) {
    return repository.subscribeToSymbols(
      symbols.map((item) => item.symbol).toList()
    );
  }
}
