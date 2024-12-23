import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/get_forex_prices_usecase.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/get_forex_symbols_usecase.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_event.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_state.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/mappers/forex_item_display_mapper.dart';

class ForexListBloc extends Bloc<ForexEvent, ForexState> {
  final GetForexSymbolsUsecase getForexSymbolsUsecase;
  final GetForexPricesUsecase getForexPriceUsecase;
  final ForexItemDisplayMapper displayMapper;

  ForexListBloc({
    required this.getForexSymbolsUsecase,
    required this.getForexPriceUsecase,
    required this.displayMapper,
  }) : super(ForexLoading()) {
    on<LoadForexSymbols>(_handleLoadForexEvent);
    on<SubscribeToPrices>(_subscribeToPrices);
  }

  Future<void> _handleLoadForexEvent(
    LoadForexSymbols event,
    Emitter<ForexState> emit,
  ) async {
    emit(ForexLoading());
    try {
      // Get the forex symbols
      final forexSymbols = await getForexSymbolsUsecase(
        exchange: event.exchange,
      );

      // Emit a "loaded" state with partial data (no prices yet)
      final initialDisplayModels =
          displayMapper.map(forexSymbols: forexSymbols);
      emit(ForexLoaded(displayItems: initialDisplayModels));

      // Subscribe to prices for the fetched symbols.
      add(SubscribeToPrices(symbols: forexSymbols));
    } catch (e) {
      emit(ForexError(error: 'Error while fetching symbols: $e'));
    }
  }

  Future<void> _subscribeToPrices(
    SubscribeToPrices event,
    Emitter<ForexState> emit,
  ) async {
    try {
      await for (final forexPrices in getForexPriceUsecase(event.symbols)) {
        if (forexPrices != null) {
          final displayModels = displayMapper.map(
              forexSymbols: event.symbols, pricesMap: forexPrices);
          emit(ForexLoaded(displayItems: displayModels));
        }
      }
    } catch (e) {
      emit(ForexError(error: 'Error while fetching prices: $e'));
    }
  }
}
