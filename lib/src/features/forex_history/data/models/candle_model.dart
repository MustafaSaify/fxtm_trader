class CandleModel {
  final double open;
  final double high;
  final double low;
  final double close;
  final int timestamp;
  final int volume;

  CandleModel({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.timestamp,
    required this.volume,
  });

  factory CandleModel.fromJson(Map<String, dynamic> json, int index) {
    return CandleModel(
      open: json['o'][index],
      high: json['h'][index],
      low: json['l'][index],
      close: json['c'][index],
      timestamp: json['t'][index],
      volume: json['v'][index],
    );
  }

  static List<CandleModel> fromResponse(Map<String, dynamic> response) {
    final List<CandleModel> candles = [];
    for (int i = 0; i < response['t'].length; i++) {
      candles.add(CandleModel.fromJson(response, i));
    }
    return candles;
  }
}
