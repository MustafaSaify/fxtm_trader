import 'package:equatable/equatable.dart';

abstract class ForexEvent extends Equatable {}

class LoadForexSymbols implements ForexEvent {

  final String exchange;

  LoadForexSymbols({required this.exchange});

  @override
  List<Object?> get props => [exchange];

  @override
  bool? get stringify => throw UnimplementedError();
}
