import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fxtm_trader/src/core/theme/dimens.dart';
import 'package:fxtm_trader/src/features/forex_tracker/di/forex_dependencies.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/bloc/forex_price_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/forex_price_widget.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/models/forex_item_display_model.dart';
import 'package:fxtm_trader/src/routing/routes.dart';

class ForexListContentWidget extends StatelessWidget{

  final List<ForexItemDisplayModel> displayItems;

  const ForexListContentWidget({super.key, required this.displayItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: displayItems.length,
      itemBuilder: (context, index) => BlocProvider<ForexPriceBloc>(
        create: (context) => getIt<ForexPriceBloc>(),
        child: _ForexListItem(key: Key('forex_list_item_$index'), item: displayItems[index]),
      ),
    );
  }
}

class _ForexListItem extends StatelessWidget {
  final ForexItemDisplayModel item;

  const _ForexListItem({super.key, required this.item});
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.displaySymbol,
        style: const TextStyle(
          fontSize: Dimens.largeText,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        item.description,
        style: const TextStyle(fontSize: Dimens.large),
      ),
      trailing: SizedBox(
        width: _Constants.priceWidgetWidth,
        child: ForexPriceWidget(key: Key('forex_price_${item.symbol}'), symbol: item.symbol),
      ),
      onTap: () => Navigator.pushNamed(context, forexHistory, arguments: item.symbol), 
    );
  }  
}

abstract class _Constants {
  static double priceWidgetWidth = 150;
}