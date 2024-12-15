abstract class ForexHistoryEvent {}

class FetchHistoryData extends ForexHistoryEvent {
  final String symbol;

  FetchHistoryData(this.symbol);
}
