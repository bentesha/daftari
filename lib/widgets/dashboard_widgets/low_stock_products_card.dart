import 'package:inventory_management/source.dart';

class LowStockProductsCard extends StatelessWidget {
  final List<Product> products;
  const LowStockProductsCard(this.products, {Key? key}) : super(key: key);

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
              children: List.generate(products.length,
                  (index) => _buildProductDetails(products[index]))),
          AppDivider.withVerticalMargin(5.dh),
          AppTextButton(
              onPressed: () => push(
                  const ReportsPage(reportType: ReportType.remainingStock)),
              text: 'View All',
              height: 40.dh,
              isFilled: false,
              borderRadius: BorderRadius.all(Radius.circular(15.dw)),
              textStyle: TextStyle(color: AppColors.primary, fontSize: 15.dw))
        ],
      ),
    );
  }

  _buildProductDetails(Product product) {
    return ListTile(
        title: AppText(product.name, size: 15.dw),
        trailing: AppText('${product.stockQuantity}',
            size: 14.dw,
            weight: FontWeight.bold,
            color: AppColors.onBackground2));
  }
}
