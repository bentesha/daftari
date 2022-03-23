import 'package:syncfusion_flutter_charts/charts.dart';
import '../../source.dart';
import 'data.dart';
import 'package:intl/intl.dart';

class BarChart3 extends StatelessWidget {
  const BarChart3({Key? key}) : super(key: key);

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
              //   numberFormat: NumberFormat.currency(decimalDigits: 0, symbol: ''),
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
  ColumnSeries<SalesData, num>(
    name: 'Sales',
    color: Colors.blue,
    dataSource: chartData,
    enableTooltip: true,
    xValueMapper: (sales, _) => sales.date.year,
    yValueMapper: (sales, _) => sales.value,
  )
];

final toolTipTextStyle = TextStyle(
    fontSize: 14.dw, fontFamily: Constants.kFontFam2, color: AppColors.primary);

final textStyle = TextStyle(
    fontSize: 12.dw,
    fontFamily: Constants.kFontFam,
    color: AppColors.onBackground);
