import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/forex_symbols_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/repository/forex_symbols_repository_impl.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/forex_symbols_repository.dart';
import 'package:mockito/annotations.dart';

import 'forex_symbols_repository_test.mocks.dart';

@GenerateMocks([ForexSymbolsDataSource])
void main() {
  late ForexSymbolsRepository sut;
  late ForexSymbolsDataSource dataSourceMock;

  setUp(() {
    dataSourceMock = MockForexSymbolDataSource();
    sut = ForexSymbolsRepositoryImpl(symbolDataSource: dataSourceMock);
  });

  group('Test forex_symbols_repository - Happy Cases', () {
    test('Get Symbols - Success case', () async {});
  });

  group('Test forex_symbols_repository - Error Cases', () {
    test('Get Symbols - Failure case', () async {});

    test('Get Symbols - Empty case', () async {});
  });
}
