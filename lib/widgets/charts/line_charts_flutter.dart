import 'package:charts_flutter/flutter.dart' as charts;
import '../../source.dart';
import 'data.dart';

class LineChart extends StatelessWidget {
  const LineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300.dh,
        child: charts.LineChart(series,
            domainAxis: const charts.NumericAxisSpec(
              tickProviderSpec:
                  charts.BasicNumericTickProviderSpec(zeroBound: false),
              //viewport: charts.NumericExtents(2016.0, 2022.0),
            ),
            animate: true));
  }
}

List<charts.Series<SalesData, num>> series = [
  charts.Series(
    id: "sales",
    data: chartData,
    domainFn: (SalesData series, _) => series.date.year,
    measureFn: (SalesData series, _) => series.value,
    // colorFn: (Sales series, _) => series.barColor
  )
];
