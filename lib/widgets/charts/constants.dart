import 'package:fl_chart/fl_chart.dart';

import '../../source.dart';

final titlesData = FlTitlesData(
  topTitles: SideTitles(showTitles: false),
  rightTitles: SideTitles(showTitles: false),
  bottomTitles: SideTitles(showTitles: true, getTitles: _getBottomTitles),
  leftTitles: SideTitles(
      showTitles: true,
      getTitles: _getLeftTitles,
      reservedSize: 60.dw,
      getTextStyles: _getTextStyles),
);

String _getBottomTitles(double value) {
  return value.toInt().toString();
}

String _getLeftTitles(double sales) {
  final isInterval = (sales / 3).toString().endsWith('.0');
  final formatted = Utils.convertToMoneyFormat(sales, false);
  return !isInterval ? '' : formatted;
}

TextStyle _getTextStyles(BuildContext context, double value) =>
    TextStyle(fontSize: 13.dw);

final borderData = FlBorderData(
    border: const Border(bottom: BorderSide(width: 1, color: Colors.black)));

final lineTouchData = LineTouchData(
    touchTooltipData: LineTouchTooltipData(tooltipBgColor: Colors.white));

bool checkToShowVerticalLine(double value) {
  return (value / 3).toString().endsWith('.0');
}

final gridData = FlGridData(
    show: true,
    checkToShowHorizontalLine: checkToShowVerticalLine,
    drawVerticalLine: false);
