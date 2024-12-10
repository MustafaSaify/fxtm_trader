import 'package:dio/dio.dart';
import 'package:fxtm_trader/src/core/constants/network_constants.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/models/forex_symbol_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'forex_symbols_service.g.dart';

@RestApi(baseUrl: NetworkConstants.baseUrl)
abstract class ForexSymbolsService {
  factory ForexSymbolsService(
    Dio dio,
    {required String baseUrl}
  ) = _ForexSymbolsService;

  @GET('/forex/symbol')
  Future<List<ForexSymbolDto>> getSymbols(@Query('exchange') String exchange, @Query('token') String token);
}
