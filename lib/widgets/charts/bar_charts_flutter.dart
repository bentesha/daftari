import 'package:charts_flutter/flutter.dart' as charts;
import '../../source.dart';
import 'data.dart';

class BarChart extends StatelessWidget {
  const BarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.dh,
      child: charts.BarChart(
        data,
        animate: true,
      ),
    );
  }

  static final data = [
    charts.Series<dynamic, String>(
      id: "sales",
      data: chartData,
      domainFn: (series, _) => series.date.year.toString(),
      measureFn: (series, _) => series.value,
      // colorFn: (Sales series, _) => series.barColor
    )
  ];
}
