import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';

abstract class ForexSymbolsRepository {
  Future<List<ForexSymbol>> getSymbols(String exchange);
}
