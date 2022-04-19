import 'package:inventory_management/pages/breakdown_page.dart';
import 'package:inventory_management/source.dart';

import '../charts/bar_chart.dart';
import '../charts/data.dart';

class ExpensesCard extends StatelessWidget {
  const ExpensesCard({Key? key}) : super(key: key);

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
          AppText('Expenses', size: 15.dw, weight: FontWeight.bold),
          AppText('By Category, March 2022',
              size: 14.dw, color: AppColors.onBackground2),
          AppDivider(margin: EdgeInsets.only(top: 5.dh, bottom: 10.dh)),
          CustomBarChart(getItems(), valueColor: const Color(0xff88292F)),
          AppDivider.withVerticalMargin(5.dh),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText('Total: Tzs 200,000',
                  weight: FontWeight.bold,
                  size: 15.dw,
                  color: AppColors.onBackground2),
              AppTextButton(
                  onPressed: () => push( const BreakDownPage(false)),
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
