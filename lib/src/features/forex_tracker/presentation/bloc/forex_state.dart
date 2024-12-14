import 'package:equatable/equatable.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/models/forex_item_display_model.dart';

abstract class ForexState extends Equatable {}

class ForexLoading extends ForexState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class ForexLoaded extends ForexState {
  final List<ForexItemDisplayModel> displayItems;

  ForexLoaded({required this.displayItems});

  @override
  List<Object?> get props => [displayItems];

  @override
  bool? get stringify => false;
}

class ForexError extends ForexState {
  final String error;

  ForexError({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  bool? get stringify => false;
}
