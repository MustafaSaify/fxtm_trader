import 'package:flutter/widgets.dart';
import 'package:fxtm_trader/src/core/theme/dimens.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/models/forex_history_display_model.dart';
import 'package:interactive_chart/interactive_chart.dart';

class ForexHistoryContentWidget extends StatelessWidget {
  final ForexHistoryDisplayModel displayModel;

  const ForexHistoryContentWidget({super.key, required this.displayModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            displayModel.displaySymbol,
            style: const TextStyle(
              fontSize: Dimens.h4,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: Dimens.large),
          SizedBox(
            height: _Constants.chartHeight,
            child: InteractiveChart(
              candles: displayModel.candles
            ),
          )
        ],
      )
    );
  }
}

abstract class _Constants {
  static const double chartHeight = 400;
}
