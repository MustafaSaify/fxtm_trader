import 'package:fxtm_trader/src/core/network/network_client.dart';
import 'package:fxtm_trader/src/features/forex_history/data/models/candle_model.dart';

abstract class CandleRemoteDatasource {
  Future<List<CandleModel>> getCandleStickData(String symbol);
}

class CandleRemoteDatasourceImpl implements CandleRemoteDatasource {

  final NetworkClient networkClient;

  CandleRemoteDatasourceImpl({required this.networkClient});

  @override
  Future<List<CandleModel>> getCandleStickData(String symbol) async {
    final response = await networkClient.get(
      path: '/forex/candles', 
      queryParameters: {'symbol': symbol},
      fromJson: (json) => (json as List<dynamic>)
        .map((item) => CandleModel.fromResponse(item as Map<String, dynamic>))
        .expand((candleModel) => candleModel)
        .toList(),
    );
    return response.data ?? [];
  }
}