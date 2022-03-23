import '../../source.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'data.dart';

class PieChart extends StatelessWidget {
  const PieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        width: ScreenSizeConfig.getFullWidth,
        child: charts.PieChart<String>(series,
            animate: true,
            defaultRenderer: charts.ArcRendererConfig(arcRendererDecorators: [
              charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.outside)
            ])));
  }
}

List<charts.Series<SalesData, String>> series = [
  charts.Series(
    id: "sales",
    data: chartData,
    domainFn: (SalesData series, _) => series.percent,
    measureFn: (SalesData series, _) => series.value,
    // colorFn: (Sales series, _) => series.barColor
  )
];
