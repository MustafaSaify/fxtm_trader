import 'package:equatable/equatable.dart';

abstract class ForexEvent extends Equatable {}

class LoadForexSymbols implements ForexEvent {
  const LoadForexSymbols();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => throw UnimplementedError();
}
