import 'package:fxtm_trader/src/features/forex_history/domain/entities/candle.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/models/forex_history_display_model.dart';
import 'package:interactive_chart/interactive_chart.dart';

abstract class ForexHistoryDisplayMapper {
  ForexHistoryDisplayModel map(List<Candle> domainModels, String symbol);
}

class ForexHistoryDisplayMapperImpl implements ForexHistoryDisplayMapper {
  @override
  ForexHistoryDisplayModel map(List<Candle> domainModels, String symbol) {
    final displayCandles = domainModels.map((model) => CandleData(
      timestamp: model.timestamp,
      open: model.open,
      close: model.close,
      volume: model.volume.toDouble(),
      high: model.high,
      low: model.low
    )).toList();
    return ForexHistoryDisplayModel(
      displaySymbol: symbol,
      candles: displayCandles
    );
  }
  
}