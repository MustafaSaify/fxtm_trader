import 'package:equatable/equatable.dart';

class ForexItemDisplayModel extends Equatable {
  final String symbol;
  final String displaySymbol;
  final String description;

  const ForexItemDisplayModel({
    required this.symbol,
    required this.displaySymbol,
    required this.description,
  });
  
  @override
  List<Object?> get props => [symbol, displaySymbol, description];
}
