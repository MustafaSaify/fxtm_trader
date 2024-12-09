import 'dart:io';

abstract class ForexSymbolDataSource {
  Future<List<dynamic>> getSymbols({required String exchange});
}

class ForexSymbolDataSourceImpl implements ForexSymbolDataSource {

  final HttpClient _httpClient;

  ForexSymbolDataSourceImpl({required HttpClient httpClient}) : _httpClient = httpClient;
  
  @override
  Future<List<dynamic>> getSymbols({required String exchange}) async => [];
}
