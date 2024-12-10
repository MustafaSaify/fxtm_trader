import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';

abstract class ForexPriceSocketRepository {
  Stream<ForexPrice?> subscribeToSymbol(String symbol);
}
