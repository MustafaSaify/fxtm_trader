import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fxtm_trader/src/core/theme/dimens.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/entities/forex_symbol.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/forex_price_widget.dart';

class ForexListContentWidget extends StatelessWidget{

  final List<ForexSymbol> displayItems;

  const ForexListContentWidget({super.key, required this.displayItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: displayItems.length,
      itemBuilder: (context, index) {
        final item = displayItems[index];
        return ListTile(
          title: Text(
            item.symbol,
            style: const TextStyle(
              fontSize: Dimens.largeText,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            item.displaySymbol,
            style: const TextStyle(fontSize: Dimens.large),
          ),
          trailing: SizedBox(
            width: 100,
            child: ForexPriceWidget(symbol: item.symbol),
          ) 
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ListView.builder(
  //     itemCount: displayItems.length,
  //     itemBuilder: (context, index) {
  //       final item = displayItems[index];
  //       return Padding(
  //         padding: const EdgeInsets.all(Dimens.small),
  //         child: Row(
  //           mainAxisSize: MainAxisSize.max,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   item.symbol,
  //                   style: const TextStyle(
  //                     fontSize: Dimens.largeText,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 const SizedBox(height: Dimens.small),
  //                 Text(
  //                   item.displaySymbol,
  //                   style: const TextStyle(fontSize: Dimens.large),
  //                 ),
  //               ],
  //             ),
  //             Expanded(
  //               child: ForexPriceWidget(symbol: item.symbol)
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}