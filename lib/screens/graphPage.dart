import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../backend/cryptoData.dart';
import '../backend/marketHelper.dart';
import '../backend/prices.dart';
import '../theme/themeHelper.dart';

class GraphDetails extends StatefulWidget {
  final String id;
  final CryptoData crypto;
  const GraphDetails({super.key, required this.id, required this.crypto});

  @override
  State<GraphDetails> createState() => _GraphDetailsState();
}

class _GraphDetailsState extends State<GraphDetails> {
  @override
  Widget build(BuildContext context) {
    ThemeHelper themeProvider = Provider.of<ThemeHelper>(context, listen: true);

    return Consumer<MarketHelper>(
      builder: (context, marketInstance, child) {
        marketInstance.getGraph(widget.id);
        return Padding(
          padding: const EdgeInsets.only(
            right: 8,
          ),
          child: SfCartesianChart(
            borderColor:
                (widget.crypto.priceChange24h! > 0) ? Colors.green : Colors.red,
            enableAxisAnimation: true,
            plotAreaBorderColor: themeProvider.themeMode == ThemeMode.light
                ? Colors.black
                : Colors.white,
            plotAreaBackgroundColor: Colors.transparent,
            palette: [
              (widget.crypto.priceChange24h! > 0) ? Colors.green : Colors.red
            ],
            primaryXAxis: DateTimeAxis(
              majorGridLines: const MajorGridLines(
                width: 1,
              ),
              title: AxisTitle(
                  text: "Days",
                  textStyle: const TextStyle(fontFamily: "Quicksand")),
            ),
            primaryYAxis:
                NumericAxis(majorGridLines: const MajorGridLines(width: 1)),
            series: <ChartSeries>[
              LineSeries<Price, dynamic>(
                  dataSource: marketInstance.prices,
                  xValueMapper: (Price price, _) =>
                      DateTime.fromMillisecondsSinceEpoch((price.time).toInt()),
                  yValueMapper: (Price price, _) => price.value)
            ],
          ),
        );
      },
    );
  }
}
