import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/features/forex_history/di/forex_history_dependencies.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/bloc/forex_history_bloc.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/forex_history_screen.dart';
import 'package:fxtm_trader/src/features/forex_tracker/di/forex_dependencies.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_list_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/forex_list_screen.dart';
import 'package:fxtm_trader/src/routing/routes.dart';
import 'package:get_it/get_it.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case forexList:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ForexListBloc>(
            create: (BuildContext context) => GetIt.I<ForexListBloc>(),
            child: const ForexListScreen(),
          ));
      case forexHistory:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ForexHistoryBloc>(
            create: (BuildContext context) => GetIt.I<ForexHistoryBloc>(),
            child: ForexHistoryScreen(symbol: settings.arguments as String),
          ));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}')
            ),
          ));
    }
  }
}
