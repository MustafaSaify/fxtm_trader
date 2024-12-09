import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/forex_symbols_remote_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/services/forex_symbols_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repository/mock_data/forex_symbols_repository_mocks.dart';
import 'forex_symbols_datasource_test.mocks.dart';
import 'mock_data/forex_symbols_remote_datasourse_mocks.dart';

@GenerateMocks([ForexSymbolsService])
void main() {
  late ForexSymbolsRemoteDataSource sut;
  late ForexSymbolsService mockForexSymbolsService;
  const apiToken = '1234567890';

  setUp(() {
    mockForexSymbolsService = MockForexSymbolsService();
    sut = ForexSymbolsRemoteDataSourceImpl(forexSymbolsService: mockForexSymbolsService, apiToken: apiToken);
  });

  group('Test ForexSymbolsDataSourceImpl', () {
    test('Get Symbols - Success case', () async {
      // given
      const exchange = 'forex';
      var expectedSymbols = mockedForexSymbols;
      when(mockForexSymbolsService.getSymbols(exchange, apiToken)).thenAnswer((_) async {
        return mockedForexSymbolsDtos;
      });

      // when
      final result = await sut.getSymbols(exchange: exchange);

      // then
      expect(result, equals(expectedSymbols));
    });

    test('Get Symbols - Failure case', () async {
      // given
      const exchange = 'forex';
      var expectedSymbols = mockedForexSymbols;
      when(mockForexSymbolsService.getSymbols(exchange, apiToken)).thenAnswer((_) async {
        return mockedForexSymbolsDtos;
      });

      // when
      final result = await sut.getSymbols(exchange: exchange);

      // then
      expect(result, equals(expectedSymbols));
    });
  });
}
