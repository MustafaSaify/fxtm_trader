import 'package:fxtm_trader/src/core/network/network_client.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/models/forex_symbol_model.dart';

abstract class ForexSymbolsRemoteDataSource {
  Future<List<ForexSymbolModel>> getSymbols({required String exchange});
}

class ForexSymbolsRemoteDataSourceImpl implements ForexSymbolsRemoteDataSource {

  final NetworkClient networkClient;

  ForexSymbolsRemoteDataSourceImpl({required this.networkClient});

  @override
  Future<List<ForexSymbolModel>> getSymbols({required String exchange}) async {
    final response = await networkClient.get(
      path: '/forex/symbol',
      queryParameters: {'exchange': exchange},
      fromJson: (json) => (json as List<dynamic>)
          .map((item) => ForexSymbolModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
    return response.data ?? [];
  }
}
