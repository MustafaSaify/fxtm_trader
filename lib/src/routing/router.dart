import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/di/forex_provider.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_list_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/forex_list_screen.dart';
import 'package:fxtm_trader/src/routing/routes.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case forexList:
        setupForexDependencies();
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ForexListBloc>(
            create: (BuildContext context) => getIt<ForexListBloc>(),
            child: const ForexListScreen(),
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
