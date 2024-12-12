import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_trader/src/core/network/network_client.dart';
import 'package:fxtm_trader/src/core/network/network_response.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/forex_symbols_remote_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:mocktail/mocktail.dart';

import '../repository/mock_data/forex_symbols_repository_mocks.dart';
import 'mock_data/forex_symbols_remote_datasourse_mocks.dart';

void main() {
  late ForexSymbolsRemoteDataSource sut;
  late NetworkClient networkClientMock;

  setUp(() {
    networkClientMock = NetworkclientMock();
    sut = ForexSymbolsRemoteDataSourceImpl(networkClient: networkClientMock);
  });

  group('Test ForexSymbolsDataSourceImpl', () {
    test('Get Symbols - Success case', () async {
      // given
      const exchange = 'forex';
      var expectedSymbols = mockedForexSymbolsDtos;
      when(
        () => networkClientMock.get(
          path: any(named: 'path'), 
          queryParameters: any(named: 'queryParameters'), 
          fromJson: any(named: 'fromJson')<List<ForexSymbol>)
      ).thenAnswer((_) 
        async => NetworkResponse(data: mockedForexSymbols)
      );

      // when
      final result = await sut.getSymbols(exchange: exchange);

      // then
      expect(result, equals(expectedSymbols));
    });

    test('Get Symbols - Failure case', () async {
      // given
      const exchange = 'forex';
      var expectedSymbols = mockedForexSymbolsDtos;
      when(() => networkClientMock.get(path: any())).thenAnswer((_) async {
        return NetworkResponse(data: null, statusCode: '400');
      });

      // when
      final result = await sut.getSymbols(exchange: exchange);

      // then
      expect(result, equals(expectedSymbols));
    });
  });
}

class NetworkclientMock extends Mock implements NetworkClient {}