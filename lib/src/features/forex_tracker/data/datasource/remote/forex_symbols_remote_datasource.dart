import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/services/forex_symbols_service.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/models/forex_symbol_dto.dart';

abstract class ForexSymbolsRemoteDataSource {
  Future<List<ForexSymbolDto>> getSymbols({required String exchange});
}

class ForexSymbolsRemoteDataSourceImpl implements ForexSymbolsRemoteDataSource {
  final String _apiToken;
  final ForexSymbolsService _forexSymbolsService;

  ForexSymbolsRemoteDataSourceImpl({
    required String apiToken, 
    required ForexSymbolsService forexSymbolsService
  }) : _apiToken = apiToken, _forexSymbolsService = forexSymbolsService;
  
  @override
  Future<List<ForexSymbolDto>> getSymbols({required String exchange}) async {
    final response = await _forexSymbolsService.getSymbols(exchange, _apiToken);
    return response;
  }
}
