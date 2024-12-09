import 'package:equatable/equatable.dart';

class ForexSymbol extends Equatable {
  final String symbol;
  final String name;

  const ForexSymbol({required this.symbol, required this.name});

  static fromJson(symbol) {}
  
  @override
  List<Object?> get props => [symbol, name];
}
