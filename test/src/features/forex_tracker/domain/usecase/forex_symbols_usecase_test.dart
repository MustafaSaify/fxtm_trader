import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/forex_symbols_repository.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/forex_symbols_usecase.dart';
import '../../data/repository/mock_data/forex_symbols_repository_mocks.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late ForexSymbolsUsecase sut;
  late ForexSymbolsRepository forexSymbolsRepositoryMock;

  setUp(() {
    forexSymbolsRepositoryMock = ForexSymbolsRepositoryMock();
    sut = ForexSymbolsUsecaseImpl(symbolsRepository: forexSymbolsRepositoryMock);
  });

  group('Test forex_symbols_usecase - Happy Cases', () {
    test('Get Symbols - Success case', () async {
      // given
      const exchange = 'forex';
      var expectedSymbols = mockedForexSymbols;
      when(
        () => forexSymbolsRepositoryMock.getSymbols(exchange)
      ).thenAnswer((_) 
        async => mockedForexSymbols
      );

      // when
      final result = await sut.getSymbols(exchange: exchange);

      // then
      expect(result, equals(expectedSymbols));
    });
  });

  group('Test forex_symbols_usecase - Error Cases', () {
    test('Get Symbols - Failure case', () async {
      
    });

    test('Get Symbols - Empty case', () async {});
  });
}

class ForexSymbolsRepositoryMock extends Mock implements ForexSymbolsRepository {}