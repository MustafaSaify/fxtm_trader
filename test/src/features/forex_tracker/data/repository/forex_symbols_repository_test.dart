import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/forex_symbols_remote_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/repository/forex_symbols_repository_impl.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/forex_symbols_repository.dart';

import '../datasource/mock_data/forex_symbols_remote_datasourse_mocks.dart';
import 'mock_data/forex_symbols_repository_mocks.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late ForexSymbolsRepository sut;
  late ForexSymbolsRemoteDataSource remoteDataSourceMock;

  setUp(() {
    remoteDataSourceMock = ForexSymbolsRemoteDataSourceMock();
    sut = ForexSymbolsRepositoryImpl(remoteDataSource: remoteDataSourceMock);
  });

  group('Test forex_symbols_repository - Happy Cases', () {
    test('Get Symbols - Success case', () async {
      // given
      const exchange = 'forex';
      var expectedSymbols = mockedForexSymbols;
      when(
        () => remoteDataSourceMock.getSymbols(exchange: exchange)
      ).thenAnswer((_) 
        async => mockedForexSymbolsDtos
      );

      // when
      final result = await sut.getSymbols(exchange);

      // then
      expect(result, equals(expectedSymbols));
    });
  });

  group('Test forex_symbols_repository - Error Cases', () {
    test('Get Symbols - Failure case', () async {
      // given
      const exchange = 'forex';
      var expectedSymbols = mockedForexSymbols;
      when(
        () => remoteDataSourceMock.getSymbols(exchange: exchange)
      ).thenAnswer((_) 
        async => mockedForexSymbolsDtos
      );

      // when
      final result = await sut.getSymbols(exchange);

      // then
      expect(result, equals(expectedSymbols));
    });

    test('Get Symbols - Empty case', () async {});
  });
}

class ForexSymbolsRemoteDataSourceMock extends Mock implements ForexSymbolsRemoteDataSource {}