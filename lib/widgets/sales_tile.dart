import '../source.dart';

class RecordTile<T> extends StatelessWidget {
  const RecordTile(this.record,
      {required this.product, required this.documentPageAction, Key? key})
      : super(key: key);

  final dynamic record;
  final Product product;
  final PageActions documentPageAction;

  @override
  Widget build(BuildContext context) {
    return AppMaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 8.dh),
      isFilled: false,
      onPressed: () => push(T == Sales
          ? SalesPage(documentPageAction, sales: record)
          : PurchasesPage(documentPageAction, purchase: record)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(product.name, weight: FontWeight.w300),
              AppText(record.formattedTotal, weight: FontWeight.bold)
            ],
          ),
          SizedBox(height: 5.dh),
          AppText('${record.quantity} ${product.unit} @ ${record.unitPrice}',
              opacity: .7, size: 14.dw)
        ],
      ),
    );
  }
}
