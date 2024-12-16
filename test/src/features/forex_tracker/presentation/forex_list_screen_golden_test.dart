import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_list_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_state.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/bloc/forex_price_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/bloc/forex_price_state.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/forex_list_screen.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/models/forex_item_display_model.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helper/golden_test_setup.dart';

final locator = GetIt.instance;

void main() {
  late ForexListBloc mockBloc;
  late MockForexPriceBloc mockForexPriceBloc;

  setUp(() {
    mockBloc = MockForexListBloc();
    mockForexPriceBloc = MockForexPriceBloc();

    locator.registerFactory<ForexPriceBloc>(() => mockForexPriceBloc);

    when(() => mockBloc.close()).thenAnswer((_) async {});
    when(() => mockForexPriceBloc.close()).thenAnswer((_) async {});
  });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('Golden Test - Loaded State', (WidgetTester tester) async {
    const displayItems = [
      ForexItemDisplayModel(
        symbol: 'EURUSD',
        displaySymbol: 'Euro/USD',
        description: 'Euro vs USD',
      ),
      ForexItemDisplayModel(
        symbol: 'GBPUSD',
        displaySymbol: 'GBP/USD',
        description: 'GBP vs USD',
      )
    ];

    when(() => mockBloc.state)
        .thenReturn(ForexLoaded(displayItems: displayItems));

    when(() => mockForexPriceBloc.state).thenReturn(
      PriceLoaded(price: 'GBPUSD'),
    );

    whenListen(
      mockBloc,
      Stream.fromIterable([ForexLoaded(displayItems: displayItems)]),
    );

    whenListen(
      mockForexPriceBloc,
      Stream.fromIterable([PriceLoaded(price: 'GBPUSD')]),
    );

    await tester.setupGoldenTests(
      screenSize: const Size(1500, 1000),
    );

    await tester.pumpWidget(createWidgetUnderTest(
      mockBloc,
      mockForexPriceBloc,
    ));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Euro/USD'), findsOneWidget);
    expect(find.text('GBP/USD'), findsOneWidget);
    expect(find.byType(ForexListScreen), findsOneWidget);

    // Take a screenshot
    await expectLater(
      find.byType(ForexListScreen),
      matchesGoldenFile('golden/loaded_state.png'),
    );
  });
}

Widget createWidgetUnderTest(
  ForexListBloc bloc,
  ForexPriceBloc priceBloc,
) {
  return MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
    ),
    home: MultiBlocProvider(
      providers: [
        BlocProvider<ForexPriceBloc>(
          create: (context) => priceBloc,
        ),
      ],
      child: BlocProvider<ForexListBloc>(
        create: (_) => bloc,
        child: const ForexListScreen(),
      ),
    ),
  );
}

class MockForexListBloc extends Mock implements ForexListBloc {}

class MockForexPriceBloc extends Mock implements ForexPriceBloc {}
