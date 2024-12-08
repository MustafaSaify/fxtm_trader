import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/forex_symbol_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/forex_symbols_repository.dart';

class ForexSymbolsRepositoryImpl implements ForexSymbolsRepository {
  final ForexSymbolDataSource _symbolDataSource;
  ForexSymbolsRepositoryImpl({
    required ForexSymbolDataSource symbolDataSource,
  }) : _symbolDataSource = symbolDataSource;

  @override
  Future<List<ForexSymbol>> getSymbols(String exchange) async {
    final symbols = await _symbolDataSource.getSymbols(exchange: exchange);
    return symbols
        .map((symbol) => ForexSymbol.fromJson(symbol))
        .cast<ForexSymbol>()
        .toList();
  }
}
