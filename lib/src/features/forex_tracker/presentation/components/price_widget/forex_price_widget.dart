import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/core/theme/dimens.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/bloc/forex_price_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/bloc/forex_price_event.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/bloc/forex_price_state.dart';

class ForexPriceWidget extends StatefulWidget{
  final String symbol;

  const ForexPriceWidget({super.key, required this.symbol});
  
  @override
  State<ForexPriceWidget> createState() => _ForexPriceWidgetState();
}

class _ForexPriceWidgetState extends State<ForexPriceWidget> {
  late ForexPriceBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<ForexPriceBloc>(context);

    _dispatch(SubscribeToPrice(widget.symbol));
  }

  void _dispatch(ForexPriceEvent event) => _bloc.add(event);

  @override
  Widget build(BuildContext context) {
    _dispatch(SubscribeToPrice(widget.symbol));

    return BlocBuilder<ForexPriceBloc, ForexPriceState>(
      bloc: _bloc,
      buildWhen: (previous, current) => true, // Always rebuild on new state
      builder: _onStateChangeBuilder,
    );
  }

  Widget _onStateChangeBuilder(
    BuildContext context,
    ForexPriceState state,
  ) {
    return _buildState(context, state);
  }

  Widget _buildState(BuildContext context, ForexPriceState state) {
    if (state is PriceLoading) {
      return const Center(
        child: SizedBox(
          height: Dimens.large,
          width: Dimens.large,
          child: Center(
            child: CircularProgressIndicator()
          ),
        ),
      );
    } else if (state is PriceLoaded) {
      return Text(
        state.price,
        style: const TextStyle(
          fontSize: Dimens.largeText,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.right,
      );
    } else {
      return const Text(
        '-',
        style: TextStyle(
          fontSize: Dimens.large,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
