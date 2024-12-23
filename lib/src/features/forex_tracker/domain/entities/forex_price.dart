import 'package:equatable/equatable.dart';

class ForexPrice extends Equatable {
  final String symbol;
  final double price;

  const ForexPrice({required this.symbol, required this.price});
  
  @override
  List<Object?> get props => [symbol, price];

  // Factory method to create ForexPrice from a map
  factory ForexPrice.fromMap(Map<String, dynamic> map) {
    return ForexPrice(
      symbol: map['s'] ?? '',
      price: (map['p'] is num) ? (map['p'] as num).toDouble() : 0.0,
    );
  }
}
