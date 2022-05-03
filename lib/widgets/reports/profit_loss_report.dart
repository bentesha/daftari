import 'package:inventory_management/source.dart';

class ProfitLossReport extends StatelessWidget {
  const ProfitLossReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitles(),
        _buildValue('Revenue', 341500600),
        _buildValue('Cost of Goods Sold', 388900),
        const AppDivider.zeroMargin(color: AppColors.onBackground2),
        _buildValue('GROSS PROFIT', 1554700, true),
        _buildValue('Operating Expenses', 508800),
        const AppDivider.zeroMargin(color: AppColors.onBackground2),
        _buildValue('OPERATING PROFIT', 1045500, true),
        _buildValue('Interest & Tax', 45000),
        const AppDivider.zeroMargin(color: AppColors.onBackground2, height: 2),
        _buildValue('NET PROFIT', 1004000, true),
      ],
    );
  }

  _buildValue(String title, double value, [bool isTotal = false]) {
    return SizedBox(
      height: 40.dh,
      child: Row(
        children: [
          Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15.dw),
                  child: AppText(title, size: 15.dw))),
          Expanded(
              child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 15.dw),
                  child: AppText(Utils.convertToMoneyFormat(value),
                      size: 14.dw,
                      weight: isTotal ? FontWeight.bold : FontWeight.w500))),
        ],
      ),
    );
  }

  _buildTitles() {
    return Container(
      color: AppColors.surface,
      height: 50.dh,
      child: Row(
        children: [
          Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15.dw),
                  child: AppText('COMPONENT',
                      size: 16.dw, weight: FontWeight.bold))),
          Expanded(
              child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 15.dw),
                  child:
                      AppText('AMOUNT', size: 16.dw, weight: FontWeight.bold))),
        ],
      ),
    );
  }

}
