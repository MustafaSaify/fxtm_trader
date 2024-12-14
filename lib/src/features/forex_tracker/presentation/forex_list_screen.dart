import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_list_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_event.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_state.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/forex_list_content_widget.dart';

class ForexListScreen extends StatefulWidget {
  const ForexListScreen({super.key});

  @override
  State<ForexListScreen> createState() => _ForexListScreenState();
}

class _ForexListScreenState extends State<ForexListScreen> {
  late ForexListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ForexListBloc>();
    _dispatch(LoadForexSymbols(exchange: _Constants.defaultExchange));
  }

  void _dispatch(LoadForexSymbols event) => _bloc.add(event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forex'),
      ),
      body: BlocBuilder<ForexListBloc, ForexState>(
        bloc: _bloc,
        builder: _onStateChangeBuilder,
      ),
    );
  }

  Widget _onStateChangeBuilder(
    BuildContext context,
    ForexState state,
  ) {
    return _buildState(state);
  }

  Widget _buildState(ForexState state) {
    if (state is ForexLoading) {
      return const _ForexListLoadingWidget(key: ForexListKeys.loading);
    } else if (state is ForexLoaded) {
      return ForexListContentWidget(
          key: ForexListKeys.loaded, displayItems: state.displayItems);
    } else if (state is ForexError) {
      return _ForexListErrorWidget(
          key: ForexListKeys.error, error: state.error);
    }
    return const _ForexListErrorWidget(key: ForexListKeys.error);
  }
}

class _ForexListLoadingWidget extends StatelessWidget {
  const _ForexListLoadingWidget({
    required super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ForexListErrorWidget extends StatelessWidget {
  final String error;

  const _ForexListErrorWidget(
      {required super.key, this.error = _Constants.defaultErrorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      key: key,
      child: Text(error),
    );
  }
}

abstract class _Constants {
  static const defaultExchange = 'oanda';
  static const defaultErrorMessage = 'Error while fetching symbols.';
}

abstract class ForexListKeys {
  static const loading = Key('forex_loading_key');
  static const loaded = Key('forex_loaded_key');
  static const error = Key('forex_error_key');
}
