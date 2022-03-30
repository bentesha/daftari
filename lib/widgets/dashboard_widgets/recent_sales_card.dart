import 'package:inventory_management/source.dart';

class RecentSalesCard extends StatelessWidget {
  const RecentSalesCard({Key? key}) : super(key: key);

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
            children: [
              _buildProductDetails('Hill Water', '9:30 AM', 3000),
              _buildProductDetails('Loft Breads', '8:45 AM', 4500),
              _buildProductDetails('Staplers', '7: 21 AM', 4800),
              _buildProductDetails(
                  'Uhai Water Packs', 'Yesterday, 11:49 PM', 21000)
            ],
          ),
          AppDivider.withVerticalMargin(5.dh),
          AppTextButton(
            onPressed: () {},
            text: 'View All',
            height: 40.dh,
            isFilled: false,
            borderRadius: BorderRadius.all(Radius.circular(15.dw)),
            textStyle: TextStyle(color: AppColors.primary, fontSize: 14.dw),
          )
        ],
      ),
    );
  }

  _buildProductDetails(String product, String date, double price) {
    final formatted = Utils.convertToMoneyFormat(price);
    return ListTile(
        title: AppText(product, size: 15.dw),
        subtitle: AppText(date, size: 13.dw, color: AppColors.onBackground2),
        trailing: AppText(formatted,
            size: 14.dw,
            weight: FontWeight.bold,
            color: AppColors.onBackground2));
  }
}
