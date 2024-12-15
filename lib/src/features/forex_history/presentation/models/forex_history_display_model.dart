import 'package:interactive_chart/interactive_chart.dart';

class ForexHistoryDisplayModel {
  final String displaySymbol;
  final List<CandleData> candles;

  ForexHistoryDisplayModel({required this.displaySymbol, required this.candles});
}