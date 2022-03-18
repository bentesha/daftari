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
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      isFilled: false,
      onPressed: () => push(T == Sales
          ? SalesPage(documentPageAction, sales: record)
          : PurchasesPage(documentPageAction, purchase: record)),
      child: ListTile(
          title: AppText(product.name, weight: FontWeight.w300),
          trailing: AppText(record.formattedTotal, weight: FontWeight.bold),
          subtitle: AppText(
              '${record.quantity} ${product.unit} @ ${record.unitPrice}',
              opacity: .7,
              size: 14.dw)),
    );
  }
}
