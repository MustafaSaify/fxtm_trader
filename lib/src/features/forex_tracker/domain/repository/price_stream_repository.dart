import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';

abstract class ForexPriceSocketRepository {
  Stream<Map<String, ForexPrice>?> subscribeToSymbols(List<ForexSymbol> symbols);
}
