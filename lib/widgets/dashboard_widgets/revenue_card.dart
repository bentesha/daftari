import 'package:inventory_management/source.dart';

import '../charts/bar_chart.dart';
import '../charts/data.dart';

class RevenueCard extends StatelessWidget {
  const RevenueCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.dw),
      padding: EdgeInsets.all(10.dw),
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
          AppDivider.withVerticalMargin(5.dh),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText('Total: Tzs 300,000',
                  weight: FontWeight.bold,
                  size: 15.dw,
                  color: AppColors.onBackground2),
              AppTextButton(
                  onPressed: () {},
                  text: 'View Breakdown',
                  height: 40.dh,
                  isFilled: false,
                  borderRadius: BorderRadius.all(Radius.circular(15.dw)),
                  textStyle:
                      TextStyle(color: AppColors.primary, fontSize: 14.dw),
                  margin: EdgeInsets.only(left: 10.dw)),
            ],
          )
        ],
      ),
    );
  }
}
