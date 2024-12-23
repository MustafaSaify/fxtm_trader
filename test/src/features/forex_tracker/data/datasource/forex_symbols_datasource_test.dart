import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_trader/src/core/network/network_client.dart';
import 'package:fxtm_trader/src/core/network/network_response.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/forex_symbols_remote_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/models/forex_symbol_model.dart';
import 'package:mocktail/mocktail.dart';
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
      // Arrange
      const exchange = 'forex';
      var expectedSymbols = mockedForexSymbolsDtos;
      when(
        () => networkClientMock.get<List<ForexSymbolModel>>(
          path: any(named: 'path'), 
          queryParameters: any(named: 'queryParameters'), 
          fromJson: any(named: 'fromJson'))
      ).thenAnswer((_) 
        async => NetworkResponse(data: mockedForexSymbolsDtos)
      );

      // Act
      final result = await sut.getSymbols(exchange: exchange);

      // Assert
      expect(result, equals(expectedSymbols));
    });

    test('Get Symbols - Failure case', () async {
      // Arrange
      const exchange = 'forex';
      var expectedSymbols = [];
      when(
        () => networkClientMock.get<List<ForexSymbolModel>>(
          path: any(named: 'path'), 
          queryParameters: any(named: 'queryParameters'), 
          fromJson: any(named: 'fromJson'))
      ).thenAnswer((_) 
        async => NetworkResponse(data: null, statusCode: '500', success: false)
      );

      // Act
      final result = await sut.getSymbols(exchange: exchange);

      // Assert
      expect(result, equals(expectedSymbols));
    });
  });
}

class NetworkclientMock extends Mock implements NetworkClient {}