import 'package:inventory_management/source.dart';

import '../../../models/recent_sales.dart';

class RecentSalesCard extends StatelessWidget {
  final List<RecentSale> recentSales;
  const RecentSalesCard(this.recentSales, {Key? key}) : super(key: key);

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
          AppText('Recent Sales', size: 15.dw, weight: FontWeight.bold),
          AppDivider(margin: EdgeInsets.only(top: 5.dh, bottom: 10.dh)),
          Column(
              children: List.generate(recentSales.length,
                  (index) => _buildProductDetails(recentSales[index]))),
          AppDivider.withVerticalMargin(5.dh),
          AppTextButton(
            onPressed: () => push(const SalesDocumentsPage()),
            text: 'View All',
            height: 40.dh,
            isFilled: false,
            borderRadius: BorderRadius.all(Radius.circular(15.dw)),
            textStyle: TextStyle(color: AppColors.primary, fontSize: 15.dw),
          )
        ],
      ),
    );
  }

  _buildProductDetails(RecentSale sale) {
    final formatted = Utils.convertToMoneyFormat(sale.total);
    return ListTile(
        title: Text(sale.productName),
        trailing: AppText(formatted,
            size: 14.dw,
            weight: FontWeight.bold,
            color: AppColors.onBackground2));
  }
}
