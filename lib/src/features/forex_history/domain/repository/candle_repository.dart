import 'package:fxtm_trader/src/features/forex_history/domain/entities/candle.dart';

abstract class CandleRepository {  
  Future<List<Candle>> fetchCandleData(String symbol);
}
