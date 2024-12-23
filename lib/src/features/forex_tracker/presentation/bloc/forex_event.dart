import 'package:equatable/equatable.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';

abstract class ForexEvent extends Equatable {}

class LoadForexSymbols implements ForexEvent {

  final String exchange;

  LoadForexSymbols({required this.exchange});

  @override
  List<Object?> get props => [exchange];

  @override
  bool? get stringify => throw UnimplementedError();
}

class SubscribeToPrices implements ForexEvent {

  final List<ForexSymbol> symbols;

  SubscribeToPrices({required this.symbols});

  @override
  List<Object?> get props => [symbols];

  @override
  bool? get stringify => throw UnimplementedError();
}
