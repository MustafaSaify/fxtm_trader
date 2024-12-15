import 'package:fxtm_trader/src/features/forex_history/data/datasource/local/candle_local_datasource.dart';
import 'package:fxtm_trader/src/features/forex_history/data/datasource/remote/candle_remote_datasource.dart';
import 'package:fxtm_trader/src/features/forex_history/domain/entities/candle.dart';
import 'package:fxtm_trader/src/features/forex_history/domain/repository/candle_repository.dart';

class CandleRepositoryImpl implements CandleRepository {
  final CandleRemoteDatasource remoteDataSource;
  final CandleLocalDataSource localDataSource;

  CandleRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<List<Candle>> fetchCandleData(String symbol) async {
    // Loading the data from local datasource (json) as the candle api not accessible.
    // In actual scenario, the data would be fetched from api using the remote datasource.
    var candleModels = await localDataSource.loadCandleData();
    if (candleModels.isEmpty) {
      candleModels = await remoteDataSource.getCandleStickData(symbol);
    }
    return candleModels.map((candleModel) => Candle(
        open: candleModel.open,
        high: candleModel.high,
        low: candleModel.low,
        close: candleModel.close,
        timestamp: candleModel.timestamp,
        volume: candleModel.volume,
      )).toList();
  }
}
