import 'package:equatable/equatable.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';

abstract class ForexState extends Equatable {}

class ForexLoading implements ForexState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class ForexLoaded implements ForexState {
  final List<ForexSymbol> symbols;

  ForexLoaded({required this.symbols});

  @override
  List<Object?> get props => [symbols];

  @override
  bool? get stringify => false;
}

class ForexError implements ForexState {
  final String error;

  ForexError({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  bool? get stringify => false;
}
