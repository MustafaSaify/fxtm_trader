import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/features/forex_history/domain/usecase/get_candle_data_usecase.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/bloc/forex_history_event.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/bloc/forex_history_state.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/mapper/forex_history_display_mapper.dart';

class ForexHistoryBloc extends Bloc<ForexHistoryEvent, ForexHistoryState> {
  final GetCandleDataUseCase getCandleDataUseCase;
  final ForexHistoryDisplayMapper displayModelMapper;

  ForexHistoryBloc(this.getCandleDataUseCase, this.displayModelMapper) : super(ForexHostoryInitial()) {
    on<FetchHistoryData>((event, emit) async {
      emit(ForexHistoryLoading());
      try {
        final candles = await getCandleDataUseCase(event.symbol);
        final displayModel = displayModelMapper.map(candles, event.symbol);
        emit(ForexHistoryLoaded(displayModel));
      } catch (e) {
        emit(ForexHistoryError(e.toString()));
      }
    });
  }
}
