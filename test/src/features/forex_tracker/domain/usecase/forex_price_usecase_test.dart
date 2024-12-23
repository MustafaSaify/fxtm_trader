import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/price_stream_repository.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/get_forex_prices_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_data/forex_price_usecase_mocks.dart';

void main() {
  late GetForexPricesUsecase sut;
  late ForexPriceSocketRepository forexPriceRepositoryMock;

  setUp(() {
    forexPriceRepositoryMock = ForexPriceSocketRepositoryMock();
    sut = GetForexPricesUsecaseImpl(repository: forexPriceRepositoryMock);
  });

  group('ForexPriceUsecase Tests', () {
    test('subscribeToSymbol should call repository and return a stream', () {
      // Arrange
      const symbols = forexSymbolsMocks;

      final mockStream =
          Stream<Map<String, ForexPrice>?>.fromIterable([mockPriceMap]);

      when(() => forexPriceRepositoryMock.subscribeToSymbols(symbols))
          .thenAnswer((_) => mockStream);

      // Act
      final resultStream = sut.call(symbols);

      // Assert
      expect(resultStream, emitsInOrder([mockPriceMap]));
      verify(() => forexPriceRepositoryMock.subscribeToSymbols(symbols))
          .called(1);
    });
  });
}

class ForexPriceSocketRepositoryMock extends Mock
    implements ForexPriceSocketRepository {}
