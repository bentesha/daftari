import 'package:syncfusion_flutter_charts/charts.dart';
import '../../source.dart';
import 'data.dart';
import 'package:intl/intl.dart';

class PieChart3 extends StatelessWidget {
  final List<ItemData> pieChartData;
  const PieChart3(this.pieChartData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300.dh,
        child: SfCircularChart(
          series: series,
          tooltipBehavior: TooltipBehavior(
              enable: true, color: Colors.white, textStyle: toolTipTextStyle),
          legend: Legend(
              position: LegendPosition.bottom,
              isVisible: true,
              height: '40%',
              textStyle: textStyle,
              overflowMode: LegendItemOverflowMode.wrap),
        ));
  }

  get series => [
        PieSeries<ItemData, String>(
            name: 'Revenue',
            dataSource: pieChartData,
            dataLabelSettings:
                DataLabelSettings(isVisible: true, textStyle: textStyle),
            xValueMapper: (itemData, _) => itemData.item.name,
            yValueMapper: (itemData, _) => itemData.value,
            dataLabelMapper: (item, __) => item.percent)
      ];
}

final toolTipTextStyle = TextStyle(
    fontSize: 14.dw, fontFamily: Constants.kFontFam2, color: AppColors.primary);

final textStyle = TextStyle(
    fontSize: 12.dw,
    fontFamily: Constants.kFontFam,
    color: AppColors.onBackground);
