import '../source.dart';

class OpeningStockItemTile extends StatelessWidget {
  const OpeningStockItemTile(this.openingStockItem, {Key? key})
      : super(key: key);

  final OpeningStockItem openingStockItem;

  @override
  Widget build(BuildContext context) {
    final date = DateFormatter.convertToDMY(openingStockItem.date);
    final value = Utils.convertToMoneyFormat(openingStockItem.value);
    final unitPrice =
        Utils.convertToMoneyFormat(openingStockItem.product.unitPrice);
    final quantity = openingStockItem.product.quantity;

    return AppMaterialButton(
        isFilled: false,
        padding: EdgeInsets.symmetric(horizontal: 19.dw),
        child: ListTile(
            title: AppText(openingStockItem.product.name),
            subtitle: AppText('$date @ $quantity x $unitPrice',
                opacity: .7, size: 14.dw),
            trailing: AppText(value, weight: FontWeight.bold)),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    OpeningStockEditPage(openingStockItem: openingStockItem))));
  }
}
