import 'package:inventory_management/widgets/charts/data.dart';
import '../../source.dart';
import 'package:fl_chart/fl_chart.dart';

import 'constants.dart';

class LineChart2 extends StatelessWidget {
  const LineChart2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.dh,
      margin: EdgeInsets.only(right: 15.dw),
      child: LineChart(data),
    );
  }
}

final data = LineChartData(
  minY: 0,
  lineBarsData: lineBarChartData,
  titlesData: titlesData,
  borderData: borderData,
  lineTouchData: lineTouchData,
  gridData: gridData,
);

final lineBarChartData = [
  LineChartBarData(
      spots: spotList, colors: [Colors.blue], dotData: FlDotData(show: false))
];

final spotList = chartData
    .map((e) => FlSpot(e.date.year.toDouble(), e.doubleValue))
    .toList();
