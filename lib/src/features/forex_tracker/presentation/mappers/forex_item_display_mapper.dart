import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/models/forex_item_display_model.dart';

abstract class ForexItemDisplayMapper {
  List<ForexItemDisplayModel> map({
    required List<ForexSymbol> domainModels,
  });
}

class ForexItemDisplayMapperImpl extends ForexItemDisplayMapper {
  @override
  List<ForexItemDisplayModel> map({
    required List<ForexSymbol> domainModels,
  }) {
    return domainModels
      .map((item) => ForexItemDisplayModel(
        symbol: item.symbol,
        displaySymbol: item.displaySymbol,
        description: item.description,
      ))
      .toList();
  }
}
