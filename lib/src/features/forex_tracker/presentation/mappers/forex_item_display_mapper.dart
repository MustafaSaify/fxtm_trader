import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/models/forex_item_display_model.dart';

abstract class ForexItemDisplayMapper {
  List<ForexItemDisplayModel> map({
    required List<ForexSymbol> forexSymbols,
    Map<String, ForexPrice>? pricesMap,
  });
}

class ForexItemDisplayMapperImpl implements ForexItemDisplayMapper {
  @override
  List<ForexItemDisplayModel> map({
    required List<ForexSymbol> forexSymbols,
    Map<String, ForexPrice>? pricesMap,
  }) {
    return forexSymbols
      .map((forexSymbol) => ForexItemDisplayModel(
        symbol: forexSymbol.symbol,
        displaySymbol: forexSymbol.displaySymbol,
        description: forexSymbol.description,
        price: pricesMap?[forexSymbol.symbol]?.price.toStringAsFixed(4) ?? '--'
      ))
      .toList();
  }
}
