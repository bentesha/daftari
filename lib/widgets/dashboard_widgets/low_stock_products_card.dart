import 'package:inventory_management/source.dart';

class LowStockProductsCard extends StatelessWidget {
  const LowStockProductsCard({Key? key}) : super(key: key);

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
          AppText('Low Stock Products', size: 15.dw, weight: FontWeight.bold),
          AppDivider(margin: EdgeInsets.only(top: 5.dh, bottom: 10.dh)),
          Column(
            children: [
              _buildProductDetails('Hill Water', 5),
              _buildProductDetails('Loft Breads', 3),
              _buildProductDetails('Staplers', 12),
              _buildProductDetails('Uhai Water Packs', 7)
            ],
          ),
          AppDivider.withVerticalMargin(5.dh),
          AppTextButton(
              onPressed: () {},
              text: 'View All',
              height: 40.dh,
              isFilled: false,
              borderRadius: BorderRadius.all(Radius.circular(15.dw)),
              textStyle: TextStyle(color: AppColors.primary, fontSize: 14.dw))
        ],
      ),
    );
  }

  _buildProductDetails(String product, int remaining) {
    return ListTile(
        title: AppText(product, size: 15.dw),
        trailing: AppText('$remaining items',
            size: 14.dw,
            weight: FontWeight.bold,
            color: AppColors.onBackground2));
  }
}
