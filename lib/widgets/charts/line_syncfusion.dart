import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
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
          tooltipBehavior: TooltipBehavior(
              enable: true, color: Colors.white, textStyle: toolTipTextStyle),
          primaryXAxis: NumericAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              labelStyle: textStyle),
          primaryYAxis: NumericAxis(
              labelStyle: textStyle,
              desiredIntervals: 3,
              numberFormat:
                  NumberFormat.currency(decimalDigits: 0, symbol: '')),
        ));
  }
}

final series = [
  LineSeries<SalesData, num>(
    name: 'Sales',
    color: Colors.blue,
    dataSource: chartData,
    enableTooltip: true,
    xValueMapper: (sales, _) => sales.date.year,
    yValueMapper: (sales, _) => sales.value,
  )
];

final toolTipTextStyle = TextStyle(
    fontSize: 14.dw, fontFamily: kFontFam2, color: AppColors.primary);

final textStyle = TextStyle(
    fontSize: 12.dw,
    fontFamily: kFontFam,
    color: AppColors.onBackground);
