import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/models/forex_item_display_model.dart';

const forexSymbolsDomainModelsMocks = [
  ForexSymbol(
      symbol: 'EURUSD', displaySymbol: 'Euro/USD', description: 'Euro vs USD'),
  ForexSymbol(
      symbol: 'GBPUSD', displaySymbol: 'GBP/USD', description: 'GBP vs USD')
];

const initialDisplayModelsMocks = [
  ForexItemDisplayModel(
      symbol: 'EURUSD',
      displaySymbol: 'Euro/USD',
      description: 'Euro vs USD',
      price: '--'),
  ForexItemDisplayModel(
      symbol: 'GBPUSD',
      displaySymbol: 'GBP/USD',
      description: 'GBP vs USD',
      price: '--')
];

const displayModelsWithPricesMocks = [
  ForexItemDisplayModel(
      symbol: 'EURUSD',
      displaySymbol: 'Euro/USD',
      description: 'Euro vs USD',
      price: '1.1'),
  ForexItemDisplayModel(
      symbol: 'GBPUSD',
      displaySymbol: 'GBP/USD',
      description: 'GBP vs USD',
      price: '1.2')
];

const priceMapMock = {
  "EURUSD": ForexPrice(symbol: 'EURUSD', price: 1.1),
  "GBPUSD": ForexPrice(symbol: 'GBPUSD', price: 1.2),
};
