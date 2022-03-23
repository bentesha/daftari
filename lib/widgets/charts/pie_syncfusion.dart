import 'package:syncfusion_flutter_charts/charts.dart';
import '../../source.dart';
import 'data.dart';
import 'package:intl/intl.dart';

class PieChart3 extends StatelessWidget {
  const PieChart3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300.dh,
        child: SfCircularChart(
          series: series,
          tooltipBehavior: TooltipBehavior(
              enable: true, color: Colors.white, textStyle: toolTipTextStyle),
          legend: Legend(
              isVisible: true, overflowMode: LegendItemOverflowMode.wrap),

          //primaryXAxis: CategoryAxis(),
          /* primaryXAxis: NumericAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              //   numberFormat: NumberFormat.currency(decimalDigits: 0, symbol: ''),
              labelStyle: textStyle),
          primaryYAxis: NumericAxis(
              labelStyle: textStyle,
              desiredIntervals: 3,
              numberFormat:
                  NumberFormat.currency(decimalDigits: 0, symbol: '')),*/
        ));
  }
}

final series = [
/*  DoughnutSeries<SalesData, num>(
    name: 'Sales',
    dataSource: chartData,
    explodeAll: true,
    enableTooltip: true,
    xValueMapper: (sales, _) => sales.date.year,
    yValueMapper: (sales, _) => sales.value,
    dataLabelMapper: (_, __) => '30%'
  )*/
  PieSeries<SalesData, String>(
      name: 'Sales',
      dataSource: chartData,
      dataLabelSettings:
          DataLabelSettings(isVisible: true, textStyle: textStyle),
      xValueMapper: (sales, _) => sales.date.year.toString(),
      yValueMapper: (sales, _) => sales.value,
      dataLabelMapper: (sales, __) => sales.percent)
];

final toolTipTextStyle = TextStyle(
    fontSize: 14.dw, fontFamily: Constants.kFontFam2, color: AppColors.primary);

final textStyle = TextStyle(
    fontSize: 12.dw,
    fontFamily: Constants.kFontFam,
    color: AppColors.onBackground);
