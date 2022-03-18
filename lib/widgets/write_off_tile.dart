import '../source.dart';

class WriteOffTile extends StatelessWidget {
  const WriteOffTile(this.record,
      {required this.product, required this.documentPageAction, Key? key})
      : super(key: key);

  final dynamic record;
  final Product product;
  final PageActions documentPageAction;

  @override
  Widget build(BuildContext context) {
    return AppMaterialButton(
        isFilled: false,
        padding: EdgeInsets.symmetric(horizontal: 19.dw),
        child: ListTile(
            title: AppText(product.name),
            trailing:
                AppText(record.quantity.toString(), weight: FontWeight.bold)),
        onPressed: () =>
            push(WriteOffPage(documentPageAction, writeOff: record)));
  }
}
