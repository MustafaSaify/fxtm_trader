import 'package:equatable/equatable.dart';

abstract class ForexPriceState extends Equatable {}

class PriceLoading extends ForexPriceState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class PriceLoaded extends ForexPriceState {
  final String price;

  PriceLoaded({required this.price});

  @override
  List<Object?> get props => [price];

  @override
  bool? get stringify => false;
}

class PriceError extends ForexPriceState {
  final String? error;

  PriceError(this.error);

  @override
  List<Object?> get props => [error];

  @override
  bool? get stringify => false;
}
