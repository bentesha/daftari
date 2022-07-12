import 'package:intl/intl.dart';
import 'package:inventory_management/source.dart';

import '../../models/profit_data.dart';

class ProfitLossCard extends StatelessWidget {
  final ProfitData profitData;
  const ProfitLossCard(this.profitData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final thisMonth = DateFormat('MMMM, yyyy').format(now);

    return Container(
      margin: EdgeInsets.all(10.dw),
      padding: EdgeInsets.all(10.dw),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.all(Radius.circular(10.dw))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText('Profit & Loss', size: 15.dw, weight: FontWeight.bold),
          AppText(thisMonth, size: 14.dw, color: AppColors.onBackground2),
          AppDivider(margin: EdgeInsets.only(top: 5.dh, bottom: 20.dh)),
          Center(
            child: AppText(Utils.convertToMoneyFormat(profitData.getProfit),
                weight: FontWeight.bold, size: 24.dw),
          ),
          SizedBox(height: 10.dh),
          const Center(child: AppText('( Net profit )')),
          AppDivider(margin: EdgeInsets.only(top: 10.dh, bottom: 5.dh)),
          AppTextButton(
            onPressed: () =>
                push(const ReportsPage(reportType: ReportType.profitLoss)),
            text: 'View Report',
            height: 40.dh,
            isFilled: false,
            borderRadius: BorderRadius.all(Radius.circular(15.dw)),
            textStyle: TextStyle(color: AppColors.primary, fontSize: 15.dw),
          )
        ],
      ),
    );
  }
}
