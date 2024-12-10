import 'package:equatable/equatable.dart';

class ForexSymbol extends Equatable {
  final String symbol;
  final String displaySymbol;
  final String description;

  const ForexSymbol({required this.symbol, required this.displaySymbol, required this.description});

  static fromJson(symbol) {}
  
  @override
  List<Object?> get props => [symbol, displaySymbol, description];
}
