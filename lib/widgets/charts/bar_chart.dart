import 'package:inventory_management/models/breakdown_data.dart';
import 'package:inventory_management/source.dart';

import 'bar_rod.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart(this.itemData, {required this.valueColor, Key? key})
      : super(key: key);

  final List<BreakdownData> itemData;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.dh,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: itemData
              .map((e) => BarRod(
                  valueColor: valueColor,
                  lineColor: AppColors.onBackground2,
                  value: e.percent,
                  title: e.name))
              .toList()),
    );
  }
}
