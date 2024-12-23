import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/get_forex_prices_usecase.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_list_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_event.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_state.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/get_forex_symbols_usecase.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/mappers/forex_item_display_mapper.dart';
import 'package:mocktail/mocktail.dart';
import 'mock_data/forex_list_bloc_mocks.dart';
import 'dart:async';

void main() {
  late GetForexSymbolsUsecase getForexSymbolsusecaseMock;
  late GetForexPricesUsecase getForexPricesUsecaseMock;
  late ForexItemDisplayMapper forexitemDisplayMapperMock;
  late ForexListBloc forexListBloc;

  setUp(() {
    getForexSymbolsusecaseMock = GetForexSymbolsUsecaseMock();
    getForexPricesUsecaseMock = GetForexPricesUsecaseMock();
    forexitemDisplayMapperMock = ForexItemDisplayMapperMock();

    forexListBloc = ForexListBloc(
      getForexSymbolsUsecase: getForexSymbolsusecaseMock,
      getForexPriceUsecase: getForexPricesUsecaseMock,
      displayMapper: forexitemDisplayMapperMock,
    );
  });

  tearDown(() {
    // Close the bloc if needed
    forexListBloc.close();
  });

  group('ForexListBloc - LoadForexSymbols', () {
    // Test successful loading of symbols + subsequent subscription
    blocTest<ForexListBloc, ForexState>(
      'emits [ForexLoading, ForexLoaded] and then triggers SubscribeToPrices event',
      build: () {
        // Arrange
        when(() =>
                getForexSymbolsusecaseMock(exchange: any(named: 'exchange')))
            .thenAnswer((_) async => forexSymbolsDomainModelsMocks);

        final controller = StreamController<Map<String, ForexPrice>>();
        when(() => getForexPricesUsecaseMock(forexSymbolsDomainModelsMocks))
            .thenAnswer((_) {
          // simulate streaming of 2 updates
          Future.delayed(Duration.zero, () {
            controller.close();
          });
          return controller.stream;
        });

        when(() => forexitemDisplayMapperMock.map(
                forexSymbols: any(named: 'forexSymbols')))
            .thenReturn(initialDisplayModelsMocks);

        return forexListBloc;
      },
      act: (bloc) => bloc.add(LoadForexSymbols(exchange: 'FOREX')),
      expect: () => [
        ForexLoading(),
        ForexLoaded(displayItems: initialDisplayModelsMocks),
      ],
      verify: (_) {
        // Verify that the usecase was called with correct exchange
        verify(() => getForexSymbolsusecaseMock(exchange: 'FOREX')).called(1);
        // Verify that the display mapper was called to map the symbols
        verify(() => forexitemDisplayMapperMock.map(
            forexSymbols: any(named: 'forexSymbols'))).called(1);
      },
    );

    // Test error scenario while loading symbols
    blocTest<ForexListBloc, ForexState>(
      'emits [ForexLoading, ForexError] when LoadForexSymbols fails',
      build: () {
        when(() =>
                getForexSymbolsusecaseMock.call(exchange: any(named: 'exchange')))
            .thenThrow(Exception('Failed to fetch symbols'));

        return forexListBloc;
      },
      act: (bloc) => bloc.add(LoadForexSymbols(exchange: 'FOREX')),
      expect: () => [
        ForexLoading(),
        ForexError(error: 'Error while fetching symbols'),
      ],
      verify: (_) {
        verify(() => getForexSymbolsusecaseMock(exchange: 'FOREX')).called(1);
      },
    );
  });

  group('ForexListBloc - SubscribeToPrices', () {
    // Test successful subscription flow
    blocTest<ForexListBloc, ForexState>(
      'emits updated ForexLoaded states when new price data arrives',
      build: () {
        // Arrange
        when(() =>
                getForexSymbolsusecaseMock(exchange: any(named: 'exchange')))
            .thenAnswer((_) async => forexSymbolsDomainModelsMocks);

        when(() => forexitemDisplayMapperMock.map(
                forexSymbols: any(named: 'forexSymbols')))
            .thenReturn(initialDisplayModelsMocks);

        // For subscription, we return a Stream of some price snapshots
        final controller = StreamController<Map<String, ForexPrice>>();
        when(() => getForexPricesUsecaseMock(forexSymbolsDomainModelsMocks))
            .thenAnswer((_) {
          // simulate streaming of 2 updates
          Future.delayed(Duration.zero, () {
            controller.add(priceMapMock);
            controller.close();
          });
          return controller.stream;
        });

        // We should also mock how displayMapper is called for mapping the new prices
        when(() => forexitemDisplayMapperMock.map(
            forexSymbols: forexSymbolsDomainModelsMocks,
            pricesMap: priceMapMock)).thenReturn(displayModelsWithPricesMocks);

        return forexListBloc;
      },
      act: (bloc) async {
        // We need to first load the symbols, which triggers SubscribeToPrices internally
        bloc.add(LoadForexSymbols(exchange: 'FOREX'));
        // Give the stream some time to emit its events
        await Future.delayed(const Duration(milliseconds: 10));
      },
      wait: const Duration(
          milliseconds: 100), // ensures stream events are captured
      expect: () => <ForexState>[
        ForexLoading(), // from LoadForexSymbols
        ForexLoaded(displayItems: initialDisplayModelsMocks),
        ForexLoaded(displayItems: displayModelsWithPricesMocks),
      ],
      verify: (_) {
        verify(() => getForexPricesUsecaseMock.call(forexSymbolsDomainModelsMocks))
            .called(1);

        // We also expect the displayMapper to be called each time new prices come in.
        verify(() => forexitemDisplayMapperMock.map(
              forexSymbols: forexSymbolsDomainModelsMocks,
              pricesMap: priceMapMock,
            )).called(1);
      },
    );
  });
}

class GetForexSymbolsUsecaseMock extends Mock implements GetForexSymbolsUsecase {}

class GetForexPricesUsecaseMock extends Mock implements GetForexPricesUsecase {}

class ForexItemDisplayMapperMock extends Mock
    implements ForexItemDisplayMapper {}
