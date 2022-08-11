import 'package:inventory_management/models/today_statistics.dart';

import '../../../source.dart';

class TodayStatsCard extends StatelessWidget {
  final TodayStatistics stats;
  const TodayStatsCard(this.stats, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.dw),
      padding: EdgeInsets.fromLTRB(10.dw, 10.dh, 10.dw, 15.dh),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.all(Radius.circular(10.dw))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText("Today Stats", size: 15.dw, weight: FontWeight.bold),
          AppText(stats.date, size: 14.dw, color: AppColors.onBackground2),
          AppDivider(margin: EdgeInsets.only(top: 5.dh, bottom: 10.dh)),
          _buildStatsTile("Sales", stats.formattedSales),
          _buildStatsTile("Expenses", stats.formattedExpenses),
          _buildStatsTile("Purchases", stats.formattedPurchases),
        ],
      ),
    );
  }

  _buildStatsTile(String label, String value) {
    return ListTile(
        title: Text(label),
        trailing: AppText(value,
            size: 14.dw,
            weight: FontWeight.bold,
            color: AppColors.onBackground2));
  }
}
