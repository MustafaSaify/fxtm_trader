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
  late ForexListScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ForexListScreenBloc>(context);
    _dispatch(const LoadForexSymbols());
  }

  void _dispatch(LoadForexSymbols event) => _bloc.add(event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forex'),
      ),
      body: BlocBuilder<ForexListScreenBloc, ForexState>(
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
      return const _ForexListLoadingWidget(key: Key('forex_loading_widget'));
    } else if (state is ForexLoaded) {
      return ForexListContentWidget(displayItems: state.symbols);
    }
    return const _ForexListLoadingWidget(key: Key('forex_loading_widget'));
  }
}

class _ForexListLoadingWidget extends StatelessWidget {
  const _ForexListLoadingWidget({
    required super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator()
    );
  }
}
