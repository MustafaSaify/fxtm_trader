import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/forex_symbols_remote_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/repository/forex_symbols_repository_impl.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/forex_symbols_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forex_symbols_repository_test.mocks.dart';
import 'mock_data/forex_symbols_repository_mocks.dart';


@GenerateMocks([ForexSymbolsRemoteDataSource])
void main() {
  late ForexSymbolsRepository sut;
  late ForexSymbolsRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockForexSymbolsRemoteDataSource();
    sut = ForexSymbolsRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('Test forex_symbols_repository - Happy Cases', () {
    test('Get Symbols - Success case', () async {
      // given
      const exchange = 'forex';
      var expectedSymbols = mockedForexSymbols;
      when(mockRemoteDataSource.getSymbols(exchange: exchange)).thenAnswer((_) async {
        return mockedForexSymbols;
      });

      // when
      final result = await sut.getSymbols(exchange);

      // then
      expect(result, equals(expectedSymbols));
    });
  });

  group('Test forex_symbols_repository - Error Cases', () {
    test('Get Symbols - Failure case', () async {});

    test('Get Symbols - Empty case', () async {});
  });
}
