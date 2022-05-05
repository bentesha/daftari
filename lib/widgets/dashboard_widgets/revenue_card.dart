import 'package:inventory_management/source.dart';
import 'package:inventory_management/utils/extensions.dart/report_type.dart';
import '../charts/bar_chart.dart';
import '../charts/data.dart';

class RevenueCard extends StatelessWidget {
  const RevenueCard({Key? key}) : super(key: key);

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
          AppText('Revenue', size: 15.dw, weight: FontWeight.bold),
          AppText('By Category, March 2022',
              size: 14.dw, color: AppColors.onBackground2),
          AppDivider(margin: EdgeInsets.only(top: 5.dh, bottom: 10.dh)),
          CustomBarChart(getRevenueItems(),
              valueColor: AppColors.primaryVariant),
          AppDivider(margin: EdgeInsets.only(top: 5.dh, bottom: 10.dh)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText('Total: Tzs 300,000',
                  weight: FontWeight.bold,
                  size: 15.dw,
                  color: AppColors.onBackground2),
              AppButton(
                  onPressed: () =>
                      push(const ReportsPage(reportType: ReportType.sales)),
                  child: AppText('View Breakdown',
                      color: AppColors.primary, size: 15.dw),
                  radius: 8.dw,
                  highlightDetails: HighlightDetails(10.dw, 10.dh)),
            ],
          )
        ],
      ),
    );
  }
}
