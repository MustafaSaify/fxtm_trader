import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/price_stream_repository.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/forex_price_usecase.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late ForexPriceUsecase sut;
  late ForexPriceSocketRepository forexPriceRepositoryMock;

  setUp(() {
    forexPriceRepositoryMock = ForexPriceSocketRepositoryMock();
    sut = ForexPriceUsecaseImpl(repository: forexPriceRepositoryMock);
  });

  group('ForexPriceUsecase Tests', () {

    test('subscribeToSymbol should call repository and return a stream', () {
      // Arrange
      const symbol = 'EURUSD';
      
      final mockStream = Stream<ForexPrice?>.fromIterable([
        ForexPrice(symbol: symbol, price: 1.1),
        ForexPrice(symbol: symbol, price: 1.2),
      ]);

      when(() => forexPriceRepositoryMock.subscribeToSymbol(symbol))
      .thenAnswer((_) => mockStream);

      // Act
      final resultStream = sut.subscribeToSymbol(symbol);

      // Assert
      expect(resultStream, emitsInOrder([
        ForexPrice(symbol: symbol, price: 1.1),
        ForexPrice(symbol: symbol, price: 1.2),
      ]));
      verify(() => forexPriceRepositoryMock.subscribeToSymbol(symbol)).called(1);
    });

    test('subscribeToSymbol should handle empty streams', () {
      // Arrange
      const symbol = 'GBPUSD';
      const mockStream = Stream<ForexPrice?>.empty();

      when(() => forexPriceRepositoryMock.subscribeToSymbol(symbol))
      .thenAnswer((_) => mockStream);

      // Act
      final resultStream = sut.subscribeToSymbol(symbol);

      // Assert
      expect(resultStream, emitsDone);
      verify(() => forexPriceRepositoryMock.subscribeToSymbol(symbol)).called(1);
    });
  });
}

class ForexPriceSocketRepositoryMock extends Mock implements ForexPriceSocketRepository {}