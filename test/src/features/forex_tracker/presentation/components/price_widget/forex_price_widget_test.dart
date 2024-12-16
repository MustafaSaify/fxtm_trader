import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/bloc/forex_price_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/bloc/forex_price_event.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/bloc/forex_price_state.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/forex_price_widget.dart';
import 'package:mocktail/mocktail.dart';

// Assuming ForexPriceBloc and states are already defined
class MockForexPriceBloc extends MockBloc<ForexPriceEvent, ForexPriceState>
    implements ForexPriceBloc {}

void main() {
  String errorMessage = 'An error occurred';
  String price = '1.10';

  group('ForexPriceWidget', () {
    late MockForexPriceBloc mockBloc;
    const symbol = 'USD/EUR';

    setUp(() {
      // Register any states you plan to use with mocktail
      registerFallbackValue(PriceLoading());
      registerFallbackValue(PriceLoaded(price: price));
      registerFallbackValue(PriceError(errorMessage));

      mockBloc = MockForexPriceBloc();
    });

    testWidgets('shows loading state initially', (WidgetTester tester) async {
      // Set up the bloc state to simulate loading
      when(() => mockBloc.state).thenReturn(PriceLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ForexPriceBloc>(
            create: (_) => mockBloc,
            child: const ForexPriceWidget(symbol: symbol),
          ),
        ),
      );

      // Verify that the loading state is shown
      expect(find.byKey(ForexPriceWidgetKeys.loading), findsOneWidget);
      expect(find.text('--'), findsOneWidget);
    });

    testWidgets('shows loaded price when price is available',
        (WidgetTester tester) async {
      // Set up the bloc state to simulate loaded price
      when(() => mockBloc.state).thenReturn(PriceLoaded(price: price));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ForexPriceBloc>(
            create: (_) => mockBloc,
            child: const ForexPriceWidget(symbol: symbol),
          ),
        ),
      );

      // Verify that the loaded price is displayed
      expect(find.byKey(ForexPriceWidgetKeys.loaded), findsOneWidget);
      expect(find.text(price), findsOneWidget);
    });

    testWidgets('shows error message when there is an error',
        (WidgetTester tester) async {
      // Set up the bloc state to simulate error
      when(() => mockBloc.state).thenReturn(PriceError(errorMessage));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ForexPriceBloc>(
            create: (_) => mockBloc,
            child: const ForexPriceWidget(symbol: symbol),
          ),
        ),
      );

      // Verify that the error message is shown
      expect(find.byKey(ForexPriceWidgetKeys.error), findsOneWidget);
      expect(find.text('Error!!'), findsOneWidget);
    });
  });
}
