import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/forex_symbols_repository.dart';

abstract class ForexSymbolsUsecase {
  Future<List<ForexSymbol>> getSymbols({required String exchange});
}

class ForexSymbolsUsecaseImpl implements ForexSymbolsUsecase {

  final ForexSymbolsRepository _symbolsRepository;

  ForexSymbolsUsecaseImpl({required ForexSymbolsRepository symbolsRepository}) : _symbolsRepository = symbolsRepository;

  @override
  Future<List<ForexSymbol>> getSymbols({required String exchange}) async => _symbolsRepository.getSymbols(exchange);
  
}