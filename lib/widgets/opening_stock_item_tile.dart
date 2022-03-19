import '../source.dart';

class OpeningStockItemTile extends StatelessWidget {
  const OpeningStockItemTile(this.openingStockItem,
      {required this.product, Key? key})
      : super(key: key);

  final OpeningStockItem openingStockItem;
  final Product product;

  @override
  Widget build(BuildContext context) {
    final date = openingStockItem.formattedDate;
    final quantity = openingStockItem.quantity;
    final unitValue = openingStockItem.formattedUnitValue;
    return AppMaterialButton(
        isFilled: false,
        padding: EdgeInsets.symmetric(horizontal: 19.dw),
        child: ListTile(
            title: AppText(product.name),
            subtitle: AppText('$date @ $quantity x $unitValue',
                opacity: .7, size: 14.dw),
            trailing: AppText(openingStockItem.formattedTotal,
                weight: FontWeight.bold)),
        onPressed: () =>
            push(OpeningStockItemPage(openingStockItem: openingStockItem)));
  }
}
