import 'package:fl_chart/fl_chart.dart';
import 'package:inventory_management/widgets/charts/data.dart';

import '../../source.dart';

class PieChart2 extends StatelessWidget {
  const PieChart2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 300.dh, child: PieChart(data));
  }
}

final data = PieChartData(sections: sections);

final sections = chartData
    .map((e) => PieChartSectionData(
        value: e.value.toDouble(), title: '30%', color: Colors.blue))
    .toList();
