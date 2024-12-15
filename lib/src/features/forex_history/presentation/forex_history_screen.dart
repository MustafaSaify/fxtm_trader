import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/bloc/forex_history_bloc.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/bloc/forex_history_event.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/bloc/forex_history_state.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/components/forex_history_content_widget.dart';

class ForexHistoryScreen extends StatefulWidget {
  final String symbol;

  const ForexHistoryScreen({super.key, required this.symbol});

  @override
  State<ForexHistoryScreen> createState() => _ForexHistoryScreenState();
}

class _ForexHistoryScreenState extends State<ForexHistoryScreen> {
  late ForexHistoryBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ForexHistoryBloc>();
    _dispatch(FetchHistoryData(widget.symbol));
  }

  void _dispatch(ForexHistoryEvent event) => _bloc.add(event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forex History'),
      ),
      body: BlocBuilder<ForexHistoryBloc, ForexHistoryState>(
        bloc: _bloc,
        builder: _onStateChangeBuilder,
      ),
    );
  }

  Widget _onStateChangeBuilder(
    BuildContext context,
    ForexHistoryState state,
  ) {
    return _buildState(state);
  }

  Widget _buildState(ForexHistoryState state) {
    if (state is ForexHistoryLoading) {
      return const _ForexHistoryLoadingWidget(key: ForexHistoryKeys.loading);
    } else if (state is ForexHistoryLoaded) {
      return ForexHistoryContentWidget(
          key: ForexHistoryKeys.loaded, displayModel: state.displayModel);
    } else if (state is ForexHistoryError) {
      return _ForexHistoryErrorWidget(
          key: ForexHistoryKeys.error, error: state.message);
    }
    return const _ForexHistoryErrorWidget(key: ForexHistoryKeys.error);
  }
}

class _ForexHistoryLoadingWidget extends StatelessWidget {
  const _ForexHistoryLoadingWidget({
    required super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ForexHistoryErrorWidget extends StatelessWidget {
  final String error;

  const _ForexHistoryErrorWidget(
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
  static const defaultErrorMessage = 'Error while fetching history.';
}

abstract class ForexHistoryKeys {
  static const loading = Key('forex_history_loading_key');
  static const loaded = Key('forex_history_loaded_key');
  static const error = Key('forex_history_error_key');
}
