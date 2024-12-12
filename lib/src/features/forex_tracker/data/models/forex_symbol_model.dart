import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ForexSymbolModel {
  final String description;
  final String displaySymbol;
  final String symbol;

  ForexSymbolModel(
      {required this.description,
      required this.displaySymbol,
      required this.symbol});

  factory ForexSymbolModel.fromJson(Map<String, dynamic> json) {
    return ForexSymbolModel(
      description: json['description'],
      displaySymbol: json['displaySymbol'],
      symbol: json['symbol'],
    );
  }
}
