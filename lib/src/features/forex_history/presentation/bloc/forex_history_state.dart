import 'package:fxtm_trader/src/features/forex_history/presentation/models/forex_history_display_model.dart';

abstract class ForexHistoryState {}

class ForexHostoryInitial extends ForexHistoryState {}

class ForexHistoryLoading extends ForexHistoryState {}

class ForexHistoryLoaded extends ForexHistoryState {
  final ForexHistoryDisplayModel displayModel;

  ForexHistoryLoaded(this.displayModel);
}

class ForexHistoryError extends ForexHistoryState {
  final String message;

  ForexHistoryError(this.message);
}
