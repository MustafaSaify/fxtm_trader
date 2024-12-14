import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/di/forex_provider.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_list_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/bloc/forex_price_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/forex_list_screen.dart';
import 'package:fxtm_trader/src/routing/routes.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case forexList:
        setupForex();
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ForexListBloc>(
                create: (BuildContext context) =>
                    ForexListProvider().initForexListBloc(),
              ),
              BlocProvider<ForexPriceBloc>(
                  create: (BuildContext context) => getIt<
                      ForexPriceBloc>() //ForexPriceProvider().initForexPriceBloc(),
                  ),
            ],
            child: const ForexListScreen(),
          ),
        );
      case forexList:
        setupForex();
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ForexListBloc>(
                  create: (BuildContext context) =>
                      ForexListProvider().initForexListBloc(),
                  child: const ForexListScreen(),
                ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
