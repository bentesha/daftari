import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/proportion_bar.dart';

class ProfitLossCard extends StatelessWidget {
  const ProfitLossCard({Key? key}) : super(key: key);

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
          AppText('Profit & Loss', size: 15.dw, weight: FontWeight.bold),
          AppText('March 2022', size: 14.dw, color: AppColors.onBackground2),
          AppDivider(margin: EdgeInsets.only(top: 5.dh, bottom: 20.dh)),
          const ProportionBar(
              title1: 'Net Profit',
              title2: 'Expenses',
              amount1: 300000,
              amount2: 200000)
        ],
      ),
    );
  }
}
