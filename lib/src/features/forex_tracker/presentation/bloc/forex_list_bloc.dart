import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/forex_price_usecase.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/forex_symbols_usecase.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_event.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_state.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/mappers/forex_item_display_mapper.dart';

class ForexListBloc extends Bloc<ForexEvent, ForexState> {
  final ForexSymbolsUsecase forexSymbolsUsecase;
  final ForexPriceUsecase forexPriceUsecase;
  final ForexItemDisplayMapper displayMapper;

  ForexListBloc({
    required this.forexSymbolsUsecase,
    required this.forexPriceUsecase,
    required this.displayMapper,
  }) : super(ForexLoading()) {
    on<LoadForexSymbols>(_handleLoadForexEvent);
  }

  Future<void> _handleLoadForexEvent(
    LoadForexSymbols event,
    Emitter<ForexState> emit,
  ) async {
    emit(ForexLoading());
    try {
      // 1. Get the forex symbols
      final forexSymbols = await forexSymbolsUsecase.getSymbols(
        exchange: event.exchange,
      );

      // 2. Immediately emit a "loaded" state with partial data (no prices yet)
      final initialDisplayModels = displayMapper.map(symbols: forexSymbols);
      emit(ForexLoaded(displayItems: initialDisplayModels));

      // 3. Now listen to a stream of prices and emit updates
      await emit.forEach<List<ForexPrice>?>(_subscribeToPrice(forexSymbols),
        onData: (forexPrices) {
          // If the stream has price data, map and emit
          if (forexPrices != null && forexPrices.isNotEmpty) {
            final updatedDisplayModels = displayMapper.map(
              symbols: forexSymbols,
              prices: forexPrices,
            );
            return ForexLoaded(displayItems: updatedDisplayModels);
          }
          // Otherwise, keep showing the display with no price updates
          return ForexLoaded(displayItems: initialDisplayModels);
        },
        onError: (error, stackTrace) {
          // If the price stream fails at some point, emit an error
          return ForexError(error: 'Error while fetching prices: $error');
        },
      );
    } catch (e) {
      // If fetching symbols themselves fails, emit an error
      emit(ForexError(error: 'Error while fetching symbols: $e'));
    }
  }

  Stream<List<ForexPrice>?> _subscribeToPrice(List<ForexSymbol> symbols) {
    return forexPriceUsecase.subscribeToSymbols(symbols);
  }


  // Future<void> _handleLoadForexEvent(
  //   LoadForexSymbols event,
  //   Emitter<ForexState> emit,
  // ) async {
  //   emit(ForexLoading());
  //   try {
  //     var forexSymbols = await forexSymbolsUsecase.getSymbols(exchange: event.exchange);
  //     _subscribeToPrice(forexSymbols).listen((forexPrices) {
  //       if (forexPrices != null && forexPrices.isNotEmpty) {
  //         var displayModels = displayMapper.map(symbols: forexSymbols, prices: forexPrices);
  //         emit(ForexLoaded(displayItems: displayModels));  
  //       }
  //     });
  //     var displayModels = displayMapper.map(symbols: forexSymbols);
  //     emit(ForexLoaded(displayItems: displayModels));
  //   } catch (e) {
  //     emit(ForexError(error: 'Error while fetching symbols'));
  //   }
  // }

  // Stream<List<ForexPrice>?> _subscribeToPrice(List<ForexSymbol> symbols) async* {
  //   yield* forexPriceUsecase.subscribeToSymbols(symbols);
  // }
}
