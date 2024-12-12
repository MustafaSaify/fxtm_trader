import 'package:fxtm_trader/src/core/network/network_response.dart';

enum MethodType { get, post, put, delete, patch }

abstract class NetworkClient {
  Future<NetworkResponse<T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  });
}