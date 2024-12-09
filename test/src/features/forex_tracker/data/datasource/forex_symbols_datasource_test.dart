
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/forex_symbol_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'forex_symbols_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ForexSymbolDataSource sut;
  late HttpClient httpClientMock;

  setUp(() {
    httpClientMock = MockClient() as HttpClient;
    sut = ForexSymbolDataSourceImpl(httpClient: httpClientMock);
  });

  group('Test ForexSymbolsDataSourceImpl', () {
    test('Get Symbols - Success case', () async {

    });

    test('Get Symbols - Failure case', () async {

    });
  });
}