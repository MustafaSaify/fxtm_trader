import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/forex_symbols_usecase.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_event.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_state.dart';

class ForexListScreenBloc extends Bloc<ForexEvent, ForexState> {
  final ForexSymbolsUsecase forexSymbolsUsecase;

  ForexListScreenBloc({
    required this.forexSymbolsUsecase,
  }) : super(ForexLoading()) {
    on<LoadForexSymbols>(_handleLoadForexEvent);
  }

  Future<void> _handleLoadForexEvent(
    LoadForexSymbols event,
    Emitter<ForexState> emit,
  ) async {
    emit(ForexLoading());
    try {
      // The exchange is hardcoded to reduce the scope of this assignment.
      var forexSymbols =
          await forexSymbolsUsecase.getSymbols(exchange: 'oanda');
      emit(ForexLoaded(symbols: [forexSymbols[0], forexSymbols[1]]));
    } catch (e) {
      emit(ForexError(error: e.toString()));
    }
  }
}
