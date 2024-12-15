import 'package:fxtm_trader/src/features/forex_history/domain/entities/candle.dart';
import 'package:fxtm_trader/src/features/forex_history/domain/repository/candle_repository.dart';

abstract class GetCandleDataUseCase {
  Future<List<Candle>> call(String symbol);
}

class GetCandleDataUseCaseImpl implements GetCandleDataUseCase {
  final CandleRepository repository;

  GetCandleDataUseCaseImpl(this.repository);

  @override
  Future<List<Candle>> call(String symbol) async {
    return repository.fetchCandleData(symbol);
  }
}
