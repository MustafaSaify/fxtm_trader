import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/models/forex_item_display_model.dart';
import 'package:collection/collection.dart';

abstract class ForexItemDisplayMapper {
  List<ForexItemDisplayModel> map({
    required List<ForexSymbol> symbols,
    List<ForexPrice>? prices,
  });
}

class ForexItemDisplayMapperImpl implements ForexItemDisplayMapper {
  @override
  List<ForexItemDisplayModel> map({
    required List<ForexSymbol> symbols,
    List<ForexPrice>? prices,
  }) {
    return symbols
      .map((item) => ForexItemDisplayModel(
        symbol: item.symbol,
        displaySymbol: item.displaySymbol,
        description: item.description,
        price: prices?.firstWhereOrNull((price) => price.symbol == item.symbol)?.price.toStringAsFixed(4) ?? '--'
      ))
      .toList();
  }
}
