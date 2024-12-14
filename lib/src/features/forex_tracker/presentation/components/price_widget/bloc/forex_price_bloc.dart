import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/forex_price_usecase.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/bloc/forex_price_event.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/bloc/forex_price_state.dart';

class ForexPriceBloc extends Bloc<ForexPriceEvent, ForexPriceState> {
  final ForexPriceUsecase forexPriceUsecase;

  ForexPriceBloc({required this.forexPriceUsecase}) : super(PriceLoading()) {
    on<SubscribeToPrice>(_subscribeToPrice);
  }

  Future<void> _subscribeToPrice(
    SubscribeToPrice event,
    Emitter<ForexPriceState> emit,
  ) async {
    emit(PriceLoading());
    try {
      await for (final forexPrice in forexPriceUsecase.subscribeToSymbol(event.symbol)) {
        if (forexPrice != null && forexPrice.symbol == event.symbol) {
          emit(PriceLoaded(price: '\$${forexPrice.price.toStringAsFixed(4)}'));
        }
      }
    } catch (error) {
      emit(PriceError(error.toString()));
    }
  }
}
