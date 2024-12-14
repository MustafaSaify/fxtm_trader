import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_list_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/models/forex_item_display_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_event.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_state.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/forex_symbols_usecase.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/mappers/forex_item_display_mapper.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late ForexListBloc sut;
  late ForexSymbolsUsecase forexSymbolsusecaseMock;
  late ForexItemDisplayMapper forexitemDisplayMapperMock;

  setUp(() {
    forexSymbolsusecaseMock = ForexSymbolsUsecaseMock();
    forexitemDisplayMapperMock = ForexItemDisplayMapperMock();
    sut = ForexListBloc(forexSymbolsUsecase: forexSymbolsusecaseMock, forexItemDisplayMapper: forexitemDisplayMapperMock);
  });
  group('ForexListScreenBloc Tests', () {

    const exchange = 'Test Exchange';

    blocTest<ForexListBloc, ForexState>(
      'emits [ForexLoading, ForexLoaded] when LoadForexSymbols succeeds',
      build: () {
        when(() => forexSymbolsusecaseMock.getSymbols(exchange: exchange))
        .thenAnswer((_) async => [
          const ForexSymbol(symbol: 'EURUSD', displaySymbol: 'Euro/USD', description: 'Euro vs USD'),
          const ForexSymbol(symbol: 'GBPUSD', displaySymbol: 'GBP/USD', description: 'GBP vs USD')
        ]);

        when(() => forexitemDisplayMapperMock.map(domainModels: any()))
        .thenReturn([
          ForexItemDisplayModel(symbol: 'EURUSD', displaySymbol: 'Euro/USD', description:'Euro vs USD'),
          ForexItemDisplayModel(symbol: 'GBPUSD', displaySymbol: 'GBP/USD', description: 'GBP vs USD')
        ]);

        return sut;
      },
      act: (bloc) => bloc.add(LoadForexSymbols(exchange: exchange)),
      expect: () => [
        ForexLoading(),
        ForexLoaded(
          displayItems: [
            ForexItemDisplayModel(symbol: 'EURUSD', displaySymbol: 'Euro/USD', description:'Euro vs USD'),
          ForexItemDisplayModel(symbol: 'GBPUSD', displaySymbol: 'GBP/USD', description: 'GBP vs USD')
          ],
        ),
      ],
      verify: (_) {
        verify(() => forexSymbolsusecaseMock.getSymbols(exchange: 'NYSE')).called(1);
        verify(() => forexitemDisplayMapperMock.map(domainModels: any())).called(1);
      },
    );

    blocTest<ForexListBloc, ForexState>(
      'emits [ForexLoading, ForexError] when LoadForexSymbols fails',
      build: () {
        when(() => forexSymbolsusecaseMock.getSymbols(exchange: exchange))
            .thenThrow(Exception('Failed to fetch symbols'));

        return sut;
      },
      act: (bloc) => bloc.add(LoadForexSymbols(exchange: exchange)),
      expect: () => [
        ForexLoading(),
        ForexError(error: 'Error while fetching symbols'),
      ],
      verify: (_) {
        verify(() => forexSymbolsusecaseMock.getSymbols(exchange: exchange)).called(1);
      },
    );
  });
}

class ForexSymbolsUsecaseMock extends Mock implements ForexSymbolsUsecase {}
class ForexItemDisplayMapperMock extends Mock implements ForexItemDisplayMapper {}