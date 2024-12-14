import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/forex_symbols_usecase.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_event.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_state.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/mappers/forex_item_display_mapper.dart';

class ForexListBloc extends Bloc<ForexEvent, ForexState> {
  final ForexSymbolsUsecase forexSymbolsUsecase;
  final ForexItemDisplayMapper forexItemDisplayMapper;

  ForexListBloc({
    required this.forexSymbolsUsecase,
    required this.forexItemDisplayMapper,
  }) : super(ForexLoading()) {
    on<LoadForexSymbols>(_handleLoadForexEvent);
  }

  Future<void> _handleLoadForexEvent(
    LoadForexSymbols event,
    Emitter<ForexState> emit,
  ) async {
    emit(ForexLoading());
    try {
      var forexSymbols = await forexSymbolsUsecase.getSymbols(exchange: event.exchange);
      var displayModels = forexItemDisplayMapper.map(domainModels: forexSymbols);
      emit(ForexLoaded(displayItems: displayModels));
    } catch (e) {
      emit(ForexError(error: 'Error while fetching symbols'));
    }
  }
}
