import '../source.dart';

class SalesTile extends StatelessWidget {
  const SalesTile(this.sales,
      {required this.product, required this.action, Key? key})
      : super(key: key);

  final Sales sales;
  final Product product;
  final PageActions action;

  @override
  Widget build(BuildContext context) {
    return AppMaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 8.dh),
      isFilled: false,
      onPressed: () => push(SalesPage(action, sales: sales)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(product.name, weight: FontWeight.w300),
              AppText(sales.formattedTotal, weight: FontWeight.bold)
            ],
          ),
          SizedBox(height: 5.dh),
          AppText('${sales.quantity} ${product.unit} @ ${sales.unitPrice}',
              opacity: .7, size: 14.dw)
        ],
      ),
    );
  }
}
