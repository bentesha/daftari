import 'package:fl_chart/fl_chart.dart';
import 'package:inventory_management/widgets/charts/data.dart';
import '../../source.dart';
import 'constants.dart';

class BarChart2 extends StatefulWidget {
  const BarChart2({Key? key}) : super(key: key);

  @override
  State<BarChart2> createState() => _BarChart2State();
}

class _BarChart2State extends State<BarChart2> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300.dh,
        padding: EdgeInsets.only(right: 15.dw),
        child: BarChart(_data()));
  }

  BarChartData _data() => BarChartData(
      alignment: BarChartAlignment.spaceEvenly,
      barGroups: _barGroups(),
      borderData: borderData,
      titlesData: titlesData,
      gridData: gridData,
      barTouchData: barTouchData);

  List<BarChartGroupData> _barGroups() => chartData
      .map((e) => BarChartGroupData(
          x: e.date.year, barRods: _barRods(e.value.toDouble())))
      .toList();

  List<BarChartRodData> _barRods(double y) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return [
      BarChartRodData(
          width: isPortrait ? null : 20.dw,
          toY: y,
          colors: [Colors.blue],
          borderRadius: BorderRadius.zero)
    ];
  }

  static final barTouchData = BarTouchData(
      touchTooltipData: BarTouchTooltipData(tooltipBgColor: Colors.white));
}
