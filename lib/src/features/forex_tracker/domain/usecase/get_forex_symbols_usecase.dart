import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/forex_symbols_repository.dart';

abstract class GetForexSymbolsUsecase {
  Future<List<ForexSymbol>> call({required String exchange});
}

class GetForexSymbolsUsecaseImpl implements GetForexSymbolsUsecase {
  final ForexSymbolsRepository _symbolsRepository;

  GetForexSymbolsUsecaseImpl(
      {required ForexSymbolsRepository symbolsRepository})
      : _symbolsRepository = symbolsRepository;

  @override
  Future<List<ForexSymbol>> call({required String exchange}) async =>
      _symbolsRepository.getSymbols(exchange);
}
