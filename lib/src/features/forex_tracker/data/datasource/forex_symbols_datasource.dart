import 'dart:io';

abstract class ForexSymbolsDataSource {
  Future<List<dynamic>> getSymbols({required String exchange});
}

class ForexSymbolDataSourceImpl implements ForexSymbolsDataSource {
  final HttpClient _httpClient;

  ForexSymbolDataSourceImpl({required HttpClient httpClient})
      : _httpClient = httpClient;

  @override
  Future<List<dynamic>> getSymbols({required String exchange}) async => [];
}
