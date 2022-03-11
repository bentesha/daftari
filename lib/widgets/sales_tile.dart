import '../source.dart';

class SalesTile extends StatelessWidget {
  const SalesTile(this.sales, {Key? key}) : super(key: key);

  final Sales sales;

  @override
  Widget build(BuildContext context) {
    final item = sales.product;

    return AppMaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 8.dh),
      isFilled: false,
      onPressed: () => push(SalesEditPage(sales: sales)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(item.name, weight: FontWeight.w300),
              AppText(sales.formattedTotal, weight: FontWeight.bold)
            ],
          ),
          SizedBox(height: 5.dh),
          AppText('${sales.quantity} ${item.unit} @ ${sales.total}',
              opacity: .7, size: 14.dw)
        ],
      ),
    );
  }
}
