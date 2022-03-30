import 'package:inventory_management/source.dart';

import 'bar_rod.dart';
import 'data.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart(this.itemData, {required this.valueColor, Key? key})
      : super(key: key);

  final List<ItemData> itemData;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.dh,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: itemData
              .map((e) => BarRod(
                  valueColor: /* const Color(0xff6E71D8)*/ valueColor,
                  lineColor: AppColors.onBackground2,
                  value: e.doublePercent,
                  title: e.item.name))
              .toList()),
    );
  }
}
