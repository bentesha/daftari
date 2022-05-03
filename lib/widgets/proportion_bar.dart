import 'package:inventory_management/source.dart';

class ProportionBar extends StatelessWidget {
  const ProportionBar(
      {Key? key,
      required this.title1,
      required this.title2,
      required this.amount1,
      required this.amount2})
      : super(key: key);

  final String title1, title2;
  final double amount1, amount2;

  double get total => amount1 + amount2;

  double get netProfitRatio => amount1 / total;

  int get netProfitPercent => (netProfitRatio * 100).toInt();

  int get expensePercent => ((1 - netProfitRatio) * 100).toInt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 30.dh,
          width: 360.dw,
          padding: EdgeInsets.only(right: 10.dw),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: const Color(0xff88292F),
              borderRadius: BorderRadius.all(Radius.circular(15.dw))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 350.dw * (netProfitRatio),
                height: 30.dh,
                padding: EdgeInsets.only(left: 10.dw),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: AppColors.primaryVariant,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.dw),
                        bottomLeft: Radius.circular(15.dw))),
                child: netProfitRatio < .8
                    ? AppText('$netProfitPercent %', color: AppColors.onPrimary)
                    : Container(),
              ),
              AppText('$expensePercent %', color: AppColors.onPrimary)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.dw, 10.dh, 10.dw, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildValues(title1, amount1, amount1 / total, false),
              _buildValues(title2, amount2, amount2 / total, true),
            ],
          ),
        )
      ],
    );
  }

  _buildValues(String title, double value, double percent, bool isExpense) {
    final formattedValue = Utils.convertToMoneyFormat(value);
    return Column(
      crossAxisAlignment:
          isExpense ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        AppText(title, size: 14.dw),
        SizedBox(height: 5.dh),
        AppText(formattedValue,
            size: 14.dw,
            weight: FontWeight.bold,
            color: AppColors.onBackground2),
      ],
    );
  }
}
