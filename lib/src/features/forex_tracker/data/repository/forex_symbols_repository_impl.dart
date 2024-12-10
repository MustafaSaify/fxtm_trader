import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/forex_symbols_remote_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/forex_symbols_repository.dart';

class ForexSymbolsRepositoryImpl implements ForexSymbolsRepository {
  final ForexSymbolsRemoteDataSource _remoteDataSource;
  ForexSymbolsRepositoryImpl({
    required ForexSymbolsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<List<ForexSymbol>> getSymbols(String exchange) async {
    final symbols = await _remoteDataSource.getSymbols(exchange: exchange);
    return symbols.map((symbolDto) => ForexSymbol(
        symbol: symbolDto.symbol,
        displaySymbol: symbolDto.displaySymbol,
        description: symbolDto.description
      )).toList();
  }
}
