import '../source.dart';

class OpeningStockItemTile extends StatelessWidget {
  const OpeningStockItemTile(this.openingStockItem, {Key? key})
      : super(key: key);

  final OpeningStockItem openingStockItem;

  @override
  Widget build(BuildContext context) {
    final date = DateFormatter.convertToDMY(openingStockItem.date);
    final totalValue = Utils.convertToMoneyFormat(openingStockItem.totalValue);
    final unitValue = Utils.convertToMoneyFormat(openingStockItem.unitValue);
    final quantity = openingStockItem.quantity;

    return AppMaterialButton(
        isFilled: false,
        padding: EdgeInsets.symmetric(horizontal: 19.dw),
        child: ListTile(
            title: AppText(openingStockItem.product.name),
            subtitle: AppText('$date @ $quantity x $unitValue',
                opacity: .7, size: 14.dw),
            trailing: AppText(totalValue, weight: FontWeight.bold)),
        onPressed: () =>
            push(OpeningStockEditPage(openingStockItem: openingStockItem)));
  }
}
