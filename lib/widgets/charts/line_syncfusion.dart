import 'package:syncfusion_flutter_charts/charts.dart';

import '../../source.dart';
import 'data.dart';

class LineChart3 extends StatelessWidget {
  const LineChart3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300.dh,
        child: SfCartesianChart(
          series: series,
        ));
  }
}

final series = [
  LineSeries<SalesData, num>(
      dataSource: chartData,
      xValueMapper: (sales, _) => sales.date.year,
      yValueMapper: (sales, _) => sales.value)
];
