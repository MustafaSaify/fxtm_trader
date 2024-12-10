class ForexPriceQuery {
  final String type;
  final String symbol;

  ForexPriceQuery({required this.type, required this.symbol});

  Map<String, String> toJson() => {"type": "subscribe", "symbol": "OANDA:EUR_TRY"};
}