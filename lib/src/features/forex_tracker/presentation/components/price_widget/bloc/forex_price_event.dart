import 'package:equatable/equatable.dart';

abstract class ForexPriceEvent extends Equatable {}

class SubscribeToPrice implements ForexPriceEvent {
  
  final String symbol;

  const SubscribeToPrice(this.symbol);

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => throw UnimplementedError();
}
