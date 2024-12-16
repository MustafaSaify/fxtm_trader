import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/forex_history_screen.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/models/forex_history_display_model.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/models/forex_item_display_model.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/bloc/forex_history_bloc.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/bloc/forex_history_state.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/bloc/forex_history_event.dart';

class MockForexHistoryBloc
    extends MockBloc<ForexHistoryEvent, ForexHistoryState>
    implements ForexHistoryBloc {}

void main(dynamic timestamp) {
  late MockForexHistoryBloc mockBloc;
  const symbol = 'EUR/USD';

  ForexHistoryDisplayModel model =
      ForexHistoryDisplayModel(displaySymbol: symbol, candles: [
    CandleData(timestamp: 1, open: 1.2, close: 1.5, volume: null),
    CandleData(
      open: 1.1250,
      close: 1.1300,
      high: 1.1350,
      low: 1.1200,
      timestamp: 2,
      volume: null,
    ),
  ]);

  setUp(() {
    mockBloc = MockForexHistoryBloc();
    // Register fallback values for states
    registerFallbackValue(ForexHistoryLoading());
    registerFallbackValue(
        ForexHistoryLoaded(model)); // Add your model as necessary
    registerFallbackValue(ForexHistoryError('An error occurred'));
  });

  Future<void> pumpForexHistoryScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ForexHistoryBloc>(
          create: (_) => mockBloc,
          child: const ForexHistoryScreen(symbol: symbol),
        ),
      ),
    );
  }

  group('ForexHistoryScreen', () {
    testWidgets('shows loading widget when state is ForexHistoryLoading',
        (WidgetTester tester) async {
      // Mock the state to return loading
      when(() => mockBloc.state).thenReturn(ForexHistoryLoading());

      await pumpForexHistoryScreen(tester);

      // Verify the loading widget is shown
      expect(find.byKey(ForexHistoryKeys.loading), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows content when state is ForexHistoryLoaded',
        (WidgetTester tester) async {
      // Mock the state to return loaded
      when(() => mockBloc.state).thenReturn(ForexHistoryLoaded(model));
      await pumpForexHistoryScreen(tester);

      // Verify the loaded state is shown
      expect(find.byKey(ForexHistoryKeys.loaded), findsOneWidget);
    });

    testWidgets('shows error message when state is ForexHistoryError',
        (WidgetTester tester) async {
      // Mock the state to return an error
      when(() => mockBloc.state)
          .thenReturn(ForexHistoryError('An error occurred'));

      await pumpForexHistoryScreen(tester);

      // Verify the error state is shown
      expect(find.byKey(ForexHistoryKeys.error), findsOneWidget);
      expect(find.text('An error occurred'), findsOneWidget);
    });
  });
}
