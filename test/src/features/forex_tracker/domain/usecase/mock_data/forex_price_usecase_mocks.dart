import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_price.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';

const forexSymbolsMocks = [
  ForexSymbol(symbol: 'EURUSD', displaySymbol: 'Euro/USD', description: 'Euro vs USD'),
];

const mockPriceMap = {'EURUSD' : ForexPrice(symbol: 'EURUSD', price: 1.2)}; 