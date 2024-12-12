import 'package:dio/dio.dart';
import 'package:fxtm_trader/src/core/network/network_client.dart';
import 'package:fxtm_trader/src/core/network/network_config.dart';
import 'package:fxtm_trader/src/core/network/network_response.dart';

class NetworkClientImpl implements NetworkClient {
  
  late Dio _client;

  NetworkClientImpl() {
    _client = Dio()
      ..options.baseUrl = NetworkConfig.baseUrl
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters['token'] =
              NetworkConfig.apiToken;
          return handler.next(options);
        },
      ));
  }

  @override
  Future<NetworkResponse<T>> get<T>({
    required String path, 
    Map<String, dynamic>? queryParameters, 
    T Function(dynamic json)? fromJson}) async
  {
      NetworkResponse<T> apiResponse;
      try {
        var response = await _client.get(
          path, //'https://finnhub.io/api/v1/forex/symbol?exchange=oanda&token=cta05lhr01quh43ovsmgcta05lhr01quh43ovsn0',
          queryParameters: queryParameters,
        );
        print(response);
        apiResponse = NetworkResponse(
          data: fromJson?.call(response.data),
          statusCode: response.statusCode.toString(),
          success: true,
        );
      } catch (e) {
        apiResponse = NetworkResponse<T>.fromError(
        e.toString(),
        e.toString(),
      );
      print(e);
    }
    return apiResponse;
  }
}