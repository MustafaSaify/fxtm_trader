import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/bloc/forex_price_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/forex_list_screen.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/models/forex_item_display_model.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_list_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_state.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_event.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/forex_list_content_widget.dart';

class MockForexListBloc extends Mock implements ForexListBloc {}

void main() {
  late MockForexListBloc mockBloc;

  setUp(() {
    mockBloc = MockForexListBloc();
    when(() => mockBloc.close()).thenAnswer((_) async {});

    final sl = GetIt.I;
    // Reset any previous registrations
    sl.reset();
    // Register the ForexPriceBloc mock or instance
    sl.registerFactory<ForexPriceBloc>(() => MockForexPriceBloc());
  });

  Future<void> pumpForexListScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ForexListBloc>(
          create: (_) => mockBloc,
          child: const ForexListScreen(),
        ),
      ),
    );
  }

  testWidgets('should display loading widget when state is ForexLoading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(ForexLoading());
    when(() => mockBloc.stream).thenAnswer((_) => Stream.value(ForexLoading()));

    await pumpForexListScreen(tester);

    expect(find.byKey(ForexListKeys.loading), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'should display loaded widget with content when state is ForexLoaded',
      (WidgetTester tester) async {
    final displayItems = [
      const ForexItemDisplayModel(
        symbol: 'EUR/USD',
        displaySymbol: 'EUR/USD',
        description: 'Euro to US Dollar',
      ),
      const ForexItemDisplayModel(
        symbol: 'USD/JPY',
        displaySymbol: 'USD/JPY',
        description: 'US Dollar to Japanese Yen',
      ),
    ];
    // Mock the ForexLoaded state with display items
    when(() => mockBloc.state)
        .thenReturn(ForexLoaded(displayItems: displayItems));

    // Mock the stream to simulate new states being emitted (this simulates Bloc behavior)
    when(() => mockBloc.stream).thenAnswer(
        (_) => Stream.value(ForexLoaded(displayItems: displayItems)));

    // Pump the ForexListScreen widget
    await pumpForexListScreen(tester);

    // Verify that the loaded state is displayed
    expect(find.byKey(ForexListKeys.loaded), findsOneWidget);

    // Verify that each Forex item's display symbol is found in the widget tree
    for (final item in displayItems) {
      expect(find.text(item.displaySymbol), findsOneWidget);
    }
  });

  testWidgets('should display error widget when state is ForexError',
      (WidgetTester tester) async {
    const errorMessage = 'Custom error message';
    when(() => mockBloc.state).thenReturn(ForexError(error: errorMessage));
    when(() => mockBloc.stream)
        .thenAnswer((_) => Stream.value(ForexError(error: errorMessage)));

    await pumpForexListScreen(tester);

    expect(find.byKey(ForexListKeys.error), findsOneWidget);
    expect(find.text(errorMessage), findsOneWidget);
  });
}

class MockForexPriceBloc extends Mock implements ForexPriceBloc {}
